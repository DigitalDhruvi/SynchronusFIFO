//SCOREBOARD
class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)
uvm_analysis_imp #(transaction,scoreboard) item_collect_export;
bit [7:0] fifo_q[$];
bit pop_pending;
bit [7:0] pop_expected;

function new(string name,uvm_component parent);
  super.new(name,parent);
  item_collect_export=new("item_collect_export",this);
endfunction

function void write(transaction tr);
  // Check the result of a read that was REQUESTED last cycle
  // (data_out is a registered output, so it lags r_en by 1 cycle)
  if (pop_pending) begin
    	`uvm_info("SB",$sformatf("----------------------------------------------"),UVM_LOW)
	`uvm_info("SB",$sformatf("Beginning comparison"),UVM_LOW)
	if (pop_expected == tr.data_out) begin
      `uvm_info("SB",$sformatf("PASS expected=%0d actual=%0d",pop_expected,tr.data_out),UVM_LOW)
    	`uvm_info("SB",$sformatf("----------------------------------------------"),UVM_LOW)
	end
    else begin
      `uvm_error("SB",$sformatf("FAIL expected=%0d actual=%0d",pop_expected,tr.data_out))
    	`uvm_info("SB",$sformatf("----------------------------------------------"),UVM_LOW)
	end
    pop_pending = 0;
  end
if(tr.r_en && tr.empty)
  `uvm_warning("SB","!!!!!!!!!!!!!!!Attempted read while FIFO empty!!!!!!!!!!!!!!!!")

if(tr.w_en && tr.full)
  `uvm_warning("SB","!!!!!!!!!!!!!!!Attempted write while FIFO full!!!!!!!!!!!!!!!!")
  
if (tr.w_en && !tr.full)
    fifo_q.push_back(tr.data_in);

  if (tr.r_en && !tr.empty) begin
    if (fifo_q.size() > 0) begin
      pop_expected = fifo_q.pop_front();
      pop_pending  = 1;   // check this on the NEXT write() call
    end else
      `uvm_warning("SB","Reference queue empty")
  end
endfunction
endclass
