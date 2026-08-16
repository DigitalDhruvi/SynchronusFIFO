//DRIVER
class driver extends uvm_driver #(transaction);
`uvm_component_utils(driver)
virtual fifo_if vif;
transaction tr;
function new(string name = "driver",uvm_component parent = null);
super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(virtual fifo_if)::get(this,"","vif",vif))
`uvm_fatal("DRV","Virtual interface not found")
endfunction
task run_phase(uvm_phase phase);
forever begin
seq_item_port.get_next_item(tr);
@(vif.driver_cb);
vif.driver_cb.w_en    <= tr.w_en;
vif.driver_cb.r_en    <= tr.r_en;
vif.driver_cb.data_in <= tr.data_in;
`uvm_info("DRV",$sformatf("w_en=%0b r_en=%0b data_in=%0d",tr.w_en,tr.r_en,tr.data_in),UVM_LOW)
seq_item_port.item_done();
@(vif.driver_cb);
vif.driver_cb.w_en <= 0;
vif.driver_cb.r_en <= 0;
end
endtask
endclass
