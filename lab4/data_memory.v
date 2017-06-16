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
	 output reg [31:0] readData
    );
	 
	 reg [31:0] memFile[0:127];
	 
	 always @ (memWrite or memRead or clock_in or writeData or address)
	 begin
		if(memRead==1)
			assign readData = memFile[address];
	 end
	 
	 always @ (negedge memWrite)
	 begin
		memFile[address>>2] = writeData;
	 end
	 
	 initial
	 begin
		$readmemh("./Src/mem_data", memFile, 10'h0);
	 end

endmodule
