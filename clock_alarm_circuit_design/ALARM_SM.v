
module ALARM_SM (
input   wire    reset_n,
                clk,
                Toggle_switch,
                RINGER1,

output  reg     SPEAKER_OUT
                
);

always @(posedge clk, negedge reset_n) begin

    if(!reset_n)begin
        
        SPEAKER_OUT = 0;
    end

    else begin
        if(Toggle_switch & RINGER1)
            SPEAKER_OUT = 1;
        
        else
            SPEAKER_OUT = 0;

    end

 
    end
    
endmodule