
module ALARM_COUNTER(
input   wire    reset_n,
		clk,
                HOURS,
                MINS,

output  reg [3:0]    HOURS_OUT,
        reg [5:0]    MINUTES_OUT,
        reg          AM_PM_OUT

);
reg flag;
reg [3:0]HOURS_OUT_reg;
reg [5:0]MINUTES_OUT_reg;

always @(posedge clk, negedge reset_n) begin

    if(!reset_n)begin
        HOURS_OUT_reg = 0;
        MINUTES_OUT_reg = 0;
        AM_PM_OUT = 0;
	HOURS_OUT = 0;
	MINUTES_OUT = 0;
        flag = 0;
        
    end 

    else begin
        HOURS_OUT_reg = HOURS_OUT_reg + HOURS;
        MINUTES_OUT_reg = MINUTES_OUT_reg + MINS;

        if(MINUTES_OUT_reg == 60)begin
            MINUTES_OUT_reg = 0;
            HOURS_OUT_reg = HOURS_OUT_reg + 1;
        end

        if(HOURS_OUT_reg == 24)
            HOURS_OUT_reg = 0;

        flag = HOURS_OUT_reg / 12;

        if(flag == 0)
            AM_PM_OUT = 0;
            else
                AM_PM_OUT = 1;
        HOURS_OUT = HOURS_OUT_reg % 12;
	MINUTES_OUT = MINUTES_OUT_reg;




    end 
 
    end
    
endmodule