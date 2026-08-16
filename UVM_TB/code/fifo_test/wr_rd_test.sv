class wr_rd_test extends base_test;
`uvm_component_utils(wr_rd_test)
wr_rd_sequence seq;
function new(string name="wr_rd_test",uvm_component parent=null);
super.new(name,parent);
endfunction
task run_phase(uvm_phase phase);
phase.raise_objection(this);
uvm_top.print_topology();
seq = wr_rd_sequence::type_id::create("seq");
seq.start(env_o.agt.seqr);
#10;
phase.drop_objection(this);
endtask
endclass
