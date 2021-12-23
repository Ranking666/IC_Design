module FIFO #(
  parameter DEPTH = 6,
  	   WIDTH = 8,
  	   MAX_COUNT = (1 << DEPTH)
  )(
  input wire	        clk,            //??
  input wire	        reset_n,            //??
  input [WIDTH-1:0]	data_in,            //??????
  input wire	        rd_en,          //???
  input wire	        wr_en,         //???
  output reg[WIDTH-1:0] data_o,          //??????
  output reg 	        empty,        //?????
  output reg	        full    //??????
  );

  reg [DEPTH-1 : 0] tail; 	//???
  reg [DEPTH-1 : 0] head;	//???
  reg [DEPTH-1 : 0] count; 	//???????

  reg[WIDTH-1 : 0]fifomem [MAX_COUNT - 1 : 0]; 
//read
  always@(posedge clk)
    if(rd_en)
      data_o <= fifomem[tail];

   //write   
  always@(posedge clk)
      if(wr_en)
        fifomem[head] <= data_in;

  //??head??
  always@(posedge clk)    
	if(!reset_n)
		head <= 0;
	else if(wr_en)
		head <= head + 1'b1;

  //??tail??
  always @(posedge clk)    
  	if(!reset_n)
    		tail <= 0;
  	else if(rd_en)
    		tail <= tail + 1'b1;
  //count
  always@(posedge clk)
  	if(!reset_n)
    		count <= 0;
  	else
     		case({rd_en , wr_en})
     			2'b00: count <= count;
     			2'b01: count <= count + 1'b1;
     			2'b10: count <= count - 1'b1;
     			2'b11: count <= count;
    		endcase

  //?????full
  always @(count)
        if(count >= MAX_COUNT*3/4)
                full = 1'b1;
        else
                full = 1'b0;

  //?????empty
  always @(count)
        if(count <= MAX_COUNT/4)
    	        empty = 1'b1;
         else
    	        empty = 1'b0;

endmodule

