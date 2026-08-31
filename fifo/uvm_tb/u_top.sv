`include "uvm_macros.svh"
`include "../rtl/fifo.v"
`include "u_fif.sv"
import uvm_pkg::*;
import u_fpkg::*;

module top;
    reg clk;
    u_fif f_if(clk);

    fifo dut(
        .clk(clk),
        .rst_n(f_if.rst_n),
        .write_en(f_if.write_en),
        .read_en(f_if.read_en),
        .data_in(f_if.data_in),
        .data_out(f_if.data_out),
        .full(f_if.full),
        .empty(f_if.empty)
    );

    always #5 clk = ~clk;
    initial begin
        clk = 0;
        f_if.rst_n = 0;
        f_if.write_en = 0;
        f_if.read_en = 0;
        f_if.data_in = 0;
        #10 f_if.rst_n = 1;
        uvm_config_db#(virtual u_fif)::set(null,"","u_fif",f_if);
        run_test("all_test");
    end

endmodule