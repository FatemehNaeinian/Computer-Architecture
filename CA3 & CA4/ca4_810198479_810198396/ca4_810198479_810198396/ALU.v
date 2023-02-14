`timescale 1ns/1ns
module ALU(Operation,A,B,Result,zero);
	input [31:0]A,B;
	input [2:0]Operation;
	output reg [31:0]Result;
	output zero;
	always@(Operation,A,B)begin	
		Result=32'b0;
		if(Operation==3'b000)
			Result=A&B;
		else if(Operation==3'b001)
			Result=A|B;
		else if(Operation==3'b010)
			Result=A+B;
		else if(Operation==3'b110)
			Result=A-B;
		else if(Operation==3'b111)begin
			if(A[31]==B[31])
				Result=(A<B)?32'b1:32'b0;
			if(A[31]==1'b1&B[31]==1'b0)
				Result=32'b1;
			if(A[31]==1'b0&B[31]==1'b1)
				Result=32'b0;
		end
	end

	assign zero = (Result==32'd0) ? 1'b1 : 1'b0;
endmodule