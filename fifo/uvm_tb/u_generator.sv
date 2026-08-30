`include "uvm_macros.svh"
import uvm_pkg::*;
import u_fpkg::*;

class generator extends uvm_sequence #(transaction);
    `uvm_object_utils(generator)
    transaction tr;

    function new (string name = "generator");
        super.new(name);
    endfunction

    task random(n);
    repeat(n) begin
        tr = transaction::type_id::create(tr);
        start_item(tr);
            assert(tr.randomize() with {write_en != read_en ;})
                else `uvm_fatal ("GEN","randomization failed");
        finish_item(tr);
    end
    endtask

    task write_write(n);
    repeat(n) begin
        tr = transaction::type_id::create(tr);
        start_item(tr);
            assert(tr.randomize() with {(write_en == 1) && (read_en == 0) ;})
                else `uvm_fatal ("GEN","randomization failed");
        finish_item(tr);
    end
    endtask

    task read_read(n);
    repeat(n) begin
        tr = transaction::type_id::create(tr);
        start_item(tr);
            assert(tr.randomize() with {(write_en == 0) && (read_en == 1) ;})
                else `uvm_fatal ("GEN","randomization failed");
        finish_item(tr);
    end
    endtask

    task rd_aftr_wrt(n);
    repeat(n) begin
        tr = transaction::type_id::create(tr);
        start_item(tr);
            assert(tr.randomize() with {(write_en == 1) && (read_en == 0) ;})
                else `uvm_fatal ("GEN","randomization failed");
        finish_item(tr);

        tr = transaction::type_id::create(tr);
        start_item(tr);
            assert(tr.randomize() with {(write_en == 0) && (read_en == 1);})
                else `uvm_fatal ("GEN","randomization failed");
        finish_item(tr);
    end
    endtask
    task test_full(n);
        repeat(n)begin
            tr = transaction::type_id::create(tr);
            start_item(tr);
                assert(tr.randomize() with {(write_en == 1) && (read_en ==0);})
                    else `uvm_fatal ("GEN"."randomization failed")
            finish_item(tr);

            tr = transaction::type_id::create(tr);
            start_item(tr);
                assert(tr.randomize() with {(write_en == 1) && (read_en ==1);})
                    else `uvm_fatal ("GEN"."randomization failed")
            finish_item(tr);
        end 
    endtask

endclass