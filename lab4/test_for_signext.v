`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:15:18 04/12/2017
// Design Name:   signext
// Module Name:   E:/codes/lab4/test_for_signext.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: signext
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_signext;
	//Inputs
	reg [15:0] inst;
	
	// Outputs
	wire [31:0] data;

	// Instantiate the Unit Under Test (UUT)
	signext uut (
		.inst(inst),
		.data(data)
	);

	initial begin
		// Initialize Inputs

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#100;
		inst = 1;
		#100;
		inst = -5;
	end
      
endmodule

