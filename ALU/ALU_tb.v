`timescale 1ns / 1ps
module ALU_tb();
 reg clk_1Hz;
 reg   [31:0] opA,opB;
 reg [3:0] S ;
 reg    M;
 reg	Cin;
 wire [31:0] DO;
 wire  C,V,N,Z ;
ALU_core u0(opA,opB,S,M,Cin,DO,C,V,N,Z);
always #100 clk_1Hz = ~clk_1Hz;
initial
 begin
    clk_1Hz = 0;
    #200;
    Cin = 1'b1; M = 1'b0;
    opA=32'h12341234;opB=32'h81532657;
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
    #200;
    M = 1'b1 ; Cin = 1'b0;
    S = 4'b1001;  
    #200;
    opA=32'h99999999;opB=32'h34585317;
    #200;
    opA=32'h12217164;opB=32'hff991157;
    #200;
    opA=32'hf5145641;opB=32'hfcad1f2c;
    #200;
    opA=32'hffffffff;opB=32'h00000001;
    #200;
    opA=32'h00ada00a;opB=32'h31452223;
    #200;
    Cin = 1'b1;S = 4'b0110;
    #200;
    opA=32'h99999999;opB=32'h34585317;
    #200;
    opA=32'h12217164;opB=32'hff991157;
    #200;
    opA=32'hf5145641;opB=32'hfcad1f2c;
    
	
    end
endmodule
