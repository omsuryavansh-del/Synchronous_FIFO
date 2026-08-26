import f_pkg::*;

class coverage;
    
    transaction tr;
    mailbox cov;
    

    covergroup cg;

        we_cp : coverpoint tr.write_en {
            bins wr0 = {0};
            bins wr1 = {1};
        }

        rd_cp : coverpoint tr.read_en {
            bins rd0 = {0};
            bins rd1 = {1};
        }

        wr_rd : cross we_cp,rd_cp {
            bins both_high = binsof(we_cp.wr1) && binsof(rd_cp.rd1);
            illegal_bins both_low = binsof(we_cp.wr0) && binsof(rd_cp.rd0);
        }

        full : coverpoint tr.full {
            bins is_full = {1};
            bins not_full = {0};
        }
        empty: coverpoint tr.empty {
            bins is_empty = {1};
            bins not_empty = {0};
        }
        
        full_empty: cross full,empty {
            bins valid_full_empty = binsof(full.not_full) && binsof(empty.not_empty);
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