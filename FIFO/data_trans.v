module data_trans(
     input wire reset_n, start, clk, byte,
     input wire [7 : 0] data_in,
     output wire [7 : 0] data_o, 
     output wire data_en
);
reg data_en_r;
reg [7 : 0] out;
reg [3:0] middle;
reg state;
parameter eight = 1'b0, four = 1'b1;
always @(posedge clk, negedge reset_n)begin
      if(!reset_n) begin 
		out <= 8'b0000_0000;
		data_en_r <= 0;
		state <= eight;
	        end		
      else begin
	if(start)begin
	 	if(byte)begin
			case(state)
				eight: begin
					out <= data_in;
					state <= eight;
					data_en_r <= 1;
					end
				four: begin  
					out[7:4] <= middle[3:0];
					out[3:0] <= data_in[7:4];
					middle[3:0] <= data_in[3:0];
					state <= four;
					data_en_r <= 1;
				      end
			  endcase
			end
		else begin
			case(state)
				eight: begin
					out <= 8'b00000000;
					middle[3:0] <= data_in[3:0];
					state <= four;
					data_en_r <= 0;
					end
				four: begin
					out[7:4] <= middle[3:0];
					out[3:0] <= data_in[3:0];
					state <= eight;
					data_en_r <= 1;
		                       end
			  endcase
		       end
		 end
	 else begin
		data_en_r <= 0;
		out <= 8'b0000_0000;
	     end
	end
       end
assign data_o = out;
assign data_en = data_en_r;
endmodule
		  
