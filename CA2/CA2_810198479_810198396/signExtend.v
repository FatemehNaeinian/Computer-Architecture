module signEx(inputSE,outputSE);
input [15:0]inputSE;
output [31:0]outputSE;

assign outputSE={{16{inputSE[15]}},inputSE};
endmodule
