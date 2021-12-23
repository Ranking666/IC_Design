module ALU_core#(
	parameter n=32
	)(
	
	input wire [n-1:0] opA,
			   opB,
	input wire [3:0]   S  ,
	input wire         M  ,
			   Cin,
	output reg [n-1:0] DO ,
	output reg         C  ,
			   V  ,
			   N  ,
			   Z  


	);

wire [32:0] CO;
wire [31:0] DD;
assign CO[0] = Cin;
generate
    genvar i;
    for(i=0;i<32;i=i+1)begin:u
	ALU_basic add(opA[i], opB[i],S, M, CO[i], DD[i],CO[i+1]);
    end
endgenerate
always@(*)begin
	DO = DD;
	C = CO[32];
	N = DO[31];
  	if(CO[32]^CO[31])begin
		V = 1'b1;
	     end
	else
	begin
		V = 1'b0;
 	end
	if(|DO)
	begin
		Z = 1'b0;
	end
	else
	begin
		Z = 1'b1;
	end	
	end
endmodule

