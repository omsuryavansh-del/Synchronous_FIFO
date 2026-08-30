`include "uvm_macros.svh"
import uvm_pkg::*;

class driver extends uvm_driver;
    `uvm_component_utils(driver)
    virtual u_fif f_if;

    function new(string name = "driver", parent = null);
        super.new(name,parent);
    endfunction

    function build_phase (uvm_phase phase)
        super.build_phase (phase);
        if(!`uvm_config_db#(virtual u_fif)::get(this,"","vif","f_if"))
            `uvm_fatal("DRV","virtual interface config db not found")
    endfunction

    task run_phase ();
        seq_item_port.get_next_item(req);
            @(posedge f_if.clk)
            if(f_if.rst_n) begin
                f_if.write_en = req.write_en;
                f_if.read_en = req.read_en;
                f_if.data_in = req.data_in;
                $display("transaction sent to dut rst_n = %0b || w_en = %0b || rd_en = %0b || data_in = %0b",
                          f_if.rst_n, req.write_en, req.read_en, req.data_in);
            end
        seq_item_port.item_done();
    endtask
endclass