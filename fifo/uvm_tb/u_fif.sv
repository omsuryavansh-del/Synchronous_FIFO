`include "uvm_macros.svh"
import uvm_pkg::*;

interface u_fif(input clk);

logic rst_n;
logic write_en;
logic read_en;
logic [7:0] data_in;
logic [7:0] data_out;
logic full;
logic empty;

endinterface