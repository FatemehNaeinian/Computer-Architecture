`timescale 1ns/1ns
module ForwardingUnit(EX_MEM_RegWrite,MEM_WB_RegWrite,EX_MEM_Rd,MEM_WB_Rd,ID_EX_Rs,ID_EX_Rt,selA,selB);
	input EX_MEM_RegWrite,MEM_WB_RegWrite;
	input [4:0] EX_MEM_Rd,MEM_WB_Rd,ID_EX_Rs,ID_EX_Rt;
	output reg [1:0] selA,selB;
	always @(EX_MEM_RegWrite,MEM_WB_RegWrite,EX_MEM_Rd,MEM_WB_Rd,ID_EX_Rs,ID_EX_Rt)begin
		{selA,selB}=4'b0;
		if((EX_MEM_RegWrite==1'b1)&(EX_MEM_Rd==ID_EX_Rs)&(EX_MEM_Rd!=5'b0))
			selA=2'b10;
		if((EX_MEM_RegWrite==1'b1)&(EX_MEM_Rd==ID_EX_Rt)&(EX_MEM_Rd!=5'b0))
			selB=2'b10;
		if((MEM_WB_RegWrite==1'b1)&(MEM_WB_Rd==ID_EX_Rs)&(MEM_WB_Rd!=5'b0)& !((EX_MEM_RegWrite==1'b1)&(EX_MEM_Rd==ID_EX_Rs)&(EX_MEM_Rd!=5'b0)))
			selA=2'b01;
		if((MEM_WB_RegWrite==1'b1)&(MEM_WB_Rd==ID_EX_Rt)&(MEM_WB_Rd!=5'b0)& !((EX_MEM_RegWrite==1'b1)&(EX_MEM_Rd==ID_EX_Rt)&(EX_MEM_Rd!=5'b0)))
			selB=2'b01;
	end
endmodule
