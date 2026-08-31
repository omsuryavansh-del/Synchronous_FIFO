`include "uvm_macros.svh"
import uvm_pkg::*;

class environment extends uvm_env;
    `uvm_component_utils(environment)

    agent ag;
    scoreboard scb;
    coverage cov;

    function new(string name = "environment", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function build_phase(uvm_phase phase);
        super.build_phase(phase);
        ag = agent::type_id::create("ag",this);
        scb = scoreboard::type_id::create("scb",this);
        cov = coverage::type_id::create("cov",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        ag.items.connect(scb.item_collected_export);
        ag.items.connect(cov.item_collected);
    endfunction

    
endclass