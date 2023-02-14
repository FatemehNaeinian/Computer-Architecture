`timescale 1ns/1ns
module ALU(Operation,A,B,Result,flag);
	input signed [31:0]A,B;
	input [2:0]Operation;
	output reg [31:0]Result;
	output [3:0]flag;
	reg carry;
	always@(Operation,A,B)begin	
		Result=32'b0;
		if(Operation==3'b000) ///ADD
			{carry,Result}=A+B;
		else if(Operation==3'b001)  ///SUB
			{carry,Result}=A-B;
		else if(Operation==3'b010)  ///RSB
			{carry,Result}=A-B;
		else if(Operation==3'b011)  ///AND
			Result=A&B;
		else if(Operation==3'b100)  ///NOT
			Result=~B;
		else if(Operation==3'b101)  ///TST
			Result=A&B;
		else if(Operation==3'b110)  ///CMP
			{carry,Result}=A-B;
		else if(Operation==3'b111)  ///MOV
			Result=B;
	end

	assign flag[0] = (Result==32'd0) ? 1'b1 : 1'b0; ///zero
	assign flag[1] = (carry==1'b1) ? 1'b1 : 1'b0; ///carry
	assign flag[2] = (Result[31]==1'b1) ? 1'b1 : 1'b0; ///negetive
	assign flag[3] = ((~A[31]&~B[31]&Result[31])|(A[31]&B[31]&~Result[31])) ? 1'b1 : 1'b0; ///overflow
endmodule
