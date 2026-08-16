class final_test extends base_test;
`uvm_component_utils(final_test)
fifo_wr_sequence wr_seq_h;
fifo_rd_sequence rd_seq_h;
wr_rd_sequence wr_rd_seq_h;
function new(string name="wr_rd_test",uvm_component parent=null);
super.new(name,parent);
endfunction
task run_phase(uvm_phase phase);
phase.raise_objection(this);
uvm_top.print_topology();
wr_seq_h = fifo_wr_sequence::type_id::create("wr_seq_h");
rd_seq_h = fifo_rd_sequence::type_id::create("rd_seq_h");
wr_rd_seq_h = wr_rd_sequence::type_id::create("wr_rd_seq_h");

wr_seq_h.start(env_o.agt.seqr);
rd_seq_h.start(env_o.agt.seqr);
wr_rd_seq_h.start(env_o.agt.seqr);

#10;
phase.drop_objection(this);
endtask
endclass
