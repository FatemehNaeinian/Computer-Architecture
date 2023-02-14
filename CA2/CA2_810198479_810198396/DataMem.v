module DataMem(adr,WriteData,clk,MemRead,MemWrite,ReadData);
input [31:0]adr,WriteData;
input MemRead,MemWrite,clk;
output [31:0]ReadData;

reg [31:0]DataMemory[0:65535];

initial
begin
   $readmemb("DataMemText.txt",DataMemory);
end

assign ReadData=(MemRead==1'b1) ? {DataMemory[adr+3],DataMemory[adr+2],DataMemory[adr+1],DataMemory[adr]} : 32'd0;
always@(posedge clk)
	if(MemWrite==1'b1)
		{DataMemory[adr+3],DataMemory[adr+2],DataMemory[adr+1],DataMemory[adr]}=WriteData;
	
endmodule