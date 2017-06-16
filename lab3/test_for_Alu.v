`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:13:59 04/05/2017
// Design Name:   Alu
// Module Name:   E:/codes/lab3/test_for_Alu.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_Alu;

	// Inputs
	reg [31:0] input1;
	reg [31:0] input2;
	reg [3:0] aluCtr;

	// Outputs
	wire zero;
	wire [31:0] aluRes;

	// Instantiate the Unit Under Test (UUT)
	Alu uut (
		.input1(input1), 
		.input2(input2), 
		.aluCtr(aluCtr), 
		.zero(zero), 
		.aluRes(aluRes)
	);

	initial begin
		// Initialize Inputs
		input1 = 0;
		input2 = 0;
		aluCtr = 0;


		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#100; input1 = 255; input2 = 170; aluCtr = 4'b0000;
		#100; input1 = 255; input2 = 170; aluCtr = 4'b0001;
		#100; input1 = 1; input2 = 1; aluCtr = 4'b0010;
		#100; input1 = 255; input2 = 170; aluCtr = 4'b0110;
		#100; input1 = 1; input2 = 1; aluCtr = 4'b0110;
		#100; input1 = 255; input2 = 170; aluCtr = 4'b0111;
		#100; input1 = 170; input2 = 255; aluCtr = 4'b0111;
		#100; input1 = 0; input2 = 1; aluCtr = 4'b1100;
		#300;
	end
      
endmodule

