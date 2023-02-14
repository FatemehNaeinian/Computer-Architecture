`timescale 1ns/1ns
module mipsTB();
wire [31:0]instruction,DataMemOut,adrInstMem,adrDataMem,WriteDataMem;
wire MemRead,MemWrite;
reg clk,rst;


MIPScpu cpu(rst,clk,instruction,DataMemOut,adrInstMem,adrDataMem,WriteDataMem,MemRead,MemWrite);
DataMem DM(adrDataMem,WriteDataMem,clk,MemRead,MemWrite,DataMemOut);
InstMem IM(adrInstMem,instruction);

initial
begin
   rst=1'b1;
   clk=1'b0;
   #20 rst=1'b0;
   #3250 $stop;
end

always #8 clk=~clk;

endmodule