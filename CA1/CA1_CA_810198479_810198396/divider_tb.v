module divider_tb;
reg [4:0]dataIN;
reg start,rst,clk;
wire OV,DivByZero,done;
wire [4:0]dataOUT;


divider_10by5  Div(dataIN,start,rst,clk,OV,DivByZero,done,dataOUT);

initial
begin

start=1'b0;
rst=1'b0;
clk=1'b0;

rst=1'b0;
#13 rst=1'b1;
#20 rst=1'b0;
#13 start=1'b1;
#20 start=1'b0;
#20 dataIN=5'b00011;
#20 dataIN=5'b11110;
#20 dataIN=5'b00101;
#1500


#13 rst=1'b1;
#20 rst=1'b0;
#13 start=1'b1;
#20 start=1'b0;
#20 dataIN=5'b01101;
#20 dataIN=5'b01111;
#20 dataIN=5'b01111;
#1500

rst=1'b0;
#13 rst=1'b1;
#20 rst=1'b0;
#13 start=1'b1;
#20 start=1'b0;
#20 dataIN=5'b00101;
#20 dataIN=5'b01110;
#20 dataIN=5'b01111;
#1500

rst=1'b0;
#13 rst=1'b1;
#20 rst=1'b0;
#13 start=1'b1;
#20 start=1'b0;
#20 dataIN=5'b00101;
#20 dataIN=5'b10010;
#20 dataIN=5'b01000;
#1500

rst=1'b0;
#13 rst=1'b1;
#20 rst=1'b0;
#13 start=1'b1;
#20 start=1'b0;
#20 dataIN=5'b01101;
#20 dataIN=5'b01110;
#20 dataIN=5'b01011;
#1500


rst=1'b0;
#13 rst=1'b1;
#20 rst=1'b0;
#13 start=1'b1;
#20 start=1'b0;
#20 dataIN=5'b00101;
#20 dataIN=5'b01110;
#20 dataIN=5'b00000;
#1500


$finish;
end

always
begin
	#10 clk=~clk;
end
endmodule