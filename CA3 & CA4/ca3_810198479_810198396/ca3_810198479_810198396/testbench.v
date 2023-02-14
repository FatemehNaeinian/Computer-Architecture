`timescale 1ns/1ns
module mipsTB();
wire [31:0]Address,WriteData,MemoryOut;
reg clk,rst;
wire MemRead,MemWrite;
MIPScpu mips(clk,rst,MemoryOut,Address,WriteData,MemRead,MemWrite);
Memory Mem(clk,Address,WriteData,MemWrite,MemRead,MemoryOut);

initial
begin
   #1 rst=1'b1;
   clk=1'b0;
   #30 rst=1'b0;
   #7000 $stop;
end

always #8 clk=~clk;

endmodule