module mux_21_32b (i0, i1, select ,Ioutput);
input [31:0] i0,i1;
input select;
output [31:0] Ioutput;
assign Ioutput = select ? i1 :i0;
endmodule
