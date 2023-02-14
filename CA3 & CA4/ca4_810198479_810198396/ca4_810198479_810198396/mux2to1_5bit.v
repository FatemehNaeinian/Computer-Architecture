`timescale 1ns/1ns
module mux2to1_5bit(i0, i1, select ,Ioutput);
	input [4:0] i0,i1;
	input select;
	output [4:0] Ioutput;
	assign Ioutput = select ? i1 :i0;
endmodule

