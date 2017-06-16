`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:42:14 04/12/2017
// Design Name:   register
// Module Name:   E:/codes/lab4/test_for_register.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: register
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_register;

	// Inputs
	reg clock_in;
	reg regWrite;
	reg [4:0] writeReg;
	reg [25:21] readReg1;
	reg [20:16] readReg2;
	reg [31:0] writeData;
	
	//Outputs
	wire [31:0] readData1;
	wire [31:0] readData2;
	
	// Instantiate the Unit Under Test (UUT)
	register uut (
		.clock_in(clock_in),
		.writeReg(writeReg),
		.readReg1(readReg1),
		.readReg2(readReg2),
		.writeData(writeData),
		.readData1(readData1),
		.readData2(readData2),
		.regWrite(regWrite)
	);

	parameter cycle = 200;
	always #(cycle/2) clock_in = ~clock_in;
	initial begin
		
		// Initialize Inputs
		clock_in = 0;
		readReg1 = 0;
		readReg2 = 0;
		writeReg = 0;
		writeData = 0;
		regWrite = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
      
		// Add stimulus here
		#285;
		regWrite = 1'b1;
		writeReg = 5'b10101;
		writeData = 32'b11111111111111110000000000000000;
		
		#200;
		writeReg = 5'b01010;
		writeData = 32'b00000000000000001111111111111111;
		
		#200;
		regWrite = 1'b0;
		writeReg = 5'b00000;
		writeData = 32'b00000000000000000000000000000000;
		
		#50;
		readReg1 = 5'b10101;
		readReg2 = 5'b01010;

	end
      
endmodule

