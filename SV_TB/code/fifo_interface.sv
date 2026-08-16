interface fifo_if; 
  logic clk, rd, wr;         // Clock, read, and write signals 
  logic full, empty;           // Flags indicating FIFO status 
  logic [7:0] data_in;         // Data input 
  logic [7:0] data_out;        // Data output 
  logic rst_n;			// Reset signal  
endinterface 
