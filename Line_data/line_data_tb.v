`timescale 1ns/1ns
module line_data_tb();
reg clk,clr;
reg A,B;
wire Z;
line_data u0(clk, clr, A,B,Z);
always #200 clk = ~clk;
reg [31:0] xin; 
initial
 begin
    clk = 0;
    clr = 0;
    xin = 32'b0011_0111_0011_0101_0011_1010_1111_0010;
    A = 0;
    B = 0;
    @(posedge clk);
    clr = 1'b1;
    repeat(16) begin
       @(negedge clk);
           A = xin[0];
           B = xin[1];
	   xin = xin >> 2;
               end
end
endmodule
