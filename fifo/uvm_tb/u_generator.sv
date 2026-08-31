`include "uvm_macros.svh"
import uvm_pkg::*;
import u_fpkg::*;

class base_seq extends uvm_sequence #(transaction);
    `uvm_object_utils(random_seq)
    int num_trans = 10;
    transaction tr;

    function new(string name = "base_seq");
        super.new(name);
    endfunction

    task start_with(uvm_sequencer_base sqr, int n);
        num_trans = n;
        this.start(sqr);   // internally calls body() with no args
    endtask
endclass

class random_seq extends base_seq;
    `uvm_object_utils(random_seq)
    transaction tr;

    function new (string name = "random_seq");
        super.new(name);
    endfunction

    task body();
    repeat(num_trans) begin
        tr = transaction::type_id::create("tr");
        start_item(tr);
            assert(tr.randomize() with {write_en != read_en ;})
                else `uvm_fatal ("GEN","randomization failed");
        finish_item(tr);
    end
    endtask
endclass

class write_seq extends base_seq;
    `uvm_object_utils(write_seq)
    transaction tr;

    function new (string name = "write_seq");
        super.new(name);
    endfunction

    task body();
    repeat(num_trans) begin
        tr = transaction::type_id::create("tr");
        start_item(tr);
            assert(tr.randomize() with {(write_en == 1) && (read_en == 0) ;})
                else `uvm_fatal ("GEN","randomization failed");
        finish_item(tr);
    end
    endtask
endclass

class read_seq extends base_seq;
    `uvm_object_utils(read_seq)
    transaction tr;

    function new (string name = "read_seq");
        super.new(name);
    endfunction

    task body ();
    repeat(num_trans) begin
        tr = transaction::type_id::create("tr");
        start_item(tr);
            assert(tr.randomize() with {(write_en == 0) && (read_en == 1) ;})
                else `uvm_fatal ("GEN","randomization failed");
        finish_item(tr);
    end
    endtask
endclass


class rd_aftr_wr extends base_seq;
    `uvm_object_utils(rd_aftr_wr)
    transaction tr;

    function new (string name = "rd_aftr_wr");
        super.new(name);
    endfunction

    task body ();
    repeat(num_trans) begin
        tr = transaction::type_id::create("tr");
        start_item(tr);
            assert(tr.randomize() with {(write_en == 1) && (read_en == 0) ;})
                else `uvm_fatal ("GEN","randomization failed");
        finish_item(tr);

        tr = transaction::type_id::create("tr");
        start_item(tr);
            assert(tr.randomize() with {(write_en == 0) && (read_en == 1);})
                else `uvm_fatal ("GEN","randomization failed");
        finish_item(tr);
    end
    endtask
endclass


class full_test extends base_seq;
    `uvm_object_utils(full_test)
    transaction tr;

    function new (string name = "full_test");
        super.new(name);
    endfunction

    task body ();
        repeat(num_trans)begin
            tr = transaction::type_id::create("tr");
            start_item(tr);
                assert(tr.randomize() with {(write_en == 1) && (read_en ==0);})
                    else `uvm_fatal ("GEN","randomization failed")
            finish_item(tr);

            tr = transaction::type_id::create("tr");
            start_item(tr);
                assert(tr.randomize() with {(write_en == 1) && (read_en ==1);})
                    else `uvm_fatal ("GEN","randomization failed")
            finish_item(tr);
        end 
    endtask

endclass