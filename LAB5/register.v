`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:23:50 04/05/2017 
// Design Name: 
// Module Name:    register 
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
module register(clock_in, readReg1, readReg2, writeReg, readData1, readData2, writeData, regWrite, reset);
    input clock_in;
	 input regWrite;
	 input reset;
	 input [4:0] writeReg;
	 input [25:21] readReg1;
	 input [20:16] readReg2;
	 input [31:0] writeData;
	 output [31:0] readData1;
	 output [31:0] readData2;
    
	 reg [31:0] regFile[31:0];
	 reg [31:0] readData1;
	 reg [31:0] readData2;
	 integer i;
	 
	 always @ (readReg1 or readReg2)
	 begin
		readData1 <= regFile[readReg1];
		readData2 <= regFile[readReg2];
		
	 end
	 
	 always @ (negedge clock_in)
	 begin
	 if(regWrite==1)
		regFile[writeReg] <= writeData;
	 end
	 
	 always @ (posedge reset)
	 begin
		for(i=0;i<32;i=i+1)
		begin
			regFile[i] <= 0;
		end
	 end

	 initial
	 begin
		$readmemh("./Src/regist", regFile, 10'h0);
	 end
endmodule
