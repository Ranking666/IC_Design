

module ALARM_STATE_MACHINE(
    input   wire        reset_n,
                        clk,
                        //set_time,
                        alarm,
                        //Toggle_switch,
                        hours_set,
                        mins_set,
    //output  reg [4 : 0] hour,
    //        reg [5 : 0] mins,
    output  reg         hours,
                        mins
    
);

parameter first = 2'b00, second = 2'b01, third = 2'b10, four = 2'b11;
reg [1 : 0] state;
always @(posedge clk, negedge reset_n) begin
    if(!reset_n)begin
        hours = 0;
        mins = 0;
        state = 0;     
    end  
    else if(alarm)begin
        case(state)
            first: begin
                case({hours_set, mins_set})
                    first: begin
                        state = first;
                        hours = 0;
                        mins = 0;
                    end

                    second: begin
                        state = second;
                        hours = 0;
                        mins = 0;
                    end

                    third: begin
                        state = third;
                        hours = 0;
                        mins = 0;
                    end

                    four: begin
                        state = first;
                        hours = 0;
                        mins = 0;
                    end
            
                endcase
            end
                

            second: begin
                
                case({hours_set, mins_set})
                    first: begin
                        state = first;
                        hours = 0;
                        mins = 1;
                    end

                    second: begin
                        state = second;
                        hours = 0;
                        mins = 0;
                    end

                    third: begin
                        state = third;
                        hours = 0;
                        mins = 1;
                    end

                    four: begin
                        state = first;
                        hours = 0;
                        mins = 0;
                    end
                endcase
            
            end
                

            third: begin
                case({hours_set, mins_set})
                    first: begin
                        state = first;
                        hours = 1;
                        mins = 0;
                    end

                    second: begin
                        state = second;
                        hours = 1;
                        mins = 0;
                    end

                    third: begin
                        state = third;
                        hours = 0;
                        mins = 0;
                    end

                    four: begin
                        state = first;
                        hours = 0;
                        mins = 0;
                    end

                
                endcase

            end
                

        endcase
    end    
    else begin
	hours = 0;
        mins = 0;
        state = 0;  

	end


end


     
    
endmodule