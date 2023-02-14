module MIPScpu(rst,clk,instruction,DataMemOut,adrInstMem,adrDataMem,WriteDataMem,MemRead,MemWrite);
input rst,clk;
input [31:0]instruction;
input [31:0]DataMemOut;

output [31:0]adrInstMem,adrDataMem,WriteDataMem;
output MemRead,MemWrite;

wire RegDst,RegSrc,WriteSrc,RegWrite,AluSrc,MemToReg;
wire zero ;
wire [2:0]AluOp;
wire [1:0]PcSrc2;
wire PcSrc1;


MIPSdp DP(RegDst,RegSrc,WriteSrc,RegWrite,AluSrc,MemToReg,clk,rst,PcSrc2,PcSrc1,AluOp,instruction,DataMemOut,zero,adrInstMem,adrDataMem,WriteDataMem);
controller CON(instruction[31:26],instruction[5:0],zero,RegDst,RegSrc,WriteSrc,AluOp,PcSrc2,RegWrite,AluSrc,MemToReg,PcSrc1,MemRead,MemWrite,RegWrite);

endmodule

