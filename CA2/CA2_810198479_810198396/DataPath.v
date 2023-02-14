module MIPSdp(RegDst,RegSrc,WriteSrc,RegWrite,AluSrc,MemToReg,clk,rst,PcSrc2,PcSrc1,AluOp,instruction,DataMemOut,zero,adrInstMem,adrDataMem,WriteDataMem);

input RegDst,RegSrc,WriteSrc,RegWrite,AluSrc,MemToReg,clk,rst,PcSrc1;
input [1:0]PcSrc2;
input [2:0]AluOp;
input [31:0]instruction;
input [31:0]DataMemOut;

output zero;
output [31:0]adrInstMem,adrDataMem;
output [31:0]WriteDataMem;

wire [4:0]MuxRegDst,MuxRegSrc;
wire [31:0]SignExOut,shl2SE,Jout,AdderOutPc4,AdderOutPcEx;
wire [31:0]MuxPcSrc1,MuxPcSrc2,MuxMemToReg,MuxAlu,MuxWriteSrc;
wire [31:0]AluResult,ReadData1,ReadData2;
wire [31:0]PCout;
wire [27:0]shl2inst;


mux_21_5b MuxDst(instruction[20:16], instruction[15:11], RegDst ,MuxRegDst);
mux_21_5b MuxSrc(MuxRegDst, 5'd31, RegSrc ,MuxRegSrc);
RegFile RF(instruction[25:21],instruction[20:16],MuxRegSrc,MuxWriteSrc,clk,rst,RegWrite,ReadData1,ReadData2);
mux_21_32b MuxWD(AdderOutPc4,MuxMemToReg, WriteSrc ,MuxWriteSrc);
signEx SE(instruction[15:0],SignExOut);
shl2 shl(SignExOut,shl2SE);
mux_21_32b MuxALU(ReadData2, SignExOut, AluSrc ,MuxAlu);
ALU Alu(ReadData1,MuxAlu,AluOp,AluResult,zero);
mux_21_32b MuxMem(AluResult, DataMemOut, MemToReg ,MuxMemToReg);
reg_32b PC(MuxPcSrc2,1'b1,rst, clk ,PCout);
adder adderPc4(PCout, 32'd4, AdderOutPc4);
shl2_25 shl25(instruction[25:0],shl2inst);
adder adderPcEx(shl2SE, AdderOutPc4,AdderOutPcEx);
mux_21_32b Muxadder(AdderOutPc4,AdderOutPcEx, PcSrc1 ,MuxPcSrc1);
mux_41_32b MuxPc(MuxPcSrc1,ReadData1,{AdderOutPc4[31:28],shl2inst[27:0]}, ,PcSrc2,MuxPcSrc2);

assign adrInstMem= PCout;
assign adrDataMem= AluResult;
assign WriteDataMem= ReadData2;
endmodule
