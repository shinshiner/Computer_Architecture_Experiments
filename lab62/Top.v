`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:08:07 04/26/2017 
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
module Top(CLOCK_IN, RESET);
	input CLOCK_IN;
	input RESET;
	
	//for io
	wire CLK;
	assign CLK = CLOCK_IN;
	
	//Regs
	//PC
	reg [31:0] PC;
	
	//1.0 for stage IF to ID
	reg [31:0] IF_ID_PcAdd4;
	reg [31:0] IF_ID_Inst;
	
	//2.0 for stage ID to EX
	reg [31:0] ID_EX_PcAdd4;
	reg [31:0] ID_EX_ReadData1;
	reg [31:0] ID_EX_ReadData2;
	reg [31:0] ID_EX_SignExt;
	reg [20:16] ID_EX_InstHigh;
	reg [15:11] ID_EX_InstLow;
	//2.1 to EX
	reg ID_EX_RegDst;
	reg [1:0] ID_EX_ALUOp;
	reg ID_EX_ALUSrc;
	//2.2 to MEM
	reg ID_EX_Branch;
	reg ID_EX_MemWrite;
	reg ID_EX_MemRead;
	//2.3 to WB
	reg ID_EX_MemToReg;
	reg ID_EX_RegWrite;
	
	//3.0 for stage EX to MEM
	reg [31:0] EX_MEM_BranchAdd;
	reg [31:0] EX_MEM_ALURes;
	reg [31:0] EX_MEM_ReadData2;
	reg [4:0] EX_MEM_InstHorL;
	reg EX_MEM_Zero;
	//3.1 to MEM
	reg EX_MEM_MemWrite;
	reg EX_MEM_MemRead;
	reg EX_MEM_Branch;
	//3.2 to WB
	reg EX_MEM_MemToReg;
	reg EX_MEM_RegWrite;
	
	//4.0 for stage MEM to WB
	reg [31:0] MEM_WB_ALURes;
	reg [31:0] MEM_WB_ReadData;
	reg [4:0] MEM_WB_InstHorL;
	//4.1 to WB
	reg MEM_WB_MemToReg;
	reg MEM_WB_RegWrite;
	
	//--------------------------
	//wire
	//1.0 IF
	wire [31:0] PCPlus4;
	wire [31:0] IF_Inst;
	wire [31:0] PC1;
	
	//2.0 ID
	wire [31:0] ID_ReadData1;
	wire [31:0] ID_ReadData2;
	wire ID_RegWrite;
	wire ID_AluSrc;
	wire ID_MemToReg;
	wire ID_MemWrite;
	wire ID_MemRead;
	wire ID_Branch;
	wire [1:0] ID_ALUOp;
	wire ID_RegDst;
	wire [31:0] ID_SignExt;
	
	//3.0 EX
	wire [31:0] EX_ALURes;
	wire EX_Zero;
	wire [31:0] EX_BranchAdd;
	wire [4:0] EX_InstHorL;
	wire [31:0] EX_Input2;
	wire [3:0] EX_ALUCtr;
	
	//4.0 MEM
	wire [31:0] MEM_ReadData;
	wire MEM_PCSrc;
	
	//5.0 WB
	wire [31:0] WB_WriteData;
	
	
	//---------------------------
	//objects
	Ctr myCtr(
		.opCode(IF_ID_Inst[31:26]),
		.regDst(ID_RegDst),
		.aluSrc(ID_ALUSrc),
		.memToReg(ID_MemToReg),
		.regWrite(ID_RegWrite),
		.memRead(ID_MemRead),
		.memWrite(ID_MemWrite),
		.branch(ID_Branch),
		.aluOp(ID_ALUOp)
	);
	
	Alu myALU(
		.input1(ID_EX_ReadData1),
		.input2(ID_EX_ReadData2),
		.aluCtr(EX_ALUCtr),
		.zero(EX_Zero),
		.aluRes(EX_ALURes)
	);
	
	AluCtr myALUCrr(
		.aluOp(ID_EX_ALUOp),
		.funct(ID_EX_SignExt[5:0]),
		.aluCtr(EX_ALUCtr)
	);
	
	data_memory myDataMem(
		.clock_in(CLOCK_IN),
		.address(EX_MEM_ALURes),
		.memWrite(EX_MEM_MemWrite),
		.memRead(EX_MEM_MemRead),
		.readData(MEM_ReadData)
	);
	
	inst_memory myInstMem(
		.address(PC),
		.readData(IF_Inst)
	);
	
	register myReg(
		.clock_in(CLOCK_IN),
		.readReg1(IF_ID_Inst[25:21]),
		.readReg2(IF_ID_Inst[20:16]),
		.writeReg(MEM_WB_InstHorL),
		.writeData(WB_WriteData),
		.regWrite(MEM_WB_RegWrite),
		.regReset(RESET),
		.regData1(ID_ReadData1),
		.regData2(ID_ReadData2)
	);
	
	signext mySignExt(
		.inst(IF_ID_Inst[15:0]),
		.data(ID_SignExt)
	);
	
	//--------------------------
	//update
	//PC
	assign PCPlus4 = PC + 4;
	assign EX_BranchAdd = PCPlus4 + (ID_EX_SignExt<<2);
	assign PC1 = MEM_PCSrc ? EX_BranchAdd : PCPlus4;
	assign MEM_PCSrc = EX_MEM_Branch & EX_MEM_Zero;
	
	//mux
	assign EX_Input2 = ID_EX_ALUSrc ? ID_EX_SignExt : ID_EX_ReadData2;
	assign WB_WriteData = MEM_WB_MemToReg ? MEM_WB_ReadData : MEM_WB_ALURes;
	assign EX_InstHorL = ID_EX_RegDst ? ID_EX_InstLow : ID_EX_InstHigh;
	
	//registers
	always @ (posedge CLOCK_IN)
	begin
		if(RESET)
		begin
			PC <= 0;
			IF_ID_Inst <= 0;
			IF_ID_PcAdd4 <= 0;
			ID_EX_PcAdd4 <= 0;
			ID_EX_ReadData1 <= 0;
			ID_EX_ReadData2 <= 0;
			ID_EX_SignExt <= 0;
			ID_EX_InstHigh <= 0;
			ID_EX_InstLow <= 0;
			ID_EX_RegDst <= 0;
			ID_EX_ALUOp <= 0;
			ID_EX_ALUSrc <= 0;
			ID_EX_Branch <= 0;
			ID_EX_MemWrite <= 0;
			ID_EX_MemRead <= 0;
			ID_EX_RegWrite <= 0;
			ID_EX_MemToReg <= 0;
			EX_MEM_BranchAdd <= 0;
			EX_MEM_Zero <= 0;
			EX_MEM_ALURes <= 0;
			EX_MEM_ReadData2 <= 0;
			EX_MEM_InstHorL <= 0;
			EX_MEM_Branch <= 0;
			EX_MEM_MemRead <= 0;
			EX_MEM_MemWrite <= 0;
			EX_MEM_RegWrite <= 0;
			EX_MEM_MemToReg <= 0;
			MEM_WB_RegWrite <= 0;
			MEM_WB_MemToReg <= 0;
		end
		else
		begin
			PC <= PC1;
			IF_ID_Inst <= IF_Inst;
			IF_ID_PcAdd4 <= PCPlus4;
			ID_EX_PcAdd4 <= IF_ID_PcAdd4;
			ID_EX_ReadData1 <= ID_ReadData1;
			ID_EX_ReadData2 <= ID_ReadData2;
			ID_EX_SignExt <= ID_SignExt;
			ID_EX_InstHigh <= IF_ID_Inst[20:16];
			ID_EX_InstLow <= IF_ID_Inst[15:11];
			ID_EX_RegDst <= ID_RegDst;
			ID_EX_ALUOp <= ID_ALUOp;
			ID_EX_ALUSrc <= ID_ALUSrc;
			ID_EX_Branch <= ID_Branch;
			ID_EX_MemWrite <= ID_MemWrite;
			ID_EX_MemRead <= ID_MemRead;
			ID_EX_RegWrite <= ID_RegWrite;
			ID_EX_MemToReg <= ID_MemToReg;
			EX_MEM_BranchAdd <= EX_BranchAdd;
			EX_MEM_Zero <= EX_Zero;
			EX_MEM_ALURes <= EX_ALURes;
			EX_MEM_ReadData2 <= ID_EX_ReadData2;
			EX_MEM_InstHorL <= EX_InstHorL;
			EX_MEM_Branch <= ID_EX_Branch;
			EX_MEM_MemRead <= ID_EX_MemRead;
			EX_MEM_MemWrite <= ID_EX_MemWrite;
			EX_MEM_RegWrite <= ID_EX_RegWrite;
			EX_MEM_MemToReg <= ID_EX_MemToReg;
			MEM_WB_RegWrite <= EX_MEM_RegWrite;
			MEM_WB_MemToReg <= EX_MEM_MemToReg;
			MEM_WB_ReadData <= MEM_ReadData;
			MEM_WB_ALURes <= EX_MEM_ALURes;
			MEM_WB_InstHorL <= EX_MEM_ALURes;
		end
	end
	
	initial
		$readmemb("result.txt", instMem.membuf, 8'h0);
		$readmemb("data.txt", dataMem.membuf, 8'ha);
	end

endmodule
