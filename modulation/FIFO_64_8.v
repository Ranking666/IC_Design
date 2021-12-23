`timescale 1ns/1ps
module FIFO_64_8(
  input wire	        clk,           
  input wire	        reset_n,            
  input wire [7 : 0]	data_in,            
  input wire	        rd_en,         
  input wire	        wr_en,        
  output wire[7 : 0]     data_o,          
  output wire 	        empty,        
  output wire	        full    
);
reg [5 : 0] tail; 
reg [5 : 0] head; 
reg [5 : 0] count;
wire [5 : 0] AA; 
wire [5 : 0] AB;
wire [7 : 0] DB;  
S65NLLHS2PH64x8 u0 (.QA ( data_o ),.CLKA ( clk ),.CLKB ( clk ),.CENA ( CENA ),.CENB ( CENB ),.BWENB ( 8'b0 ),
.AA ( AA ),.AB ( AB ),.DB ( DB ));
assign #1 CENA = ! rd_en; // it shows if read is allowed
assign #1 CENB = ! wr_en; // it shows if write is allowed
assign #1 AA = tail;
assign #1 AB = head;
assign #1 DB = data_in;
always@(posedge clk, negedge reset_n)    
	if(!reset_n)
		head <= 0;
	else if(!CENB)
		head <= head + 1'b1;

always @(posedge clk, negedge reset_n)    
  	if(!reset_n)
    		tail <= 0;
  	else if(!CENA)
    		tail <= tail + 1'b1;
  //count
always@(posedge clk, negedge reset_n)
  	if(!reset_n)
    		count <= 0;
  	else
     		case({!CENA , !CENB})
     			2'b00: count <= count;
     			2'b01: count <= count + 1'b1;
     			2'b10: count <= count - 1'b1;
     			2'b11: count <= count;
    		endcase
assign full  = count > 48;
assign empty = count < 16;
endmodule