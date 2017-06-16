`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:31:06 04/12/2017 
// Design Name: 
// Module Name:    data_memory 
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
module data_memory(
    input clock_in,
	 input [31:0] address,
	 input memWrite,
	 input memRead,
	 input [31:0] writeData,
	 output reg [31:0] readData,
	 input reset
    );
	 
	 reg [31:0] memFile[127:0];
	 integer i;
	 
	 always @ (memWrite or memRead or clock_in or writeData or address)
	 begin
		if(memRead==1)
			assign readData = memFile[address>>2];
	 end
	 
	 always @ (negedge clock_in or posedge reset)
	 begin
	   if(memWrite)
		begin
			memFile[address>>2] = writeData;
		end
		if(reset==1)
		begin
			for(i=0;i<128;i=i+1)
			begin
				memFile[i] = 0;
			end
			memFile[0] = 32'b00000000000000000000000000000000;
			memFile[1] = 32'b00000000000000000000000000000001;
			memFile[2] = 32'b00000000000000000000000000000010;
			memFile[3] = 32'b00000000000000000000000000000011;
			memFile[4] = 32'b00000000000000000000000000000100;
			memFile[5] = 32'b00000000000000000000000000000101;
			memFile[6] = 32'b00000000000000000000000000000110;
			memFile[7] = 32'b00000000000000000000000000000111;
		end
			//$readmemh("./Src/mem_data", memFile, 10'h0);

	 end
	 
	 initial
		begin
			for(i=0;i<128;i=i+1)
			begin
				memFile[i] = 0;
			end
			//$readmemh("./Src/mem_data", memFile, 10'h0);
			memFile[0] = 32'b00000000000000000000000000000000;
			memFile[1] = 32'b00000000000000000000000000000001;
			memFile[2] = 32'b00000000000000000000000000000010;
			memFile[3] = 32'b00000000000000000000000000000011;
			memFile[4] = 32'b00000000000000000000000000000100;
			memFile[5] = 32'b00000000000000000000000000000101;
			memFile[6] = 32'b00000000000000000000000000000110;
			memFile[7] = 32'b00000000000000000000000000000111;
		end

endmodule
