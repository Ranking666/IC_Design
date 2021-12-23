`timescale 1ns/1ns
module FIFO_tb();
reg clk,reset_n;
reg rd_en,wr_en;
reg [7:0] data_in;
wire [7:0] data_o;
wire full;
wire empty;
integer i;
FIFO u0(clk, reset_n, data_in, rd_en, wr_en ,data_o, empty, full);
always #200 clk = ~clk;
initial
 begin
    clk = 0;
    reset_n = 0;
    data_in = 8'b00110101;
    rd_en = 0;
    wr_en = 0;
    #800;
    reset_n = 1;
    wr_en = 1;
    for(i = 0; i< 28; i = i + 1) begin
	@(posedge clk);
	     if(full)begin
		wr_en = 0;
		end
    	data_in = data_in + i;
	end
    for(i = 8; i > 0; i = i - 1) begin	
	@(posedge clk);
              if(empty)begin
		rd_en =0;
		end
	      else begin
               rd_en = 1; 
		end
	end
    rd_en =0;
    wr_en =0;

    //data_in = 8'b00110101;
    //#400;
    //byte = 0;
    //data_in = 8'b10101111;
    //#400;
    //byte = 0;
    //data_in = 8'b11100110;
    //#400;    
    //byte = 0;
    //data_in = 8'b11100110;
    //#400;
    //byte = 1;
    //data_in = 8'b01010101;

end
endmodule