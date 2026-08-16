class driver; 
  virtual fifo_if fif;     // Virtual interface to the FIFO 
  mailbox #(transaction) mbx;  // Mailbox for communication 
  transaction datac;       // Transaction object for communication 
  function new(mailbox #(transaction) mbx); 
    this.mbx = mbx; 
  endfunction;  
  // Reset the DUT 
  task reset(); 
    fif.rst_n <= 1'b0; 
    fif.rd <= 1'b0; 
    fif.wr <= 1'b0; 
    fif.data_in <= 0; 
    repeat (5) @(posedge fif.clk); 
    fif.rst_n <= 1'b1; 
    $display("[DRV] : DUT Reset Done"); 
    $display("------------------------------------------"); 
  endtask 
  // Write data to the FIFO 
  task write(); 
    @(posedge fif.clk); 
    fif.rst_n <= 1'b1; 
    fif.rd <= 1'b0; 
    fif.wr <= 1'b1; 
    fif.data_in <= $urandom_range(1, 10); 
    @(posedge fif.clk); 
    fif.wr <= 1'b0; 
    $display("[DRV] : DATA WRITE  data : %0d", fif.data_in);   
    @(posedge fif.clk); 
  endtask 
  // Read data from the FIFO 
  task read();   
    @(posedge fif.clk); 
    fif.rst_n <= 1'b1; 
    fif.rd <= 1'b1; 
    fif.wr <= 1'b0; 
    @(posedge fif.clk); 
    fif.rd <= 1'b0;       
    $display("[DRV] : DATA READ");   
    @(posedge fif.clk); 
  endtask 
  // Apply random stimulus to the DUT 
  task run(); 
    forever begin 
      mbx.get(datac);   
      if (datac.oper == 1'b1) 
        write(); 
      else 
        read(); 
    end 
  endtask 
endclass 
