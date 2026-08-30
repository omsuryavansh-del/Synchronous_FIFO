`include "uvm_macros.svh"
import uvm_pkg::*;

class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)
    transaction tr;
    virtual u_fif f_if;

    function new(string name = "monitor", parent = null);
        super.new(name,parent);
    endfunction

    function build_phase (uvm_phase phase);
        super.build_name(phase);
        if(!(`uvm_config_db #(virtual u_fif)::get(this,"","vif","f_if"))) 
            else `uvm_fatal("MON","config db vif not found anywhere");
    endfunction

    task run();
        start_item(tr);
            @(posedge f_if.clk);
            #1
            tr.rst_n = f_if.rst_n;
            if(f_if.rst_n)begin
                tr.write_en = f_if.write_en; 
                tr.read_en = f_if.read_en; 
                tr.data_in = f_if.data_in; 
                tr.data_out = f_if.data_out; 
                tr.full = f_if.full; 
                tr.empty = f_if.empty; 

                $display("transaction sent to scoreboard rst_n = %0b || w_en = %0b || rd_en = %0b || data_in = %0b || data_out = %0b",
                    tr.rst_n,tr.write_en,tr.read_en,tr.data_in,tr.data_out);
            end
        finish_item(tr);
    endtask
endclass