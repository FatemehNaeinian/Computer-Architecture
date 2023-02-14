module mux_41 (i0,i1,i2,i3,sel,Ioutput);
input [4:0] i0,i1,i2,i3;
input [1:0] sel;
output [4:0] Ioutput;

assign Ioutput =(sel==2'b00) ? i0:
	 	(sel==2'b01) ? i1:
		(sel==2'b10) ? i2:
	 	(sel==2'b11) ? i3: 1'bx;

endmodule
