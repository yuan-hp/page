`timescale 1ns / 1ps
module tb ;
reg clk,rst_n;

//生成始时钟
parameter NCLK = 4;
initial begin
	clk=0;
	forever clk=#(NCLK/2) ~clk; 
end 

/****************** BEGIN ADD module inst ******************/
t
/****************** BEGIN END module inst ******************/

initial begin
    $dumpfile("wave.lxt2");
    $dumpvars(0, tb);   //dumpvars(深度, 实例化模块1，实例化模块2，.....)
end

initial begin
   	rst_n = 1; 
    	#(NCLK) rst_n=0;
    	#(NCLK) rst_n=1; //复位信号

	repeat(100) @(posedge clk)begin

	end
	$display("运行结束！");
	$dumpflush;
	$finish;
	$stop;	
end 
endmodule
