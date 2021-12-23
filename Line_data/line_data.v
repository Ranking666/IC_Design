module line_data(
     input wire clk,clr,A,B,
     output wire Z
);
reg [3:0] state;
reg [1:0] D;
reg out;
parameter zero = 4'b0000, one = 4'b0001,two = 4'b0010, thre = 4'b0011, four = 4'b0111;
parameter first = 2'b00, sec = 2'b01,thr = 2'b10, forth = 2'b11;
always @(posedge clk, negedge clr)begin
	D[1] <= A;
	D[0] <= B;
	if(!clr) begin state <= 0;
			 out <= 0;
		   end		
	else begin
 	  if(out) out <= 0;
	  else
	    case(state)
	     zero: case(D)
		      first: state <= two;
		      sec:   state <= one;
		      thr:   state <= two;
		      forth: state <= zero;
		   endcase
	     one:  case(D)
		      first: state <= two;
		      sec:   state <= one;
		      thr:   state <= two;
		      forth: state <= four;
		   endcase
	     two:  case(D)
		      first: state <= two;
		      sec:   state <= one;
		      thr:   state <= two;
		      forth: state <= thre;
	           endcase
	     thre: case(D)
		      first: state <= two;
		      sec:   state <= one;
		      thr:   begin
				state <= zero;
				out   <=    1;
			     end
		      forth: state <= zero;
		   endcase
	     four: case(D)
		      first: begin
  				state <= two;
				out   <=   1;
			     end
		      sec:   begin
				state <= one;
				out   <=   1;
		             end
		      thr:   state <= two;
		      forth: state <= zero;
		   endcase
	endcase
        end
	end
assign Z = out ;
endmodule