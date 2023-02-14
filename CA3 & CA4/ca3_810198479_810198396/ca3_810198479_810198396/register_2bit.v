module reg_2b(reginput, load, clear , clk ,regoutput);
input [1:0]reginput;
input load , clk ,clear ;
output [1:0]regoutput;
reg [1:0]regoutput;
always @(posedge clk,clear)begin
  if(clear==1'b1)
    regoutput =2'b0;
  else if(load==1'b1)
     regoutput <= reginput;
end
endmodule