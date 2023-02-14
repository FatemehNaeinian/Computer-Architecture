module controller(start,rst,A5,ldA,ldQ,ldD,ldDbar,ldONE,shA,shQ,selOut,clk,selA,selQ,OVoutput,DivByZerooutput,ContinueToDivision,clearD,clearDbar,clearQ,clearA,clearOne,AddCount,CounterClear,sel1,sel2,OV,DivByZero,done);input start,rst,A5,clk,OVoutput,DivByZerooutput,ContinueToDivision;output reg ldA,ldQ,ldD,ldDbar,ldONE,shA,shQ,selA,selQ,selOut,OV,DivByZero,done,clearD,clearDbar,clearQ,clearA,clearOne,AddCount,CounterClear;output reg [1:0]sel1,sel2;reg[4:0]ps,ns;reg AnyProblem;
assign AnyProblem=OVoutput|DivByZerooutput;

parameter [4:0]
S0=0,S1=1,S2=2,S3=3,S4=4,S5=5,S6=6,S7=7,S8=8,S9=9,S10=10,S11=11,S12=12,S13=13,S14=14,S15=15,S16=16,S17=17,S18=18;
always @(posedge clk) begin	if(rst)begin		ps<=S0;
	end	else		ps<=ns;end 
always @(ps or start)begin	case(ps)	S0:ns=start?S18:S0;
	S18:ns=S1;	S1:ns=S2;	S2:ns=S3;
	S3:ns=S4;	S4:ns=AnyProblem?S16:S5;	S5:ns=S6;	S6:ns=S7;	S7:ns=S8;			S8:ns=A5?S11:S9;	S9:ns=S10;	S10:ns=S13;	S11:ns=S12;	S12:ns=S13;	S13:ns=ContinueToDivision?S6:S14;	S14:ns=S15;	S15:ns=S17;
	S17:ns=S0;	S16:ns=S0;	endcaseend

always @(ps)begin
	{ldA,ldQ,ldD,ldDbar,ldONE,shA,shQ,selA,selQ,selOut,OV,DivByZero,done,sel1,sel2,AddCount}=18'b000000000000000000;
	{clearD,clearDbar,clearQ,clearA,clearOne,CounterClear}=6'b000000;	case(ps)	S0:;
	S18:begin {clearD,clearDbar,clearQ,clearA,clearOne,CounterClear}=6'b111111;end 	S1:{selA,ldA}=2'b01;	S2:{selQ,ldQ}=2'b01;	S3:begin ldD=1'b1;ldONE=1'b1; end
	S4:;	S5:begin sel1=2'b01;sel2=2'b10;ldDbar=1'b1;end	S6:{shA,shQ}=2'b11;	S7:begin sel1=2'b10;sel2=2'b00;selA=1'b1;ldA=1'b1;end	S8:;	S9:begin sel1=2'b11;sel2=2'b01;ldQ=1'b1;selQ=1'b1;end	S10:AddCount=1'b1;	S11:begin sel1=2'b00;sel2=2'b00;end	S12:begin ldA=1'b1;selA=1'b1;AddCount=1'b1;end	S13:;	S14:{done,selOut}=2'b10;	S15:{done,selOut}=2'b11;
	S17:;	S16:begin OV=OVoutput;DivByZero=DivByZerooutput;end	endcaseend


endmodule