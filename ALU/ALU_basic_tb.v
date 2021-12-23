`timescale 1ns / 1ps
module ALU_basic_tb();
 reg clk_1Hz;
 reg   opA,opB;
 reg [3:0] S ;
 reg    M;
 reg	Cin;
 wire  DO,CO ;
ALU_basic u0(opA,opB,S,M,Cin,DO,CO);
always #100 clk_1Hz = ~clk_1Hz;
initial
 begin
    clk_1Hz = 0;
    #200;
    Cin = 1'b1; M = 1'b0;
    opA = 1'b1; opB = 1'b0;
    S = 4'b0000;
    #200; S = 4'b0001;
    #200; S = 4'b0010;
    #200; S = 4'b0011;
    #200; S = 4'b0100;
    #200; S = 4'b0101;
    #200; S = 4'b0110;
    #200; S = 4'b0111;
    #200; S = 4'b1000;
    #200; S = 4'b1001;
    #200; S = 4'b1010;
    #200; S = 4'b1011;
    #200; S = 4'b1100;
    #200; S = 4'b1101;
    #200; S = 4'b1110;
    #200; S = 4'b1111;
    #200; Cin = 1'b0; M = 1'b1;S = 4'b1001;
    #200; opA = 1'b1; opB = 1'b1;
    #200; Cin = 1'b1; S = 4'b0110;
    #200; opA = 1'b1; opB = 1'b0;
    #200; opA = 1'b0; opB = 1'b1;
end
endmodule
 
    


