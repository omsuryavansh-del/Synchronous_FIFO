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

    `uvm_object_utils_begin(transaction)
        `uvm_field_int (write_en, UVM_DEFAULT |  UVM_BIN) 
        `uvm_field_int (read_en,  UVM_DEFAULT | UVM_BIN)
        `uvm_field_int (data_in,  UVM_DEFAULT | UVM_BIN)
        `uvm_field_int (data_out, UVM_DEFAULT |  UVM_BIN) 
        `uvm_field_int (full,  UVM_DEFAULT | UVM_BIN) 
        `uvm_field_int (empty, UVM_DEFAULT | UVM_BIN) 
    `uvm_object_utils_end
    
    function new(string name = "transaction");
        super.new(name);
    endfunction
endclass