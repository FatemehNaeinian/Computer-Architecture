module Memory(clk,Address,WriteData,MemWrite,MemRead,MemoryOut);
	input clk,MemWrite,MemRead;
	input [31:0] Address,WriteData;
	output [31:0] MemoryOut;
	reg [31:0]Memory[0:2047];
	initial begin 
        	$readmemb("MEM.txt",Memory);
	end

	assign MemoryOut=(MemRead==1'b1) ? {Memory[Address+3],Memory[Address+2],Memory[Address+1],Memory[Address]} : 32'd0;
	always@(posedge clk)
		if(MemWrite==1'b1)
			{Memory[Address+3],Memory[Address+2],Memory[Address+1],Memory[Address]}=WriteData;
	
	//always@(posedge clk)begin
	//	Memory[Address>>2]<=MemWrite?WriteData:Memory[Address>>2];
	//end

	//assign MemoryOut=MemRead?Memory[Address>>2]:32'd0;

endmodule



