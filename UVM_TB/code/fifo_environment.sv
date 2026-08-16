//ENVIRONMENT
class env extends uvm_env;
`uvm_component_utils(env)
agent agt;
fifo_subscriber sub;
scoreboard sb;
function new(string name="env",uvm_component parent=null);
super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
super.build_phase(phase);
agt = agent::type_id::create("agt",this);
sb  = scoreboard::type_id::create("sb",this);
sub = fifo_subscriber::type_id::create("sub",this);
endfunction
function void connect_phase(uvm_phase phase);
agt.mon.item_collect_port.connect(sb.item_collect_export);
agt.mon.item_collect_port.connect(sub.analysis_export);
endfunction
endclass
