`timescale 1ns/1ns
module Adder(A,B,cin,cout,S);
	input [31:0]A,B;
	input cin;
	output [31:0]S;
	output cout;
	assign {cout,S}=A+B+cin;
endmodule