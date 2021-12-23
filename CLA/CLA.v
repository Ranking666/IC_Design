`timescale 1ns / 1ps


module CLA(
input [3:0] A,
input [3:0] B,
input cin,
output [3:0] S,
output cout
    );

wire [3:0] G,P,C;
assign C[0]=cin;
assign G=A&B;
assign P=A^B;

assign C[1] = G[0] |(P[0]&C[0]) ;
assign C[2] = G[1] |(P[1]&C[1]) ;
assign C[3] = G[2] |(P[2]&C[2]) ;
assign cout = G[3] |(P[3]&C[3]) ;

assign S = P^C;
endmodule
