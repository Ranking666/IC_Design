`timescale 1ns/1ps
module data_trans_FIFO_mod_tb;
    reg reset_n,
            clk;
    reg [7 : 0] data_in;
    reg     start,byt;
    wire [4 : 0]data_mod;
    wire    mod_en,
            full;
data_trans_FIFO_mod umodulation(
        .reset_n ( reset_n ),
        .clk ( clk ),
        .data_in ( data_in ),
        .start ( start ),
        .byte ( byt ),
        .dmod ( data_mod ),
        .mod_en ( mod_en ),
        .full ( full )
        );
always #5 clk = !clk;
wire empty = umodulation.empty;
reg ratio ;
reg [3 : 0] dinl = 0;
reg [3 : 0] dinh = 0;
always @(posedge clk, negedge reset_n)
    if( !reset_n ) begin
        start <= 1'b0;
        byt <= 1'b0;
        end
    else begin
        if( !full ) begin
            byt = ratio;
            if(byt) begin
                dinh = dinh + 1;
                dinl = dinh + 1;
                data_in <= { dinh , dinl};
                dinh = dinl;
                end
            else begin
                dinl = dinl + 1;
                dinh = 4'hF;
                data_in <= { dinh , dinl};
                end
            start <= 1'b1;
            end
        else
            start <= 1'b0;
        end
initial begin
    clk = 0;
    reset_n = 0;
    repeat(2)
    @(posedge clk);
    reset_n = 1;
    if( full != 1'b0 && empty != 1'b1) begin
        $display("system status error, full = %b empty = %b", full, empty);
        $finish;
        end
    $display($time,, "waiting data full");
    ratio = 1;
    wait(full);
    $display($time,"waiting data not full");
    wait(!full);
    $display($time, "waiting data empty");
    ratio = 0;
    wait(empty);
    repeat(32) @(posedge clk);
    ratio = 1;
    $display($time, "waiting data not empty");
    wait(!empty);
    $display($time, "waiting data full");
    wait(full);
    repeat(5) @(posedge clk);
    $finish;
    end
    parameter data_num = 5*8;
    parameter data_num5 = data_num/5;
    parameter data_num4 = data_num/4;
    parameter data_num8 = data_num/8;
    //typedef union {
    //    logic [data_num5 -1 : 0][4:0] data5;
    //    logic [data_num8 -1 : 0][7:0] data8;
    //} data_type;
    //data_type my_data;
    reg [4:0] data5 [data_num5 -1 : 0];
    reg [7:0] data8 [data_num8 -1 : 0];

    wire [7:0] data_FIFO;
    reg rd_en_rdy;
    wire rd_en;
    assign data_FIFO = umodulation.data_o_ino;
    assign rd_en = umodulation.rd_en;
    integer i_dat = 0;
    always @(posedge clk)
        rd_en_rdy <= rd_en;
    always @(posedge clk)
        if(rd_en_rdy) begin
            data8[i_dat] <= data_FIFO;
            i_dat <= ( i_dat + 1 ) % data_num8;
        end
    wire[4:0] data_exp;
    reg [4:0] data_rea;
    reg mod_en_rdy;
    integer i_exp = 0;
    reg error;
    assign data_exp = data5[i_exp];
    always @(posedge clk) begin
        mod_en_rdy <= mod_en;
        data_rea <= data_mod;
        if(mod_en_rdy) begin
            i_exp <= (i_exp + 1) % data_num5;
            error <= data_exp != data_rea;
            end
    end
endmodule