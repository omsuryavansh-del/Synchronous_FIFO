import f_pkg::*;

class environment;
    
    virtual fifo_if f_if;
    generator gen;
    driver dr;
    monitor mon;
    scoreboard scb;

    mailbox gen_to_drv;
    mailbox mon_to_scb;

    function new();

        gen = new();
        dr = new();
        mon = new();
        scb = new();
        gen_to_drv = new();
        mon_to_scb = new();

        gen.gen_to_drv = gen_to_drv;
        dr.driver_mbx = gen_to_drv;

        mon.mon_to_scb = mon_to_scb;
        scb.scbm = mon_to_scb;

    endfunction

    function void connect();
    dr.f_if = f_if;
    mon.f_if = f_if;
    endfunction

    task random();
        int target = scb.num_checked + 10;
        fork
        gen.generator(10);
        dr.drive();
        mon.monitor();
        scb.check();
        join_none
        wait(scb.num_checked == target);
        disable fork;
        $display("\n=========================================\n");
        $display("random_test completed");
        $display("\n=========================================\n");
    endtask

    task write_write();
        int target = scb.num_checked + 8;
        fork
        gen.write_write(8);
        dr.drive();
        mon.monitor();
        scb.check();
        join_none
        wait(scb.num_checked == target);
        disable fork;
        $display("\n=========================================\n");
        $display("write_write_test completed");
        $display("\n=========================================\n");
    endtask

    task read_read();
        int target = scb.num_checked + 8;
        fork
        gen.read_read(8);
        dr.drive();
        mon.monitor();
        scb.check();
        join_none
        wait(scb.num_checked == target);
        disable fork;
        $display("\n=========================================\n");
        $display("read_read_test completed");
        $display("\n=========================================\n");
    endtask

    task rd_aftr_wr();
        int target = scb.num_checked + 16;
        fork
        gen.rd_aftr_wr(8);
        dr.drive();
        mon.monitor();
        scb.check();
        join_none
        wait(scb.num_checked == target);
        disable fork;
        $display("\n=========================================\n");
        $display("rd_aftr_wr_test completed");
        $display("\n=========================================\n");
    endtask

    task test_full();
        int target = scb.num_checked + 16;
        fork
        gen.test_full(8);
        dr.drive();
        mon.monitor();
        scb.check();
        join_none
        
        wait(scb.num_checked == target);
        disable fork;
        $display("\n=========================================\n");
        $display("empty_full_test completed");
        $display("\n=========================================\n");
    endtask
endclass 