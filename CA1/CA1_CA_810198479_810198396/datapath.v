module DataPath_Division (dataIN,ldA,ldQ,ldONE,ldD,ldDbar,shA,shQ,selA,selQ,sel1,sel2,selOut,clearD,clearDbar,clearQ,clearA,clearOne,AddCount,CounterClear,clk,A5,OV,DivByZero,ContinueToDivision,dataOUT);

input [4:0]dataIN;
input ldA,ldQ,ldD,ldDbar,ldONE,shA,shQ,selOut,clk,selA,selQ,clearD,clearDbar,clearQ,clearA,clearOne,AddCount,CounterClear;
input [1:0]sel1,sel2;
output A5,OV,DivByZero,ContinueToDivision;
output [4:0]dataOUT;

wire [4:0]d_out,dbar_out,a_load,q_load,q_out,a_out,sum,one_out,mux1_out,mux2_out;

reg Q0=1'b0;
reg [4:0]one=5'b00001;

comprator CompareAandD(a_out,d_out,OV);
IsZero ISzero(d_out,DivByZero);

mux_21 A_mux(dataIN, sum, selA ,a_load);
mux_21 Q_mux(dataIN, sum, selQ ,q_load);

shreg_5b ShregA(a_load, q_out[4] ,clearA, ldA , shA , clk ,a_out);
shreg_5b ShergQ(q_load, Q0 , clearQ , ldQ , shQ , clk ,q_out);

reg_5b regD(dataIN, ldD , clearD , clk ,d_out);
reg_5b regDbar(sum, ldDbar , clearDbar , clk ,dbar_out);

reg_5b regOne(one, ldONE , clearOne, clk ,one_out);

mux_41 mux1(d_out,~(d_out),dbar_out,one_out,sel1,mux1_out);
mux_41 mux2(a_out,q_out,one_out, ,sel2,mux2_out);

adder ADDER(mux1_out, mux2_out , sum);

mux_21 output_mux(a_out, q_out, selOut ,dataOUT);

counter counter(AddCount,CounterClear,clk,ContinueToDivision);

assign A5=a_out[4];
endmodule