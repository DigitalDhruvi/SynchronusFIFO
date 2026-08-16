class fifo_subscriber extends uvm_subscriber #(transaction);
`uvm_component_utils(fifo_subscriber)
transaction tr;
covergroup cg;
// Write Enable
cp_w_en : coverpoint tr.w_en {
	bins write = {1};
	bins no_write = {0};
}

// Read Enable
cp_r_en : coverpoint tr.r_en {
	bins read = {1};
	bins no_read = {0};
}

// Data Input
cp_data_in : coverpoint tr.data_in {
	option.auto_bin_max = 16;
	bins data = {[0:100]};
}

// FIFO Full
cp_full : coverpoint tr.full {
	bins full = {1};
	bins not_full = {0};
}

// FIFO Empty
cp_empty : coverpoint tr.empty {
	bins empty = {1};
	bins not_empty = {0};
}
// Read/Write combinations
cross_rw : cross cp_w_en, cp_r_en;

// Writing when FIFO is full
cross_write_full : cross cp_w_en, cp_full;

// Reading when FIFO is empty
cross_read_empty : cross cp_r_en, cp_empty;

// Simultaneous Read and Write

// Complete operational scenarios
cross_all : cross cp_w_en, cp_r_en, cp_full, cp_empty {
ignore_bins invalid_state = binsof(cp_full) intersect {1} && binsof(cp_empty) intersect {1}; }
endgroup

function new(string name="fifo_subscriber", uvm_component parent);
super.new(name,parent);
cg = new();
endfunction

function void write(transaction t);
tr = t;
cg.sample();
endfunction

endclass

