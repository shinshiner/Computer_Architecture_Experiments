`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:17:08 04/26/2017 
// Design Name: 
// Module Name:    inst_memory 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module inst_memory(address, CLK, RESET, readData);
	input [31:0] address;
	input CLK;
	input RESET;
	output reg [31:0] readData;
	
	reg [31:0] memBuffer [0:63];
	always @ (address)
	begin
		readData = memBuffer[address>>2];
	end
endmodule
