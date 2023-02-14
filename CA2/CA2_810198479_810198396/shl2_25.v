module shl2_25(shlinput,shloutput);
input [25:0]shlinput;
output [27:0]shloutput;
assign shloutput={shlinput[25:0],2'b0};
endmodule
