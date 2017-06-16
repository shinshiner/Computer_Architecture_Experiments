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
module register(/*clock_in, readReg1, readReg2, writeReg, readData1, readData2, writeData, regWrite, reset
,reg1, reg2, reg3, reg4, reg5, reg6, reg7*/
    input clock_in,
	 input regWrite,
	 input reset,
	 input [4:0] writeReg,
	 input [25:21] readReg1,
	 input [20:16] readReg2,
	 input [31:0] writeData,
	 output reg [31:0] readData1,
	 output reg [31:0] readData2,

	 output reg [1:0] reg1,
	 output reg [1:0] reg2,
  	 output reg [1:0] reg3,
 	 output reg [1:0] reg4,
	 output reg [1:0] reg5,
	 output reg [1:0] reg6,
	 output reg [1:0] reg7
);
	 integer i;
	 reg [31:0] regFile[7:0];
	 
	 always @ (readReg1 or readReg2 or regWrite)
	 begin
		readData1 <= regFile[readReg1];
		readData2 <= regFile[readReg2];
		reg1 = regFile[1][1:0];
		reg2 = regFile[2][1:0];
		reg3 = regFile[3][1:0];
		reg4 = regFile[4][1:0];
		reg5 = regFile[5][1:0];
		reg6 = regFile[6][1:0];
		reg7 = regFile[7][1:0];		
	 end
	 
	 always @ (negedge clock_in or posedge reset)
	 begin
		if(regWrite==1)
			regFile[writeReg] = writeData;
		if(reset==1)
		begin
			for(i=0;i<8;i=i+1)
			begin
				regFile[i] = 0;
			end
		end
	 end
	 
	 /*always @ (posedge reset)
	 begin//!!
		for(i=0;i<32;i=i+1)
		begin
			regFile[i] = 0;
		end
	end*/

	 /*initial
		begin
			$readmemh("./Src/regist", regFile, 10'h0);
		end*/
endmodule
