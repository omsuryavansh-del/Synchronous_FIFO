`include "uvm_macros.svh"
import uvm_pkg::*;
import u_fpkg::*;

class test extends uvm_test;
    `uvm_component_utils(test)
    environment env;
    function new(string name = "test", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = environment::type_id::create("env",this);
    endfunction

endclass

class random_test extends test;
    `uvm_component_utils(random_test)

    function new (uvm_component parent = null,string name = "random_test");
        super.new(name,parent);
    endfunction

    task run_phase(uvm_phase phase);
        random_seq seq = random_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.start_with(env.ag.sqr, 10);   
        phase.drop_objection(this);
    endtask
endclass

class write_test extends test;
    `uvm_component_utils(write_test)

    function new (uvm_component parent = null,string name = "write_test");
        super.new(name,parent);
    endfunction

    task run_phase(uvm_phase phase);
        write_seq seq = write_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.start_with(env.ag.sqr, 8);   
        phase.drop_objection(this);
    endtask
endclass

class read_test extends test;
    `uvm_component_utils(read_test)

    function new (uvm_component parent = null,string name = "read_test");
        super.new(name,parent);
    endfunction

    task run_phase(uvm_phase phase);
        read_seq seq = read_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.start_with(env.ag.sqr, 8);   
        phase.drop_objection(this);
    endtask
endclass


class rd_aftr_wr extends test;
    `uvm_component_utils(rd_aftr_wr)

    function new (uvm_component parent = null,string name = "rd_aftr_wr");
        super.new(name,parent);
    endfunction

    task run_phase(uvm_phase phase);
        rd_aftr_wr_seq seq = rd_aftr_wr_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.start_with(env.ag.sqr, 16);   
        phase.drop_objection(this);
    endtask
endclass


class full_test extends test;
    `uvm_component_utils(full_test)

    function new (uvm_component parent = null,string name = "full_test");
        super.new(name,parent);
    endfunction

    task run_phase(uvm_phase phase);
        full_seq seq = full_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.start_with(env.ag.sqr, 16);   
        phase.drop_objection(this);
    endtask
endclass

class all_test extends test;
    `uvm_component_utils(all_test)
    function new(string name = "all_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        random_seq  gseq = random_seq::type_id::create("gseq");
        write_seq   wseq = write_seq::type_id::create("wseq");
        read_seq    rseq = read_seq::type_id::create("rseq");
        rd_aftr_wr_seq  rd_wr = rd_aftr_wr_seq::type_id::create("rd_wr");
        full_seq   fullt = full_seq::type_id::create("fullt");


        phase.raise_objection(this);
            gseq.start_with(env.ag.sqr,10);
            wseq.start_with(env.ag.sqr,8);
            rseq.start_with(env.ag.sqr,8);
            rd_wr.start_with(env.ag.sqr,16);
            fullt.start_with(env.ag.sqr,16);
        phase.drop_objection(this);
    endtask

    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("TEST_REPORT","all test done", UVM_NONE)
    endfunction
endclass