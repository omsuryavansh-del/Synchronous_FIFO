import f_pkg:: *;
class generator;
    transaction tr;
    mailbox gen_to_drv;

    task generator(input int n);
        repeat(n) begin
        tr = new();
        assert(tr.randomize() with {op == transaction::RAND_OP ;}) 
        else $fatal(1,"fatal:: randomization failed");
        gen_to_drv.put(tr);
        end
    endtask
        
    task write_write(input int n);
        repeat(n)begin
            tr = new();
            assert(tr.randomize() with {op == transaction::WRITE_OP ;})
            else $fatal(1,"consecutive write randomization failed");
            gen_to_drv.put(tr);
        end
    endtask

    task read_read(input int n);
        repeat(n) begin
            tr = new();
            assert(tr.randomize() with {op == transaction::READ_OP ;})
            else $fatal (1,"consecutive read randomization failed");
            gen_to_drv.put(tr);
        end
    endtask

    task rd_aftr_wr(input int n);
        repeat(n) begin
            tr = new();
            assert(tr.randomize() with {op == transaction::WRITE_OP;})
            else $fatal (1,"write randomization failed");
            gen_to_drv.put(tr);

            tr = new();
            assert(tr.randomize() with {op == transaction::READ_OP ;})
            else $fatal (1,"consecutive read randomization failed");
            gen_to_drv.put(tr);
        end
    endtask

    task test_full(input int n);
           repeat(n) begin

            tr = new();
            assert(tr.randomize() with {op == transaction::WRITE_OP;})
            else $fatal (1,"write randomization failed");
            gen_to_drv.put(tr);
            
            tr = new();
            assert(tr.randomize() with {op == transaction::SIM_OP;})
            else $fatal (1,"write randomization failed");
            gen_to_drv.put(tr);
            
        end
    endtask
endclass