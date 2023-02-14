module ALU(Ainput,Binput,ALUop,ALUresult,zero);
input [31:0]Ainput,Binput;
input [2:0]ALUop;
output [31:0]ALUresult;
output zero;

assign ALUresult = (ALUop==3'b000) ?( Ainput & Binput ):
		   (ALUop==3'b001) ?( Ainput | Binput ):
		   (ALUop==3'b010) ?( Ainput + Binput ):
		   (ALUop==3'b110) ?( Ainput - Binput ):
		   (ALUop==3'b111 & Ainput<Binput) ? 32'd1 : 32'd0;

assign zero = (ALUresult==32'd0) ? 1'b1 : 1'b0;

endmodule
