module IsZero(divisor,DivByZero);
input [4:0]divisor;
output DivByZero;
assign DivByZero =~(divisor[0]|divisor[1]|divisor[2]|divisor[3]|divisor[4]);
endmodule
