`timescale 1ns/1ns
module RegisterFile(clk,rst,RegWrite,ReadReg1,ReadReg2,WriteReg,WriteData,ReadData1,ReadData2);
	input clk,rst,RegWrite;
	input[4:0]ReadReg1,ReadReg2,WriteReg;
	input [31:0]WriteData;
	output[31:0]ReadData1,ReadData2;
	reg [31:0] Registers [0:31];
	assign ReadData1 = Registers[ReadReg1];
	assign ReadData2 = Registers[ReadReg2];
	integer k;
	always @(negedge clk or posedge rst)begin
		if(rst)
   			for (k = 0; k < 32; k = k + 1) begin
   				Registers[k] <= 32'b0; 
   			end 	
		else if (RegWrite) 
			Registers[WriteReg] <= WriteData;
	end
endmodule
