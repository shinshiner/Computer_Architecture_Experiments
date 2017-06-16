`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:14:19 04/19/2017
// Design Name:   Top
// Module Name:   E:/codes/LAB5/Top_tb.v
// Project Name:  LAB5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Top_tb;

	// Inputs
	reg mainClk;
	reg reset;
	reg chreg1;
	reg chreg2;
	reg chPC;
	
	//outputs
	wire clk;
	wire [7:0] led;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.reset(reset),
		.mainClk(mainClk),
		.led(led),
		.chreg1(chreg1),
		.chreg2(chreg2),
		.chPC(chPC)
	);
	
	always
	#100 mainClk = ~mainClk;

	initial begin
		// Initialize Inputs
		reset = 1;
		mainClk = 0;


		// Wait 100 ns for global reset to finish
		#1000;
		reset=0;


		// Add stimulus here
		
	end
	
      
endmodule

