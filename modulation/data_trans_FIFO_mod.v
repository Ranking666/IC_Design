`timescale 1ns/1ps
module data_trans_FIFO_mod(
     input wire reset_n, start, clk, byte,
     input wire [7 : 0] data_in,
     output wire full, 
     output wire [4:0] dmod,
     output wire       mod_en
);
 wire [7 : 0] data_o_in;
 wire data_wr_en;
 wire [7 : 0] data_o_ino;
 wire empty;
 wire rd_en;

data_trans u1(.reset_n(reset_n),.start(start),.clk(clk),.byte(byte),.data_in(data_in),.data_o(data_o_in),.data_en(data_wr_en));
FIFO_64_8 u2(.clk(clk), .reset_n(reset_n),.data_in(data_o_in), .rd_en(rd_en), .wr_en(data_wr_en) ,.data_o(data_o_ino), .empty(empty), .full(full));
data_mod u3(.clk(clk), .reset_n(reset_n), .rdy(empty), .data_in(data_o_ino), .dmod(dmod), .mod_en(mod_en), .rd(rd_en));

endmodule