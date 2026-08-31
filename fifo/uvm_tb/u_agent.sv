`include "uvm_macros.svh"
import uvm_pkg::*;

class agent extends uvm_agent;
    `uvm_component_utils(agent)
    uvm_analysis_port items;
    
    driver dr;
    monitor mon;
    uvm_sequencer#(transaction) sqr;

    
    function new(string name = "agent", uvm_component parent = null);
        super.new(name,parent);
        
        items = new("items",this);
    endfunction

    function build_phase (uvm_phase phase);
        super.build_phase(phase);
        dr = driver::type_id::create("dr", this);
        mon = monitor::type_id::create("mon", this);
        sqr = uvm_sequencer#(transaction)::type_id::create("sqr", this); 
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        dr.seq_item_port.connect(tr.seq_item_port);
        mon.item_collected.connect(this.items);
    endfunction
endclass