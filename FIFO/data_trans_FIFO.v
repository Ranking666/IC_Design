module data_trans_FIFO(
     input wire reset_n, start, clk, byte,
     input wire [7 : 0] data_in,
     input wire rd_en,
     output wire [7 : 0] data_o,          //??????
     output wire empty,        //?????
     output wire full 
);
 wire [7 : 0] data_o_in;
 wire data_wr_en;

data_trans u2(.reset_n(reset_n),.start(start),.clk(clk),.byte(byte),.data_in(data_in),.data_o(data_o_in),.data_en(data_wr_en));
FIFO u3(.clk(clk), .reset_n(reset_n),.data_in(data_o_in), .rd_en(rd_en), .wr_en(data_wr_en) ,.data_o(data_o), .empty(empty), .full(full));

endmodule