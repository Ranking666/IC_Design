`timescale 1ns/1ps
module data_mod(
 input  wire      clk,
 input  wire      reset_n,
 input  wire      rdy,
 input  wire[7:0] data_in,
 output reg [4:0] dmod,
 output reg       mod_en,
 output wire      rd
);
parameter zeroo = 4'hf, zero = 4'h0, one = 4'h1, two = 4'h2, there = 4'h3, four = 4'h4, five = 4'h5, six = 4'h6, seven = 4'h7;
reg [3:0] state;
reg [7:0] buffer;
reg read_eable;
always@(posedge clk, negedge reset_n)begin
	if(!reset_n)begin
		mod_en     <= 0;
		dmod       <= 0;
		read_eable <= 0;
		state      <= 4'hf;
		buffer     <= 0;
		end
	else if(!rdy) begin
		case(state)
			zeroo: begin
				dmod <= 0;
				mod_en <= 0;
				state <= 4'h0;
				read_eable <= 1;
				end

			 zero: begin
				dmod   <= data_in[4:0];
				mod_en <= 1;
				buffer[2:0] <= data_in[7:5];
				state  <= 4'h1;
				read_eable <= 1;
				end
			one: begin
				dmod[2:0] <= buffer[2:0];
				dmod[4:3] <= data_in[1:0];
				mod_en <= 1;
				buffer[5:0] <= data_in[7:2];
				state  <= 4'h2;
				read_eable <= 1;
				end
			two: begin
				dmod[4:0] <= buffer[4:0];
				mod_en <= 1;
				buffer[0] <= buffer[5];
				state  <= 4'h3;
				read_eable <= 0;
				end
			there: begin
				dmod[0] <= buffer[0];
				dmod[4:1] <= data_in[3:0];
				mod_en <= 1;
				buffer[3:0] <= data_in[7:4];
				state  <= 4'h4;
				read_eable <= 1;
				end
			four: begin
				dmod[3:0] <= buffer[3:0];
				dmod[4]   <= data_in[0];
				mod_en <= 1;
				buffer[6:0] <= data_in[7:1];
				state  <= 4'h5;
				read_eable <= 1;
				end
			five: begin
				dmod[4:0] <= buffer[4:0];
				mod_en <= 1;
				buffer[1:0] <= buffer[6:5];
				state  <= 4'h6;
				read_eable <= 0;
				end
			six: begin
				dmod[1:0] <= buffer[1:0];
				dmod[4:2] <= data_in[2:0];
				mod_en <= 1;
				buffer[4:0] <= data_in[7:3];
				state  <= 4'h7;
				read_eable <= 1;
				end
			seven: begin
				dmod[4:0] <= buffer[4:0];
				mod_en <= 1;
				state  <= 4'h0;
				read_eable <= 0;
				end
			endcase
			end
	else begin
		case(state)	
			two: begin
				dmod[4:0] <= buffer[4:0];
				mod_en <= 1;
				buffer[0] <= buffer[5];
				state  <= 4'h3;
				read_eable <= 0;
				end
			five: begin
				dmod[4:0] <= buffer[4:0];
				mod_en <= 1;
				buffer[1:0] <= buffer[6:5];
				state  <= 4'h6;
				read_eable <= 0;
				end
			seven: begin
				dmod[4:0] <= buffer[4:0];
				mod_en <= 1;
				state  <= 4'h0;
				read_eable <= 0;
				end
			default: begin
				dmod[4:0] <= 0;
				mod_en <= 0;
				read_eable <= 1;
				end
		endcase
		end
	end
assign rd = !rdy & read_eable;
endmodule

			
					