`timescale 1ns / 1ps
module CLA_tb();
    reg clk_1Hz;
    reg [3:0]a,b;
    reg cin;
    wire [3:0]s;
    wire cout;
    CLA u(a,b,cin,s,cout);
    always #100 clk_1Hz = ~clk_1Hz;
    initial
    begin
        clk_1Hz=0;
        #200;
        a=4'b0010;b=4'b0001;cin=1'b0;
        #200;
        a=4'b0110;b=4'b0010;cin=1'b1;
        #200;
        a=4'b1010;b=4'b1101;cin=1'b0;
        #200;
        a=4'b0011;b=4'b0100;cin=1'b0;
    end
endmodule
