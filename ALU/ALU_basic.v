module ALU_basic(
	input wire   opA,
	      wire   opB,
	input wire [3:0] S  ,
        input wire    M,
		    Cin,
	output reg  DO ,
	output reg  CO  

	);
reg p;
reg g;
always@(*)
     begin
	p = ~(S[0]&(~opA)&(~opB)| S[1]&(~opA)&opB | S[2]&opA&(~opB) | S[3]&opA&opB);
	DO = p ^ Cin;
	g = S[3]&opA&opB | S[2]&opA&(~opB) | (~M);
	CO = g|(p&Cin);
     end
endmodule

