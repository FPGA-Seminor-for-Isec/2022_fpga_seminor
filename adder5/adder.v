module adder(
   input clk,
	input [4:0]  a, // 5bit
	input [4:0]  b, // 5bit
	output [5:0] out, // 6bit
);

wire [3:0] carry;

fulladder fa0(.a(a[0]), .b(b[0]), .c_in(0), .s(out[0]), .c_out(carry[0]));
fulladder fa1(.a(a[1]), .b(b[1]), .c_in(carry[0]), .s(out[1]), .c_out(carry[1]));
fulladder fa2(.a(a[2]), .b(b[2]), .c_in(carry[1]), .s(out[2]), .c_out(carry[2]));
fulladder fa3(.a(a[3]), .b(b[3]), .c_in(carry[2]), .s(out[3]), .c_out(carry[3]));
fulladder fa4(.a(a[4]), .b(b[4]), .c_in(carry[3]), .s(out[4]), .c_out(out[5]));

endmodule

module fulladder(
	input a, b, c_in,
	output s, c_out
);

assign s = a ^ b ^ c_in;
assign c_out = (a & b) | (b & c_in) | (a & c_in);

endmodule