module controller(opc,func,zero,RegDst,RegSrc,WriteSrc,AluOp,PcSrc2,RegWrite,AluSrc,MemToReg,PcSrc1,MemRead,MemWrite,RegWrite);
input [5:0]opc,func;
input zero;
output RegDst,RegSrc,WriteSrc,RegWrite,AluSrc,MemToReg,PcSrc1;
output MemRead,MemWrite;
output [1:0]PcSrc2;
output [2:0]AluOp;
reg RegDst,RegSrc,WriteSrc,AluSrc,MemToReg,MemRead,MemWrite,RegWrite;
reg [1:0]PcSrc2;
reg [1:0]Op;
reg branch;
ALUcontroller aluCon(Op,func,AluOp);
always@(opc)begin
	{RegDst,RegSrc,WriteSrc,RegWrite,AluSrc,MemToReg,
	MemRead,MemWrite,RegWrite,PcSrc2,Op,branch}=14'd0;
	case(opc)
	6'b000000 : {RegDst,WriteSrc,RegWrite}=3'b111; //RT
	6'b000001 : {WriteSrc,RegWrite,AluSrc,Op}=5'b11101; //addi
	6'b000010 : {WriteSrc,RegWrite,AluSrc,Op}=5'b11111; //slti
	6'b000011 : {WriteSrc,RegWrite,AluSrc,Op,MemRead,MemToReg}=7'b1110111; //lw
	6'b000100 : {AluSrc,MemWrite,Op}=4'b1101; //sw
	6'b000101 : {Op,branch}=3'b101; //beq
	6'b000110 : {PcSrc2}=2'b10; //j
	6'b000111 : {PcSrc2}=2'b01; //jr
	6'b001000 : {PcSrc2,RegSrc,RegWrite}=4'b1011; //jal
	endcase
end
assign PcSrc1=branch&zero;
endmodule


module ALUcontroller(Op,func,AluOp);
input [1:0]Op;
input [5:0]func;
output reg [2:0]AluOp;

always@(Op,func)begin
	AluOp=3'b000;
	if(Op==2'b11) //slti
		AluOp=3'b111;
	else if(Op==2'b10) //beq
		AluOp=3'b110;
	else if(Op==2'b01) //lw/sw/addi
		AluOp=3'b010;
	else begin
	case(func)
		6'b000001 :AluOp=3'b010 ; //add
		6'b000010 :AluOp=3'b110 ; //sub
		6'b000100 :AluOp=3'b000 ; //and
		6'b001000 :AluOp=3'b001 ; //or
		6'b010000 :AluOp=3'b111 ; //slt
		default : AluOp=3'b000 ;
	endcase
	end
end

endmodule