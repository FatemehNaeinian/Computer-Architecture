module counter(AddCount,CounterClear,clk,ContinueToDivision);
reg [2:0]count;
input AddCount,CounterClear,clk;
output ContinueToDivision;
always@(posedge clk)begin
	if(CounterClear)
		count<=3'b000;
	else
		count<=count+AddCount;

end

assign ContinueToDivision=(count==3'b101)?1'b0:1'b1;

endmodule