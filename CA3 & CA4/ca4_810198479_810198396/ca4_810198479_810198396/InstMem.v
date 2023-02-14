`timescale 1ns/1ns
module InstMem(Address, Inst); 
    	input [31:0] Address;        
	output [31:0] Inst;       
    	reg [31:0] InstMem[0:511];
	initial begin 
		$readmemb("InstMemText.txt",InstMem);
	end
	assign Inst = InstMem[Address>>2];	
endmodule
