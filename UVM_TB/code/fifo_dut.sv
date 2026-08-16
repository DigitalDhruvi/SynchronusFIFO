//DUT
module synchronous_fifo #(parameter DEPTH=8, DATA_WIDTH=8) (
input bit clk, rst_n,
input bit w_en, r_en,
input logic [DATA_WIDTH-1:0] data_in,
output logic [DATA_WIDTH-1:0] data_out,
output bit full, empty);
logic [$clog2(DEPTH)-1:0] wr_ptr, rd_ptr;
bit [DATA_WIDTH-1:0] fifo[DEPTH-1:0];
logic [$clog2(DEPTH):0] fifo_counter;
assign full = (fifo_counter == DEPTH);
assign empty = (fifo_counter == 0);
always @(posedge clk or negedge rst_n) begin
if (!rst_n)
fifo_counter <= 0;
else if ((!full && w_en) && (!empty && r_en))
fifo_counter <= fifo_counter;
else if (!full && w_en)
fifo_counter <= fifo_counter + 1;
else if (!empty && r_en)
fifo_counter <= fifo_counter - 1;
end
always @(posedge clk or negedge rst_n) begin
if (!rst_n)
data_out <= 0;
else if (r_en && !empty)
data_out <= fifo[rd_ptr]; 
end
always @(posedge clk) begin
if (w_en && !full)
fifo[wr_ptr] <= data_in; 
end
always @(posedge clk or negedge rst_n) begin
if (!rst_n) begin
wr_ptr <= 0;
rd_ptr <= 0;
end else begin
if (!full && w_en)
wr_ptr <= wr_ptr + 1;
if (!empty && r_en)
rd_ptr <= rd_ptr + 1;
end
end
endmodule


