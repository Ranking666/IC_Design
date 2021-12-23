`timescale 1ns/1ns
module data_trans_tb();
reg clk,reset_n;
reg start,byte;
reg [7:0] data_in;
wire [7:0] data_o;
wire data_en;
data_trans u0(reset_n, start, clk, byte,data_in,data_o, data_en);
always #200 clk = ~clk;
initial
 begin
    clk = 0;
    reset_n = 0;
    start = 0;
    //#200;
    //reset_n = 1'b1;
    //start = 1; 
    //byte = 1;
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
    @(posedge clk);    
    byte = 0;
    data_in = 8'b11100110;
    @(posedge clk);
    byte = 1;
    data_in = 8'b01010101;
    @(posedge clk);
    start = 0;

end
endmodule
