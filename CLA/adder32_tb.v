`timescale 1ns / 1ps
module adder32_tb();
    reg clk_1Hz;
    reg [31:0]a,b;
    reg c_in;
    wire [31:0]sum_o;
    wire c_o;
    adder32 u(a,b,c_in,sum_o,c_o);
    always #100 clk_1Hz = ~clk_1Hz;
    initial
    begin
        clk_1Hz=0;
        #200;
        a=32'h12341234;b=32'h81532657;c_in=1'b0;
        #200;
        a=32'h99999999;b=32'h34585317;c_in=1'b1;
        #200;
        a=32'h12217164;b=32'hff991157;c_in=1'b0;
        #200;
        a=32'hf5145641;b=32'hfcad1f2c;c_in=1'b0;
	#200;
        a=32'hffffffff;b=32'h00000001;c_in=1'b0;
        #200;
        a=32'h00ada00a;b=32'h31452223;c_in=1'b1;
	
    end
endmodule
