`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;
    
    logic rst_n;
    rand logic write_en;
    rand logic read_en;
    rand logic [7:0] data_in;
    logic [7:0] data_out;
    logic full;
    logic empty;
    
    function new(string name = "transaction");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(transaction)
        `uvm_field_int (UVM_DEFAULT, write_en, UVM_BIN) 
        `uvm_field_int (UVM_DEFAULT, read_en, UVM_BIN)
        `uvm_field_int (UVM_DEFAULT, data_in, UVM_BIN)
        `uvm_field_int (UVM_DEFAULT, data_out, UVM_BIN) 
        `uvm_field_int (UVM_DEFAULT, full, UVM_BIN) 
        `uvm_field_int (UVM_DEFAULT, empty, UVM_BIN) 
    `uvm_object_utils_end

endclass