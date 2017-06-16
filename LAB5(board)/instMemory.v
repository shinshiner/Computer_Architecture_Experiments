`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:44:21 04/19/2017 
// Design Name: 
// Module Name:    instMemory 
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
module instMemory(
		//input clock_in,
		input [31:0] addr,
		output reg[31:0] inst,
		input reset
		);
		reg [31:0] instRegFile[0:13];
		//assign inst = instRegFile[addr];
		always @ (addr or inst)
		begin
			inst = instRegFile[addr>>2];
		end
		
		always @ (reset)
		begin
			if(reset)
			begin
				instRegFile[0] = 32'b00001000000000000000000000000100;
				instRegFile[1] = 32'b00000000001000100001100000100000;
instRegFile[2] = 32'b00000000001000100010000000100010;
instRegFile[3] = 32'b00000000001000100010100000100100;
instRegFile[4] = 32'b10001100000000010000000000000100;
instRegFile[5] = 32'b10001100000000100000000000001000;
instRegFile[6] = 32'b00000000001000100001100000100000;
instRegFile[7] = 32'b00000000001000100010000000100010;
instRegFile[8] = 32'b00000000001000100010100000100100;
instRegFile[9] = 32'b00000000000000010011000000100101;
instRegFile[10] = 32'b00000000000000000000000000100111;
instRegFile[11] = 32'b00000000001000100011100000101010;
instRegFile[12] = 32'b00010000010000110000000000000011;
instRegFile[13] = 32'b10101100000001110000000000000001;
	end end
		/*initial
		begin
			$readmemb("./Src/mem_inst1", instRegFile, 8'h0);
		end*/

endmodule
