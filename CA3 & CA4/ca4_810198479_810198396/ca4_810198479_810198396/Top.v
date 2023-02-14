`timescale 1ns/1ns
module PIPE_Top(clk,rst,InstOut,DMReadData,PCOut,DMAddress,DMWriteData,MemRead,MemWrite);
	input clk,rst;
	input [31:0]InstOut,DMReadData;
	output MemRead,MemWrite;
	output [31:0]DMWriteData,DMAddress,PCOut;
	wire [4:0]ID_EX_Rt,ID_EX_Rs,IF_ID_Rs,IF_ID_Rt,EX_MEM_Rd,MEM_WB_Rd;
	wire IF_ID_Write,PCWrite,Bubble;
	wire [1:0]selA,selB;
	wire RegDst,RegWrite,ALUSrc,MemToReg,PCSrc,WriteSrc,SelWrite,JorJr,Jmp;
	wire [2:0]ALUOperation;
	wire [4:0]Rt,Rs;
	wire [13:0] ID_EX_Out;
	wire [5:0] EX_MEM_Out;
	wire [2:0] MEM_WB_Out;
	wire [5:0]Opc,Func;
	wire zero;
	wire ID_EX_MemRead;
	wire EX_MEM_RegWrite,MEM_WB_RegWrite;
	assign EX_MEM_RegWrite=EX_MEM_Out[0];
	assign MEM_WB_RegWrite=MEM_WB_Out[0];
	assign RegWrite=MEM_WB_Out[0];
	assign WriteSrc=MEM_WB_Out[1];
	assign MemToReg=MEM_WB_Out[2];
	assign MemWrite=EX_MEM_Out[3];
	assign MemRead=EX_MEM_Out[4];
	assign Jmp=ID_EX_Out[6];
	assign JorJr=ID_EX_Out[7];
	assign ALUOperation=ID_EX_Out[10:8];
	assign SelWrite=ID_EX_Out[11];
	assign RegDst=ID_EX_Out[12];
	assign ALUSrc=ID_EX_Out[13];
	assign Rt=IF_ID_Rt;
	assign Rs=IF_ID_Rs;
	assign ID_EX_MemRead=ID_EX_Out[4];
	PIPE_DP dp(clk,rst,RegDst,RegWrite,ALUSrc,ALUOperation,MemToReg,PCSrc,WriteSrc,SelWrite,InstOut,DMReadData,zero,JorJr,selA,selB,
		PCWrite,IF_ID_Write,Bubble,Jmp,Func,Opc,PCOut,DMAddress,DMWriteData,EX_MEM_Rd,MEM_WB_Rd,ID_EX_Rt,ID_EX_Rs,IF_ID_Rs,IF_ID_Rt);
	PIPE_Control con(clk,rst,Bubble,Opc,Func,zero,ID_EX_Out,EX_MEM_Out,MEM_WB_Out,PCSrc);
	HazardUnit hazard(clk,Rt,Rs,ID_EX_Rt,ID_EX_MemRead,Bubble,PCWrite,IF_ID_Write);
	ForwardingUnit forward(EX_MEM_RegWrite,MEM_WB_RegWrite,EX_MEM_Rd,MEM_WB_Rd,ID_EX_Rs,ID_EX_Rt,selA,selB);

endmodule