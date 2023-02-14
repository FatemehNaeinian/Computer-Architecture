`timescale 1ns/1ns
module PIPE_TB();
	reg clk=1'b0;
	reg rst=1'b0;
	wire [31:0]PCOut,InstOut,DMReadData,DMAddress,DMWriteData;
	wire MemRead,MemWrite;

	PIPE_Top pipe(clk,rst,InstOut,DMReadData,PCOut,DMAddress,DMWriteData,MemRead,MemWrite);
	InstMem inst(PCOut, InstOut); 
	DataMem data(clk,DMAddress,DMWriteData,MemRead,MemWrite,DMReadData);

	always#5 clk=~clk;
	initial begin 
	#1 rst=1'b1;
	#1 rst=1'b0;
	#4000 $stop;
	end

endmodule
