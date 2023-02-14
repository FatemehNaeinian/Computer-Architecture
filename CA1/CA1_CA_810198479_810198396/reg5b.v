module reg_5b(reginput, load, clear , clk ,regoutput);
input [4:0]reginput;
input load , clk ,clear ;
output [4:0]regoutput;
reg [4:0]regoutput;
always @(posedge clk)
  if(clear)
    regoutput =5'b00000;
  else if(load)
     regoutput <= reginput;
endmodule
