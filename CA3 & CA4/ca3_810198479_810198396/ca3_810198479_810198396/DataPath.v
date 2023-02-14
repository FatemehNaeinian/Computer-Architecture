module MIPSdp(PCWrite,IorD,IRWrite,RegRead2,RegDst,RegWrite,AluSrcA,MemToReg,clk,rst,PcSrc,LdFlagZN, LdFlagCV,AluSrcB,AluOp,
	MemoryOut,flags,MemoryAddress,C,Inst,I,L1,L2,Opc,WriteDataMem);

input PCWrite,IorD,IRWrite,RegRead2,RegDst,RegWrite,AluSrcA,clk,rst,PcSrc,LdFlagZN, LdFlagCV;
input [1:0]MemToReg,AluSrcB;
input [2:0]AluOp;
input [31:0]MemoryOut;

output [3:0]flags;
output [31:0]MemoryAddress;
output [1:0]C;
output [2:0]Inst;
output L1 , L2 , I;
output [2:0]Opc;
output [31:0] WriteDataMem;
wire [31:0] PCOut,IROut,MDROut,AOut,BOut,ALUOut;
wire [3:0] ALUFlag;
wire [1:0] ALUFlagZN,ALUFlagCV,flagZNOut,flagCVOut;
wire [31:0] MemAddressOut,WriteDataOut,AluSrcAOut,AluSrcBOut,PCSrcOut;
wire [3:0] ReadReg2Out,WriteRegOut;
wire [31:0] ALUResult,ReadData1,ReadData2;

reg_32b Pc(PCSrcOut, PCWrite, rst , clk ,PCOut);
reg_32b IR(MemoryOut, IRWrite, rst , clk ,IROut);
reg_32b MDR(MemoryOut, 1'b1, rst , clk ,MDROut);
reg_32b A(ReadData1, 1'b1, rst , clk ,AOut);
reg_32b B(ReadData2, 1'b1, rst , clk ,BOut);
reg_32b AlUOut(ALUResult, 1'b1, rst , clk ,ALUOut);
reg_2b flagZN(ALUFlagZN, LdFlagZN, rst , clk ,flagZNOut);
reg_2b flagCV(ALUFlagCV, LdFlagCV, rst , clk ,flagCVOut);

mux_21_32b MuxIorD(PCOut, ALUOut,IorD ,MemAddressOut);
mux_21_4b MuxRegRead2(IROut[15:12], IROut[3:0], RegRead2 ,ReadReg2Out);
mux_21_4b MuxRegDst(IROut[15:12],4'd15, RegDst ,WriteRegOut);
mux_41_32b MuxMemToReg(MDROut,ALUOut,PCOut,,MemToReg,WriteDataOut);
mux_21_32b MuxAluSrcA(PCOut, AOut, AluSrcA ,AluSrcAOut);
mux_41_32b MuxAluSrcB(32'd1,BOut,{{20{IROut[11]}},IROut[11:0]},{{6{IROut[25]}},IROut[25:0]},AluSrcB,AluSrcBOut);
mux_21_32b MuxpcSrc(ALUResult, ALUOut, PcSrc ,PCSrcOut);

ALU alu1(AluOp,AluSrcAOut,AluSrcBOut,ALUResult,ALUFlag);
assign ALUFlagZN = {ALUFlag[0],ALUFlag[2]};
assign ALUFlagCV = {ALUFlag[1],ALUFlag[3]};

RegFile RF(IROut[19:16],ReadReg2Out,WriteRegOut,WriteDataOut,clk,rst,RegWrite,ReadData1,ReadData2);

assign flags = {flagZNOut,flagCVOut};
assign MemoryAddress = MemAddressOut;
assign C = IROut[31:30];
assign Inst = IROut[29:27];
assign Opc = IROut[22:20];
assign I = IROut[23];
assign L1 = IROut[26];
assign L2 = IROut[20];
assign WriteDataMem = BOut;
endmodule
