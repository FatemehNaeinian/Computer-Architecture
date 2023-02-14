`timescale 1ns/1ns
module Register #(parameter size) (clk,rst,ld,Input,Output); 
	input clk,rst,ld;
	input [size-1:0]Input;
	output reg [size-1:0]Output;
	always @(posedge clk or posedge rst)begin
		if (rst) 
			Output<=0;
		else if(ld)
			Output<=Input;
	end
endmodule
	