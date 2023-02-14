module shl2(shlinput,shloutput);
input [31:0]shlinput;
output [31:0]shloutput;
assign shloutput=shlinput<<2;
endmodule
