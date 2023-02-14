module InstMem(adr,Inst);
input [31:0]adr;
output [31:0]Inst;
reg [31:0]memory[0:65535];

initial
begin
   $readmemb("InstMemText.txt",memory);
end

assign Inst={memory[adr[15:0]+3],memory[adr[15:0]+2],memory[adr[15:0]+1],memory[adr[15:0]]};

endmodule