module mux_21_4b (i0, i1, select ,Ioutput);
input [3:0] i0,i1;
input select;
output [3:0] Ioutput;
assign Ioutput = select ? i1 :i0;
endmodule