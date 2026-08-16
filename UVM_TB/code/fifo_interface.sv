//INTERFACE
interface fifo_if(input bit clk,input bit rst_n);
logic w_en,r_en;
logic [7:0]data_in;
logic [7:0]data_out;
logic full,empty;
clocking driver_cb@(posedge clk);
	default input #1step output #2;
	output w_en;
	output r_en;
	output data_in;
	input data_out,full,empty;
endclocking

clocking monitor_cb@(posedge clk);
	default input #1step output #2;
	input w_en;
	input r_en;
	input data_in;
	input data_out;
	input full;
	input empty;
endclocking

modport driver_mod(clocking driver_cb);
modport	monitor_mod(clocking monitor_cb);
endinterface
