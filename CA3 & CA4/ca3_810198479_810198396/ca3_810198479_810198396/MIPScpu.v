module MIPScpu(clk,rst,MemoryOut,MemoryAddress,WriteDataMem,MemRead,MemWrite);

input clk,rst;
input [31:0] MemoryOut;

output [31:0] MemoryAddress,WriteDataMem;
output MemRead,MemWrite;

wire [3:0] flags;
wire [1:0] C;
wire [2:0] Inst ,Opc;
wire L1 , L2 , I ;
wire PCWrite,IorD,IRWrite,RegRead2,RegDst,RegWrite,AluSrcA,PcSrc,LdFlagZN,LdFlagCV;
wire [1:0] MemToReg,AluSrcB;
wire [2:0] AluOp;


control con(flags,C,Inst,L1,L2,I,Opc,PCWrite,IorD,IRWrite,RegRead2,RegDst,RegWrite,AluSrcA,clk,rst,PcSrc,LdFlagZN,
			 LdFlagCV,MemToReg,AluSrcB,AluOp,MemRead,MemWrite);

MIPSdp dp(PCWrite,IorD,IRWrite,RegRead2,RegDst,RegWrite,AluSrcA,MemToReg,clk,rst,PcSrc,LdFlagZN, LdFlagCV,AluSrcB,AluOp,
			MemoryOut,flags,MemoryAddress,C,Inst,I,L1,L2,Opc,WriteDataMem);

endmodule

