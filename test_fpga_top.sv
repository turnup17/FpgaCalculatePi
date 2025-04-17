`timescale 1ns / 1ps

module test_fpga_top;
    parameter CYCLE = 1000;
    parameter HALF_CYCLE = 500;
    parameter DLY = 500;
    parameter WIDTH = 16;
    parameter L = 16;  //20
    logic clk, rst;
    always begin
        clk <= 1'b0;
        #(HALF_CYCLE);
        clk <= 1'b1;
        #(HALF_CYCLE);
    end
    wire [WIDTH-1:0] out [L-1:0]; // Corrected declaration order of dimensions
    wire finish;
    logic [3:0] key;
    wire [6:0] hex0, hex1, hex2, hex3, hex4, hex5;
    
    machintop_backup machintop_inst(clk, key, hex0, hex1, hex2, hex3, hex4, hex5);
    initial begin
        //$dumpfile("test_fpga_top.vcd");
        //$dumpvars;
		#1000;
        //key = 4'b0001;
	//key = 4'b0000;
        //#100000;
	#1000;
        key = 4'b1111;
        #1000;
        key = 4'b0000;
        #1000;
        key = 4'b1111;
        #1000;
        key = 4'b0000;
		$monitor("%t %b %b", $time, clk, hex0);
        #100000000;
    end
endmodule
