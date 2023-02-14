`timescale 1ns/1ns
module mux2to1_32bit(i0, i1, select ,Ioutput);
	input [31:0] i0,i1;
	input select;
	output [31:0] Ioutput;
	assign Ioutput = select ? i1 :i0;
endmodule