module reg_32b(reginput, load, clear , clk ,regoutput);
input [31:0]reginput;
input load , clk ,clear ;
output [31:0]regoutput;
reg [31:0]regoutput;
always @(posedge clk,clear)begin
  if(clear==1'b1)
    regoutput =32'b0;
  else if(load==1'b1)
     regoutput <= reginput;
end
endmodule
