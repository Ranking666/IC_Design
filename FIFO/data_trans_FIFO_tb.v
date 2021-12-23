`timescale 1ns/1ns
module data_trans_FIFO_tb();
reg clk,reset_n;
reg start,byte;
reg [7:0] data_in;
reg rd_en;
wire [7:0] data_o;
wire full;
wire empty;
integer i;
data_trans_FIFO u0(reset_n, start, clk, byte, data_in, rd_en, data_o, empty, full);
always #200 clk = ~clk;
initial begin
	clk = 0;
	reset_n = 0;
	start = 0;
	rd_en = 0;
	@(posedge clk);
	@(posedge clk);
    	reset_n = 1'b1;
    	start = 1;
    	byte = 1;
    	data_in = 8'b00110101;
    	@(posedge clk);
    	byte = 0;
    	data_in = 8'b10101111;
    	@(posedge clk);
    	byte = 0;
    	data_in = 8'b11100110;
	for(i = 0; i < 30; i = i + 1)begin
		@(posedge clk);
		if(full)
		    start = 0;
		else
		    start = 1;
		byte = 1;
		data_in = data_in + i;
		end
	for(i = 0; i < 12; i = i + 1)begin
		@(posedge clk);
		if(empty)
		    rd_en = 0;
		else
		    rd_en = 1;
		start = 0;
		end
	 reset_n = 0;
	$finish; 
end
endmodule
	
		