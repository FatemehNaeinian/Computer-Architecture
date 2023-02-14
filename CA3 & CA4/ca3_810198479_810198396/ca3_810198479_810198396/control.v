module control(flags,C,Inst,L1 , L2 , I,Opc,PCWrite,IorD,IRWrite,RegRead2,RegDst,RegWrite,AluSrcA,clk,rst,PcSrc,LdFlagZN,
			 LdFlagCV,MemToReg,AluSrcB,AluOp,MemRead,MemWrite);
input [3:0]flags;
input [1:0]C;
input [2:0]Inst;
input L1 , L2 , I;
input [2:0]Opc;
input clk,rst;
output reg PCWrite,IorD,IRWrite,RegRead2,RegDst,RegWrite,AluSrcA,PcSrc,LdFlagZN, LdFlagCV;
output reg [1:0]MemToReg,AluSrcB;
output reg [2:0]AluOp;
output reg MemRead,MemWrite;
reg ldflag,condition;
reg [4:0]ns,ps;
reg Op;
always@(posedge clk ,posedge rst)begin
	if(rst)begin
		 ps<=5'b00000;
		condition <=1'b0;
	end
	else
		ps<=ns;
end

assign condition = (C==2'b00 & flags[0]==1'b0) | (C==2'b01 & (flags[0]==1'b1 | (flags[1]^flags[3]==1'b1))) | (C==2'b10 &  (flags[1]^flags[3]==1'b0)) ;

always @(ps)begin 
	ns = 5'b00000;
	{PCWrite,IorD,IRWrite,RegRead2,RegDst,RegWrite,AluSrcA,LdFlagZN,LdFlagCV,ldflag,MemToReg,
		PcSrc,AluSrcB,Op,MemRead,MemWrite}=20'b0;
	case(ps)
		5'b00000 : begin ns=5'b00001; IorD=1'b0; MemRead=1'b1; IRWrite=1'b1;  end
		5'b00001 : begin ns=(condition) ? 5'b01101 :
				(Inst==3'b101 & L1==1'b0) ? 5'b00010 :
				(Inst==3'b101 & L1==1'b1) ? 5'b00011 :
				(Inst==3'b010) ? 5'b00100 :
				(Inst==3'b000 & I==1'b1) ? 5'b01110 : 5'b01111 ;
				AluSrcA=1'b0; AluSrcB=2'b11; Op=1'b0; end

		5'b00010 : begin ns=5'b10001; PcSrc=1'b1; PCWrite=1'b1;  end                                                     /// inst=101  L1=0
		5'b00011 : begin ns=5'b10000;  RegDst=1'b1; MemToReg=2'b10; RegWrite=1'b1;  end                        /// inst=101  L1=1
		5'b10000 : begin ns=5'b10001; PcSrc=1'b1; PCWrite=1'b1; end
		5'b10001 : begin ns=5'b01101; end
		5'b00100 : begin ns=(L2)? 5'b00110 : 5'b00111 ; AluSrcA=1'b1; AluSrcB=2'b10; Op=1'b0; RegRead2=1'b0; end                                     /// Inst=010
		//5'b00101 : begin ns=5'b00110; RegRead2=1'b0;  end                                                                               ///L2=1
		5'b00110 : begin ns=5'b01101; IorD=1'b1; MemWrite=1'b1; end
		5'b00111 : begin ns=5'b01000; IorD=1'b1; MemRead=1'b1; end                                                                      ///L2=0;
		5'b01000 : begin ns=5'b01101; MemToReg=2'b00; RegDst=1'b0; RegWrite=1'b1; end
		5'b01110 : begin ns=5'b01001; end
		5'b01001 : begin ns=(Opc==3'b101 | Opc==3'b110) ? 5'b01101 : 5'b01100; AluSrcA=1'b1; AluSrcB=2'b10; Op=1'b1; ldflag=1'b1; end ///Inst=000 I=1
		5'b01111 : begin ns=5'b01010; end
		5'b01010 : begin ns=5'b01011; RegRead2=1'b1;  end                                                                               ///Inst=000 I=0
		5'b01011 : begin ns=(Opc==3'b101 | Opc==3'b110) ? 5'b01101 : 5'b01100; AluSrcA=1'b1; AluSrcB=2'b01; Op=1'b1; ldflag=1'b1; end
		5'b01100 : begin ns=5'b01101; MemToReg=2'b01; RegDst=1'b0; RegWrite=1'b1; end
		5'b01101 : begin ns=5'b00000; AluSrcA=1'b0; AluSrcB=2'b00; Op=1'b0; PcSrc=1'b0; PCWrite=1'b1;  end
		endcase
end

always@(Op,Opc)begin
	AluOp=3'b000;
	if(Op==1'b0)
		AluOp=3'b000;
	else begin
		AluOp <= Opc;
	end
end

always@(ldflag)begin
	if(ldflag==1'b1)begin
		LdFlagZN=1'b1;
		if(Opc==3'b000 | Opc==3'b001 | Opc==3'b010 | Opc==3'b110)
			LdFlagCV=1'b1;

	end
end


endmodule

