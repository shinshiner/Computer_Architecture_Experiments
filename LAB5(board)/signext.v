`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:48 04/12/2017 
// Design Name: 
// Module Name:    signext 
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
module signext(
		input [15:0] inst,
		output reg [31:0] data
    );
	 	always @ (inst)
	begin
	if(inst<=16'b1000000000000000)
		data={16'b0000000000000000,inst};
	else
		//data={16'b1111111111111111,(~inst+1)};
		data={16'b1111111111111111,inst};
	end

	 /*parameter reg[15:0] tmp = 65535;
	 always @(inst or data)
	 begin
		if(inst[15]==0)
			data = inst;
		else
			begin
			data[31:16] <= tmp[15:0];
			data[15:0] <= inst[15:0];
			end
	 end*/
endmodule
