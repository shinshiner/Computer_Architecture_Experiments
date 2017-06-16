`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:06:51 04/05/2017 
// Design Name: 
// Module Name:    Alu 
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
module Alu(input1, input2, aluCtr, zero, aluRes);
    input [31:0] input1;
    input [31:0] input2;
    input [3:0] aluCtr;
    output zero;
    output [31:0] aluRes;
	 reg zero;
	 reg [31:0] aluRes;
	 
	 always @ (input1 or input2 or aluCtr)
	 begin
		if(aluCtr==4'b0010)
			begin
			aluRes = input1 + input2;
			if(aluRes==0)
				zero = 1;
			else
				zero = 0;
			end
		else if(aluCtr==4'b0110)
			begin
			aluRes = input1 - input2;
			if(aluRes==0)
				zero = 1;
			else
				zero = 0;
			end
		else if(aluCtr==4'b0000)
			begin
			aluRes = input1 & input2;
			if(aluRes==0)
				zero = 1;
			else
				zero = 0;
			end
		else if(aluCtr==4'b0001)
			begin
			aluRes = input1 | input2;
			if(aluRes==0)
				zero = 1;
			else
				zero = 0;
			end
		else if(aluCtr==4'b0111)
			begin
			aluRes = (input1 < input2);
			if(aluRes==1)
				begin
				aluRes = 1;
				zero = 0;
				end
			else
				begin
				aluRes = 0;
				zero = 1;
				end
			end
		else if(aluCtr==4'b1100)
			begin
			aluRes = ~(input1 | input2);
			if(aluRes==0)
				zero = 1;
			else
				zero = 0;
			end
	end



endmodule
