module adder32(a,b,c_in,sum_o,c_o);
    input [31:0] a;
    input [31:0] b;
    input c_in;
    output [31:0] sum_o;
    output c_o;
    wire [6:0] carry;
    CLA u0(a[3:0],b[3:0],c_in,sum_o[3:0],carry[0]);
    CLA u1(a[7:4],b[7:4],carry[0],sum_o[7:4],carry[1]);
    CLA u2(a[11:8],b[11:8],carry[1],sum_o[11:8],carry[2]);
    CLA u3(a[15:12],b[15:12],carry[2],sum_o[15:12],carry[3]);
    CLA u4(a[19:16],b[19:16],carry[3],sum_o[19:16],carry[4]);
    CLA u5(a[23:20],b[23:20],carry[4],sum_o[23:20],carry[5]);
    CLA u6(a[27:24],b[27:24],carry[5],sum_o[27:24],carry[6]);
    CLA u7(a[31:28],b[31:28],carry[6],sum_o[31:28],c_o);
endmodule
