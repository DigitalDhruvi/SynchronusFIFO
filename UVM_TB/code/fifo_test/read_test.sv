class read_test extends base_test;
`uvm_component_utils(read_test)
fifo_rd_sequence seq;
function new(string name="read_test",uvm_component parent=null);
super.new(name,parent);
endfunction
task run_phase(uvm_phase phase);
phase.raise_objection(this);
uvm_top.print_topology();
seq = fifo_rd_sequence::type_id::create("seq");
seq.start(env_o.agt.seqr);
#10;
phase.drop_objection(this);
endtask
endclass
