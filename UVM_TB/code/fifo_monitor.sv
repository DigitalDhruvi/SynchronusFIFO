//MONITOR
class monitor extends uvm_monitor;
`uvm_component_utils(monitor)
virtual fifo_if vif;
transaction tr;
uvm_analysis_port #(transaction) item_collect_port;
function new(string name,uvm_component parent);
super.new(name,parent);
item_collect_port=new("item_collect_port",this);
endfunction
function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(virtual fifo_if)::get(this,"","vif",vif))
`uvm_fatal("MON","Virtual interface not found")
endfunction
task run_phase(uvm_phase phase);
forever
begin
@(vif.monitor_cb);
tr=transaction#(8)::type_id::create("tr");
tr.w_en=vif.monitor_cb.w_en;
tr.r_en=vif.monitor_cb.r_en;
tr.data_in=vif.monitor_cb.data_in;
tr.data_out=vif.monitor_cb.data_out;
tr.full=vif.monitor_cb.full;
tr.empty=vif.monitor_cb.empty;
if(tr.w_en==1 || tr.r_en==1)
`uvm_info("MON",$sformatf("w_en=%0b r_en=%0b data_in=%0d data_out=%0d full=%0d empty=%0d",tr.w_en,tr.r_en,tr.data_in,tr.data_out,tr.full,tr.empty),UVM_LOW)
$display("------------------------------------------------------------------------------------------------------");
item_collect_port.write(tr);
end
endtask
endclass
