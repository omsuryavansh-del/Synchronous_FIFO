import f_pkg::*;

class coverage;
    
    transaction tr;
    mailbox cov;
    

    covergroup cg;

        op_cp : coverpoint tr.op {
            bins write = {transaction::WRITE_OP};
            bins read = {transaction::READ_OP};
            bins sim = {transaction:: SIM_OP};
            bins random = {transaction::RAND_OP};
        }

        full : coverpoint tr.full {
            bins is_full = {1};
        }
        empty: coverpoint tr.empty {
            bins is_empty = {1};
        }
        
        full_empty: cross full,empty {
            illegal_bins invalid_full_empty = binsof(full.is_full) && binsof(empty.is_empty);
        }
    
    endgroup
        
    
    function new();
        tr = new();
        cg = new;
    endfunction

    task run();
        forever begin
            cov.get(tr);
            cg.sample();
        end
    endtask

endclass