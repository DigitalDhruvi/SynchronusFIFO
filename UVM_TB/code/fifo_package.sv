package fifo_package;

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "fifo_transaction.sv"

`include "fifo_base_sequence.sv"
`include "fifo_wr_sequence.sv"
`include "fifo_rd_sequence.sv"
`include "wr_rd_sequence.sv"

`include "fifo_driver.sv"
`include "fifo_monitor.sv"
`include "fifo_sequencer.sv"
`include "fifo_agent.sv"
`include "fifo_scoreboard.sv"
`include "fifo_subscriber.sv"
`include "fifo_environment.sv"

`include "base_test.sv"
`include "write_test.sv"
`include "read_test.sv"
`include "wr_rd_test.sv"
`include "final_test.sv"

endpackage
