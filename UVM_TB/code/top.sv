//TOP MODULE
`include "fifo_interface.sv"
`include "fifo_dut.sv"
`include "uvm_macros.svh"
`include "fifo_package.sv"
import uvm_pkg::*;
import fifo_package::*;

module tb_top;
bit clk;
bit rst_n;
always #2 clk = ~clk;
transaction tr_h;
initial begin
    clk = 0;
end
initial begin
    rst_n = 0;
    #5;
    rst_n = 1;
end

fifo_if vif(clk,rst_n);
synchronous_fifo DUT(.clk(clk),
	 .rst_n(rst_n),
	 .w_en(vif.w_en),
	 .r_en(vif.r_en),
	 .data_in(vif.data_in),
	 .data_out(vif.data_out),
	 .full(vif.full),
	 .empty(vif.empty)
);

initial begin
uvm_config_db#(virtual fifo_if)::set(uvm_root::get(),"*","vif",vif);
if($test$plusargs("write_test"))
        run_test("write_test");

    else if($test$plusargs("read_test"))
        run_test("read_test");

    else if($test$plusargs("wr_rd_test"))
        run_test("wr_rd_test");

    else
        run_test("final_test");
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_top.vif);
end
endmodule
