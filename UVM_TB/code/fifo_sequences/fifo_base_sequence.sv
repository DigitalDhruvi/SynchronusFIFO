class base_sequence extends uvm_sequence #(transaction);
`uvm_object_utils(base_sequence)
transaction tr;
function new(string name="base_sequence");
super.new(name);
endfunction
task body();
`uvm_info(get_type_name(),"Base sequence: Inside Body",UVM_MEDIUM);
endtask
endclass
