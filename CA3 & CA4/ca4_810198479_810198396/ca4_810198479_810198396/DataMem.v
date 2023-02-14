`timescale 1ns/1ns
module DataMem(clk,Address,WriteData,MemRead,MemWrite,ReadData);
	input clk,MemRead,MemWrite;
	input [31:0]WriteData,Address;
	output reg[31:0]ReadData;
	reg signed [31:0] DataMem[0:511];
	initial begin 
        	$readmemb("Data_Mem.txt",DataMem,250);
	end
	always@(posedge clk)begin
		DataMem[Address>>2]<=MemWrite?WriteData:DataMem[Address>>2];
	end
	always@(MemRead,Address,DataMem)begin
		ReadData=MemRead?DataMem[Address>>2]:32'd0;
	end
endmodule