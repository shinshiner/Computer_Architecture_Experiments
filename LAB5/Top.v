`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:13:48 04/12/2017 
// Design Name: 
// Module Name:    Top 
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
module Top(clk,reset);
	 input clk;
	 input reset;
	 //other
	 //wire RESET;
	 
	 //instruction
	 wire [31:0] INST;
	 
	 //control unit
	 wire REG_DST,
			JUMP,
			BRANCH,
			MEM_READ,
			MEM_TO_REG,
			MEM_WRITE;
	 wire[1:0] ALU_OP;
	 wire ALU_SRC,
			REG_WRITE;
	
	 //aluCtr
	 wire [3:0] OUT_ALU_CTR;
	 
	 //alu
	 wire [31:0] INPUT1;
	 wire [31:0] INPUT2;
	 wire OUT_ZERO;
	 wire [31:0] OUT_ALU_RESULT;
	 
	 //memory
	 wire [31:0] OUT_MEMORY;
	 
	 //mux1
	 wire [31:0] mux1Out;
	 wire [31:0] mux1In0;
	 wire [31:0] mux1In1;
	 
	 //mux2
	 wire [31:0] mux2Out;
	 wire [31:0] mux2In1;
	 
	 //mux3
	 wire [4:0] mux3Out;
	 
	 //mux4
	 wire [31:0] mux4Out;
	 
	 //mux5
	 wire [31:0] mux5Out;
	 
	 //signext
	 wire [31:0] OUT_SIGNEXT;
	 
	 //pc
	 wire [31:0] PC1;			
	 reg [31:0] PC;
	 
	 
	 instMemory myInstMemory(
			.addr(PC),
			.inst(INST)
	 );
	 
	 Ctr mainCtr(
			.opCode(INST[31:26]),
			.regDst(REG_DST),
			.jump(JUMP),
			.branch(BRANCH),
			.memRead(MEM_READ),
			.memToReg(MEM_TO_REG),
			.aluOp(ALU_OP),
			.memWrite(MEM_WRITE),
			.aluSrc(ALU_SRC),
			.regWrite(REG_WRITE)
	 );
	 
	 AluCtr myAluCtr(
			.aluOp(ALU_OP),
			.funct(INST[5:0]),
			.aluCtr(OUT_ALU_CTR)
	 );
	 
	 Alu myAlu(
			.input1(INPUT1[31:0]),
			.input2(ALU_SRC ? OUT_SIGNEXT : INPUT2),
			.aluCtr(OUT_ALU_CTR),
			.zero(OUT_ZERO),
			.aluRes(OUT_ALU_RESULT)
	 );
	 
	 register myRegister(
			.clock_in(clk),
			.regWrite(REG_WRITE),
			.reset(reset),
			.writeReg(REG_DST ? INST[15:11] : INST[20:16]),
			.readReg1(INST[25:21]),
			.readReg2(INST[20:16]),
			.writeData(MEM_TO_REG ? OUT_MEMORY : OUT_ALU_RESULT),
			.readData1(INPUT1),
			.readData2(INPUT2)
	 );
	 
	 data_memory myDataMemory(
			.clock_in(clk),
			.address(OUT_ALU_RESULT),
			.memWrite(MEM_WRITE),
			.memRead(MEM_READ),
			.writeData(INPUT2),
			.readData(OUT_MEMORY)
	 );
	 
	 signext mySignext(
			.inst(INST[15:0]),
			.data(OUT_SIGNEXT)
	 );
	 
	 wire [31:0] nextAdd;
	 wire [31:0] branchAdd;
	 wire [31:0] jumpAdd;
	 
	 assign nextAdd = PC + 4;
	 assign branchAdd = (OUT_SIGNEXT<<2) + nextAdd;
	 assign jumpAdd = {nextAdd[31:28],INST[25:0],2'b00};
	 assign PC1 = JUMP ? jumpAdd : ((OUT_ZERO&BRANCH) ? branchAdd : nextAdd);
	 
	 always @ (posedge clk)
	 begin			
		PC <= PC1;
	 end
	 
	 assign mux2In1[27:0] = ((INST[25:0])<<2);
	 assign mux2In1[31:28] = PC[31:28];
	 
	 assign mux1Out = (OUT_ZERO&BRANCH) ? ((OUT_SIGNEXT<<2)+mux1In0) : mux1In0;
	 assign mux2Out = JUMP ? mux2In1 : mux1Out;
	 assign mux3Out = REG_DST ? INST[15:11] : INST[20:16];
	 assign mux4Out = ALU_SRC ? OUT_SIGNEXT : INPUT2;
	 assign mux5Out = MEM_TO_REG ? OUT_MEMORY : OUT_ALU_RESULT;
	 
	 always @ (posedge reset)
	 begin
		PC = 0;
	 end
	 
	 
			

endmodule
