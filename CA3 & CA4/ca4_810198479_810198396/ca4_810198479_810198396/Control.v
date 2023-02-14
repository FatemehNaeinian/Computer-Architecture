`timescale 1ns/1ns
module PIPE_Control(clk,rst,Bubble,Opc,Func,zero,ID_EX_Out,EX_MEM_Out,MEM_WB_Out,PCSrc);
	input clk,rst,Bubble;
	input [5:0]Opc,Func;
	input zero;
	output PCSrc;
	output [13:0] ID_EX_Out;
	output [5:0] EX_MEM_Out;
	output [2:0] MEM_WB_Out;
	wire[13:0]ID_EX_In;
	reg[1:0]ALUop;
	reg RegDst,RegWrite,ALUSrc,MemRead,MemWrite,MemToReg,PCSrc,WriteSrc,SelWrite,JorJr,Jmp;
	reg [2:0]ALUOperation;
	reg branch; 
	assign ID_EX_In=Bubble?{ALUSrc,RegDst,SelWrite,ALUOperation,JorJr,Jmp,branch,MemRead,MemWrite,MemToReg,WriteSrc,RegWrite}:14'b0;
	Register #14 IDEX(clk,rst,1'b1,ID_EX_In,ID_EX_Out); 
	Register #6 EXMEM(clk,rst,1'b1,ID_EX_Out[5:0],EX_MEM_Out);
	Register #3 MEMWB(clk,rst,1'b1,EX_MEM_Out[2:0],MEM_WB_Out);
	parameter[5:0] RT=0,addi=1,slti=2,lw=3,sw=4,beq=5,j=6,jr=7,jal=8;
	always@(Opc)begin
		{RegDst,RegWrite,ALUSrc,MemRead,MemWrite,MemToReg,branch,WriteSrc,SelWrite,JorJr,Jmp}=11'b0;
		ALUop=2'b00;
		case(Opc)
			slti:begin ALUSrc=1'b1;ALUop=2'b11;MemToReg=1'b0; WriteSrc=1'b0;RegDst=1'b0;SelWrite=1'b0;RegWrite=1'b1;end
			addi:begin ALUSrc=1'b1;ALUop=2'b01;MemToReg=1'b0; WriteSrc=1'b0;RegDst=1'b0;SelWrite=1'b0;RegWrite=1'b1;end
			jr:begin JorJr=1'b1;Jmp=1'b1;end
			jal:begin WriteSrc=1'b1;SelWrite=1'b1;JorJr=1'b0;Jmp=1'b1;RegWrite=1'b1;end
			j:begin JorJr=1'b0;Jmp=1'b1;end
			beq:begin ALUSrc=1'b0;ALUop=2'b10;Jmp=1'b0;branch=1'b1;end
			lw:begin ALUSrc=1'b1;ALUop=2'b01;MemRead=1'b1;MemToReg=1'b1; WriteSrc=1'b0;RegDst=1'b0;SelWrite=1'b0;RegWrite=1'b1;end
			sw:begin ALUSrc=1'b1;ALUop=2'b01;MemWrite=1'b1;end	
			RT:begin ALUSrc=1'b0;ALUop=2'b00;MemToReg=1'b0; WriteSrc=1'b0;RegDst=1'b1;SelWrite=1'b0;RegWrite=1'b1;end
		endcase
	end
	assign PCSrc=EX_MEM_Out[5]&zero;
	always@(Func,ALUop)begin 
		ALUOperation=3'b0;
		case(ALUop)
			2'b00:case(Func)
					6'b000001:ALUOperation=3'b010;
					6'b000010:ALUOperation=3'b110;
					6'b000100:ALUOperation=3'b000;
					6'b001000:ALUOperation=3'b001;
					6'b010000:ALUOperation=3'b111;
				endcase
			2'b01:ALUOperation=3'b010;
			2'b10:ALUOperation=3'b110;
			2'b11:ALUOperation=3'b111;	
		endcase
	end
endmodule

