

module CLA(input [3:0] a, input [3:0] b, output carry, output [3:0] sum);
wire [4:0] c;
wire [3:0] g,p;
wire [16:1] k;
assign c[0] = 1'b0;// setting c[0] = 0
// Propagate and generate block

and (g[0], a[0], b[0]);
and (g[1], a[1], b[1]);
and (g[2], a[2], b[2]);
and (g[3], a[3], b[3]);
xor (p[0], a[0], b[0]);
xor (p[1], a[1], b[1]);
xor (p[2], a[2], b[2]);
xor (p[3], a[3], b[3]);
// CLA Block
and (k[1], p[0], c[0]);
xor (c[1], g[0], k[1]);
and (k[2], k[1], p[1]);
and (k[3], p[1], g[0]);
xor (k[4], k[2], k[3]);
xor (c[2], k[4], g[1]);
and (k[5], k[2], p[2]);
and (k[6], k[3], p[2]);
and (k[7], p[2], g[1]);
xor (k[8], k[5], k[6]);
xor (k[9], k[7], k[8]);
xor (c[3], k[9], g[2]);
and (k[10], k[5], p[3]);
and (k[11], k[6], p[3]);
and (k[12], k[7], p[3]);
and (k[13], p[3], g[2]);
xor (k[14], k[10], k[11]);
xor (k[15], k[12], k[14]);
xor (k[16], k[13], k[15]);
xor (c[4], k[16], g[3]);
// Sum block
xor (sum[0], p[0], c[0]);
xor (sum[1], p[1], c[1]);
xor (sum[2], p[2], c[2]);
xor (sum[3], p[3], c[3]);
assign carry = c[4];
endmodule

module CLA_tb;
reg [3:0] a;
reg [3:0] b;
reg clock = 0;
wire c_out;
wire [3:0] sum;
CLA uut (
.a(a),
.b(b),

.carry(carry),
.sum(sum)
);

initial begin
$dumpfile("CLA.vcd");
$dumpvars(0,CLA_tb);
#10;
a = 4'b1101;
b = 4'b0111;
#30;
$finish;
end
endmodule