`timescale 1ns/1ns
`include "../rtl/fifo.v"
`include "fifo_if.sv"
import f_pkg::*;

module top;

    reg clk;
    test tes;
    random      rtes;
    write_write wtes;
    read_read   rdtes;
    rd_aftr_wr  rwtes;
    empty_full  eftes;
    environment env;


    fifo_if f_if(clk);

    fifo dut(
            .clk(clk),
            .rst_n(f_if.rst_n),
            .write_en(f_if.write_en),
            .read_en(f_if.read_en),
            .data_in(f_if.data_in),
            .data_out(f_if.data_out),
            .full(f_if.full),
            .empty(f_if.empty)
    );

    always #5 clk = ~clk;

    initial begin
        test queue [$];
        clk = 0;
        f_if.rst_n = 0;
        f_if.write_en = 0;
        f_if.read_en = 0;
        f_if.data_in = 0;

        env = new;
        tes = new;
        rtes  = new;
        wtes  = new;
        rdtes  = new;
        rwtes = new;
        eftes = new;

        queue.push_back(rtes);
        queue.push_back(wtes);
        queue.push_back(rdtes);
        queue.push_back(rwtes);
        queue.push_back(eftes);
        

        #10 f_if.rst_n = 1;

        foreach(queue[i])begin
            queue[i].env = env;
            queue[i].f_if = f_if;
            queue[i].run();
        end

        
        $display("\n=========================================\n");
        $display("Simulation finished successfully!");
        $display("total test = %0d || passed = %0d || failed =%0d",env.scb.num_checked,env.scb.pass,env.scb.failed);
        #1500 $finish;
    end

    initial begin 
        $dumpfile("fiftb.vcd");
        $dumpvars;   
    end
endmodule