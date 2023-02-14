`timescale 1ns/1ns
module HazardUnit(clk,Rt,Rs,ID_EX_Rt,ID_EX_MemRead,Bubble,PCWrite,IF_ID_Write);
	input clk,ID_EX_MemRead;
	input [4:0]Rt,Rs,ID_EX_Rt;
	output reg Bubble,PCWrite,IF_ID_Write;
	always @(posedge clk,ID_EX_MemRead,Rt,Rs,ID_EX_Rt)begin
		{PCWrite,IF_ID_Write,Bubble}=3'b111;
		if(ID_EX_MemRead)begin
			if(Rt==ID_EX_Rt | Rs==ID_EX_Rt)begin	
				{PCWrite,IF_ID_Write,Bubble}<=3'b000;
			end
		end
	end
endmodule	
