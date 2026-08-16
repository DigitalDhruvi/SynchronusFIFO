module tb;    
  fifo_if fif(); 
  synchronous_fifo dut (fif.clk, fif.rst_n, fif.wr, fif.rd, fif.data_in, fif.data_out, fif.full, fif.empty); 
  initial begin 
    fif.clk <= 0; 
  end 
  always #10 fif.clk <= ~fif.clk; 
  environment env; 
  initial begin 
    env = new(fif); 
    env.gen.count = 10; 
    env.run(); 
  end 
  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars; 
  end 
endmodule 