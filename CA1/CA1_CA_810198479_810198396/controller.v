module controller(start,rst,A5,ldA,ldQ,ldD,ldDbar,ldONE,shA,shQ,selOut,clk,selA,selQ,OVoutput,DivByZerooutput,ContinueToDivision,clearD,clearDbar,clearQ,clearA,clearOne,AddCount,CounterClear,sel1,sel2,OV,DivByZero,done);
assign AnyProblem=OVoutput|DivByZerooutput;

parameter [4:0]
S0=0,S1=1,S2=2,S3=3,S4=4,S5=5,S6=6,S7=7,S8=8,S9=9,S10=10,S11=11,S12=12,S13=13,S14=14,S15=15,S16=16,S17=17,S18=18;

	end

	S18:ns=S1;
	S3:ns=S4;
	S17:ns=S0;

always @(ps)
	{ldA,ldQ,ldD,ldDbar,ldONE,shA,shQ,selA,selQ,selOut,OV,DivByZero,done,sel1,sel2,AddCount}=18'b000000000000000000;
	{clearD,clearDbar,clearQ,clearA,clearOne,CounterClear}=6'b000000;
	S18:begin {clearD,clearDbar,clearQ,clearA,clearOne,CounterClear}=6'b111111;end 
	S4:;
	S17:;


