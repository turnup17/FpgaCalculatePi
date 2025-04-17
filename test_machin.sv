`timescale 1ns / 1ps

module test_machin;
	parameter CYCLE = 1000;
	parameter HALF_CYCLE = 500;
	parameter DLY = 500;
    parameter WIDTH = 15;
    parameter L = 16;  //20
	logic clk, rst;
	logic test;
	reg [30:0] counter;
	always begin
    	clk <= 1'b0;
    	#(HALF_CYCLE);
    	clk <= 1'b1;
    	#(HALF_CYCLE);
	counter = counter + 1;
	end
    wire [L-1:0][WIDTH-1:0]out;
	wire finish;   	
	machin #(.WIDTH(WIDTH), .L(L), .INT_DIGITS(2), .MAX(10000)) machin_inst(clk, rst, finish, out);
	initial begin
		//$dumpfile("test_machin.vcd");
		//$dumpvars;
		rst = 1'b0;
		#1000000
		rst = 1'b1;
		#1000
		rst = 1'b0;
		counter = 0;
		#1000

       // #10000000000 
		//test = 1'b1;
        //rst = 1'b1;
        #1000
        rst = 1'b0;
    	//$monitor("%t %b %b %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d ", $time, finish, clk, out[L-1], out[L-2], out[L-3], out[L-4], out[L-5], out[L-6], out[L-7], out[L-8], out[L-9], out[L-10], out[L-11], out[L-12], out[L-13], out[L-14], out[L-15], out[L-16], out[L-17], out[L-18], out[L-19], out[L-20]);
    	//$monitor("%t %b %b %d %d %d %d %d %d %d %d ", $time, finish, clk, out[L-2], out[L-3], out[L-4], out[L-16], out[L-17], out[L-18], out[L-19], out[L-20]);
        $monitor("%t %b %b %d %d %d %d %d %d %d %d ", $time, test, clk, out[L-2], out[L-3], out[L-4], out[L-12], out[L-13], out[L-14], out[L-15], out[L-16]);
	
        //@(posedge finish);
        //$finish;  // Terminate simulation when finish is 1
		
		//#2600000000
    	//$finish;
		//1 is equal to 1000
		//2567762500000
        //search via 2067 
	end
endmodule
//CLOCK 3837276000000
//CLOCK 3837275500000
//1XLOJ 0000001000000
//3837275.5 CLOCKS
//
