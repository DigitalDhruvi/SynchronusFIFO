class fifo_rd_sequence extends base_sequence;
`uvm_object_utils(fifo_rd_sequence)
transaction tr;
function new(string name="fifo_rd_sequence");
super.new(name);
endfunction
task body();
`uvm_info(get_type_name(),"Fifo read sequence: Inside fifo read on empty sequence",UVM_LOW);
repeat(3) begin
`uvm_do_with(tr,{tr.w_en == 0;tr.r_en == 1;})
end
repeat(10) begin
`uvm_do_with(tr,{tr.w_en == 0;tr.r_en == 1;})
end
`uvm_info(get_type_name(), $sformatf("w_en = %0d, r_en = %0d, data_in = %0d", tr.w_en, tr.r_en, tr.data_in), UVM_LOW);
endtask
endclass