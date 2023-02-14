module divider_10by5(dataIN,start,rst,clk,OV,DivByZero,done,dataOUT);
input [4:0]dataIN;
input start,rst,clk;
output[4:0]dataOUT;
output OV,DivByZero,done;


wire [1:0]sel1,sel2;
wire ldA,ldQ,ldONE,ldD,ldDbar,A5,shA,shQ,selA,selQ,selOut,OVoutput,DivByZerooutput,clearD,clearDbar,clearQ,clearA,clearOne,AddCount,CounterClear,ContinueToDivision;

controller control(start,rst,A5,ldA,ldQ,ldD,ldDbar,ldONE,shA,shQ,selOut,clk,selA,selQ,OVoutput,DivByZerooutput,ContinueToDivision,clearD,clearDbar,clearQ,clearA,clearOne,AddCount,CounterClear,sel1,sel2,OV,DivByZero,done);
DataPath_Division datapath(dataIN,ldA,ldQ,ldONE,ldD,ldDbar,shA,shQ,selA,selQ,sel1,sel2,selOut,clearD,clearDbar,clearQ,clearA,clearOne,AddCount,CounterClear,clk,A5,OVoutput,DivByZerooutput,ContinueToDivision,dataOUT);

endmodule