module synchronous_fifo_counter #(parameter DEPTH=8, DATA_WIDTH=8) (
input clk, rst_n,
input w_en, r_en,
input [DATA_WIDTH-1:0] data_in,
output reg [DATA_WIDTH-1:0] data_out,
output full, empty);
reg [$clog2(DEPTH)-1:0] w_ptr, r_ptr;
reg [DATA_WIDTH-1:0] fifo[DEPTH-1:0];
reg [$clog2(DEPTH):0] fifo_counter;

assign full = (fifo_counter == DEPTH);
assign empty = (fifo_counter == 0);

// FIFO counter logic
always @(posedge clk or negedge rst_n) begin
if (!rst_n)
fifo_counter <= 0;
else if ((!full && w_en) && (!empty && r_en))
fifo_counter <= fifo_counter; // No change if both read and write are
enabled simultaneously
else if (!full && w_en)
fifo_counter <= fifo_counter + 1;
else if (!empty && r_en)
fifo_counter <= fifo_counter - 1;
end

// Buffer output logic
always @(posedge clk or negedge rst_n) begin
if (!rst_n)
data_out <= 0;
else if (r_en && !empty)
data_out <= fifo[rd_ptr]; // Read data from buffer
end

// Buffer memory write logic
always @(posedge clk) begin
if (w_en && !full)
fifo[wr_ptr] <= data_in; // Write data to buffer
end

// Read and write pointer logic
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