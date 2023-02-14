module RegFile(ReadReg1,ReadReg2,WriteReg,WriteData,clk,rst,regwrite,ReadData1,ReadData2);
input [3:0]ReadReg1,ReadReg2,WriteReg;
input [31:0]WriteData;
input clk,rst,regwrite;
output [31:0]ReadData1,ReadData2;
reg[31:0]RF[0:15];
assign ReadData1 =(ReadReg1==4'b0)?32'd0:RF[ReadReg1];
assign ReadData2 =(ReadReg2==4'b0)?32'd0:RF[ReadReg2];
integer j;
always @(posedge clk)
	if(rst)
	    for(j=0;j<16;j=j+1)
	         RF[j]<=32'd0;
	else if(regwrite==1'b1)
	     if(WriteReg!=4'd0)
		RF[WriteReg]<=WriteData;


endmodule
