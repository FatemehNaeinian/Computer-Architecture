`timescale 1ns/1ns
module PIPE_DP(clk,rst,RegDst,RegWrite,ALUSrc,ALUOp,MemToReg,PCSrc,WriteSrc,SelWrite,InstOut,DMReadData,zero,JorJr,selA,selB,
	PCWrite,IF_ID_Write,Bubble,Jmp,Func,Opc,PCOut,DMAddress,DMWriteData, EX_MEM_Rd , MEM_WB_Rd , ID_EX_Rt , ID_EX_Rs , IF_ID_Rs , IF_ID_Rt);
	input [31:0]InstOut,DMReadData;
	input clk,rst,RegDst,RegWrite,ALUSrc,MemToReg,PCSrc,WriteSrc,SelWrite,JorJr,Jmp,PCWrite,IF_ID_Write,Bubble;
	input [1:0]selA,selB;
	input [2:0]ALUOp;
	output [4:0]EX_MEM_Rd,MEM_WB_Rd,ID_EX_Rt,ID_EX_Rs,IF_ID_Rs,IF_ID_Rt;
	output [5:0]Opc,Func;
	output [31:0]PCOut,DMAddress,DMWriteData;
	output zero;
	wire [31:0]mux1out,mux2out,mux3out,mux4out,mux7out,mux8out,mux9out,mux10out;
	wire [4:0]mux5out,mux6out;
	wire [63:0]IF_ID_Out;
	wire [153:0]ID_EX_Out;
	wire [133:0]EX_MEM_Out;
	wire [100:0]MEM_WB_Out;
	wire[31:0]adder1out,adder2out;
	wire ALUzero;
	wire [31:0]ALUResult;	
	wire [31:0]ReadData1,ReadData2;
	wire [31:0]PCOut;	
	assign zero=EX_MEM_Out[69];
	assign Opc=IF_ID_Out[31:26];
	assign Func=IF_ID_Out[5:0];
	assign EX_MEM_Rd=EX_MEM_Out[4:0];
	assign MEM_WB_Rd=MEM_WB_Out[4:0];
	assign ID_EX_Rt=ID_EX_Out[116:112];
	assign ID_EX_Rs=ID_EX_Out[121:117];
	assign IF_ID_Rs=IF_ID_Out[25:21];
	assign IF_ID_Rt=IF_ID_Out[20:16];
	assign DMAddress=EX_MEM_Out[68:37];
	assign DMWriteData=EX_MEM_Out[36:5];
	Register #64 IF_ID(clk,rst,IF_ID_Write,{adder1out,InstOut},IF_ID_Out);
	Register #154 ID_EX(clk,rst,1'b1,{IF_ID_Out[63:32],IF_ID_Out[25:0],ReadData1,ReadData2,{{16{IF_ID_Out[15]}},IF_ID_Out[15:0]}},ID_EX_Out);	
	Register #134 EX_MEM(clk,rst,1'b1,{ID_EX_Out[153:122],adder2out,ALUzero,ALUResult,mux10out,mux6out},EX_MEM_Out);
	Register #101 MEM_WB(clk,rst,1'b1,{EX_MEM_Out[133:102],DMReadData,EX_MEM_Out[68:37],EX_MEM_Out[4:0]},MEM_WB_Out);
	Register #32 PC(clk,rst,PCWrite,mux1out,PCOut); 	
	mux2to1_32bit m1(mux3out,mux2out,Jmp,mux1out);
	mux2to1_32bit m2({ID_EX_Out[153:150],ID_EX_Out[121:96],2'b0},mux9out,JorJr,mux2out);
	mux2to1_32bit m3(adder1out,EX_MEM_Out[101:70],PCSrc,mux3out);
	mux2to1_32bit m4(mux10out,ID_EX_Out[31:0],ALUSrc,mux4out);
	mux2to1_5bit m5(ID_EX_Out[116:112],ID_EX_Out[111:107],RegDst,mux5out);
	mux2to1_5bit m6(mux5out,5'd31,SelWrite,mux6out);
	mux2to1_32bit m7(MEM_WB_Out[36:5],MEM_WB_Out[68:37],MemToReg,mux7out);
	mux2to1_32bit m8(mux7out,MEM_WB_Out[100:69],WriteSrc,mux8out);		
	mux4to1_32b m9(ID_EX_Out[95:64],mux8out,EX_MEM_Out[68:37],32'b0,selA,mux9out);
	mux4to1_32b m10(ID_EX_Out[63:32],mux8out,EX_MEM_Out[68:37],32'b0,selB,mux10out);
	RegisterFile RegFile(clk,rst,RegWrite,IF_ID_Out[25:21],IF_ID_Out[20:16],MEM_WB_Out[4:0],mux8out,ReadData1,ReadData2);
	Adder add1(32'd4,PCOut,1'b0,,adder1out);
	Adder add2(ID_EX_Out[153:122],{ID_EX_Out[31:0]<<2},1'b0,,adder2out);
	ALU alu(ALUOp,mux9out,mux4out,ALUResult,ALUzero);
endmodule