//TRANSACTION
class transaction#(int DATA_WIDTH=8) extends uvm_sequence_item;
rand bit w_en;
rand bit r_en;
rand bit [DATA_WIDTH-1:0] data_in;
bit [DATA_WIDTH-1:0] data_out;
bit full;
bit empty;
`uvm_object_utils_begin(transaction#(DATA_WIDTH))
    `uvm_field_int(w_en,UVM_ALL_ON)
    `uvm_field_int(r_en,UVM_ALL_ON)
    `uvm_field_int(data_in,UVM_ALL_ON)
`uvm_object_utils_end

function new(string name="transaction");
super.new(name);
endfunction
endclass