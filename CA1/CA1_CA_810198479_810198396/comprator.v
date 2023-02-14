module comprator(a,d,OV);
input [4:0]a,d;
output OV;
assign OV=(d>a) ? 1'b0 : 1'b1 ;
endmodule