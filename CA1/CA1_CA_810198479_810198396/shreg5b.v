module shreg_5b (shreginput, ser_in , clear , load , shift , clk ,shregoutput);
input [4:0]shreginput;
input ser_in , load , shift , clk , clear ;
output [4:0]shregoutput;
reg [4:0]shregoutput;
always @(posedge clk)
  if(clear)
    shregoutput <= 5'b00000;
  else if(load)
    shregoutput <= shreginput;
  else if(shift)
    shregoutput <= {shregoutput[3:0],ser_in};

endmodule