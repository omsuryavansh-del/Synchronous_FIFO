`include "uvm_macros.svh"
import uvm_pkg::*;

class coverage extends uvm_component;
    `uvm_component_utils(coverage)
    uvm_analysis_imp #(transaction,coverage) item_collected;
    transaction tr;

    function new(string name = "coverage", uvm_component parent = null);
        super.new(name,parent);
        item_collected = new("item_collected",this);
        cg = new;
    endfunction

    function build_phase (uvm_phase phase);
        super.build_phase(phase);
    endfunction

    covergroup cg;
        write :coverpoint  tr.write_en {
            bins write1 = {1};
            bins write0 = {0};
        }

        read :coverpoint tr.read_en {
            bins read0 = {0};
            bins read1 = {1};
        }

        full :coverpoint tr.full {
            bins full0 = {0};
            bins full1 = {1};
        } 

        empty :coverpoint tr.empty {
            bins empty0 = {0};
            bins empty1 = {1};
        }

        write_read :cross write,read {
            bins = binsof(write.write1) && binsof(read.read1);
            ignore_bins = binsof(write.write0) && binsof(read.read0);
        }

        full_empty :cross full,empty {
            illegal_bins = binsof(full.full1) && binsof(empty.empty1);
            bins = binsof(full.full0) && binsof(empty.empty0);
        }
    endgroup

    function void write(transaction req);
        tr = req;
        cg.sample();
    endfunction

endclass
