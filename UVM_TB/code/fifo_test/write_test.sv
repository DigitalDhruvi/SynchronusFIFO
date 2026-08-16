class write_test extends base_test;
`uvm_component_utils(write_test)
fifo_wr_sequence seq;
function new(string name="write_test",uvm_component parent=null);
super.new(name,parent);
endfunction
task run_phase(uvm_phase phase);
phase.raise_objection(this);
uvm_top.print_topology();
seq = fifo_wr_sequence::type_id::create("seq");
//repeat(10) begin
seq.start(env_o.agt.seqr);
//end
#10;
phase.drop_objection(this);
endtask
endclass
