// Design Name:    BasicProcessor
// Module Name:    TopLevel 
// CSE141L
// partial only	

/*
module TopLevel(		   // you will have the same 3 ports
    input        Reset,	   // init/reset, active high
			     Start,    // start next program
	             Clk,	   // clock -- posedge used inside design
    output logic Ack	   // done flag from DUT
    );
*/
	 
module CPU(Reset, Start, Clk,Ack);

	input Reset;		// init/reset, active high
	input Start;		// start next program
	input Clk;			// clock -- posedge used inside design
	output reg Ack;     // done flag from DUT
	
	wire [ 9:0] PgmCtr,        		// program counter
			    PCTarg;
	wire [ 8:0] Instruction;   		// our 9-bit instruction
	wire [ 3:0] Instr_opcode;  		// out 4-bit opcode
	wire [ 7:0] ReadA, ReadAcc,
				ReadC;  			// reg_file outputs
	wire [ 3:0] Waddr;
	wire [ 7:0] Maddr;
	wire [ 7:0] InA, InAcc, InC,	  	// ALU operand inputs
					ALU_out;       	// ALU result
	wire [ 7:0] RegWriteValue, 		// data in to reg file
				RegCarryValue,		// data to update carry register
				MemWriteValue, 		// data in to data_memory
				MemReadValue;  		// data out from data_memory
	wire        MemWrite,	   		// data_memory write enable
				RegWrEn,	    	// reg_file write enable
				CEn,
				CrEn,				// create instruction enable
				MovEn,			// writing to register other than accumulator enable
				PullEn,				// writing back to register a memory value or ALU result
				Zero,		    	// ALU output = 0 flag
				BeqEn,	       		// to program counter: beq enable
				BtrEn;	   			// to program counter: btr enable
	reg  [15:0] CycleCt;	      	// standalone; NOT PC!


	// Fetch = Program Counter + Instruction ROM
	// Program Counter
  	InstFetch IF1 (
		.Reset       (Reset		), 
		.Start       (Start		),		// SystemVerilg shorthand for .halt(halt), 
		.Clk         (Clk		),		// (Clk) is required in Verilog, optional in SystemVerilog
		.BranchEqual (BeqEn		),		// beq enable
		.BranchTrue	 (BtrEn		),		// btr enable
		.ALU_flag	 (Zero		),		// Zero flag for branching
		.Target      (PCTarg	),		// desired branch vector
		.ProgCtr     (PgmCtr	)		// program count = index to instruction memory
	);	

	// Control decoder
	Ctrl Ctrl1 (
		.Instruction	(Instruction),		// from instr_ROM
		.MemWrite		(MemWrite),			//control flags
		.RegWrEn		(RegWrEn),
		.CEn			(CEn),
		.CrEn			(CrEn),
		.MovEn			(MovEn),
		.PullEn			(PullEn),
		.BeqEn			(BeqEn),			
		.BtrEn			(BtrEn)				
	);
	
	// instruction ROM
	InstROM IR1(
		.InstAddress   (PgmCtr), 
		.InstOut       (Instruction)
	);
	
	always@*							  // assign Zero = !Out;
	begin
		Ack = (Instruction[8:4] == 5'b01111);
	end
	
	assign Waddr = MovEn? Instruction[3:0] : 4'hF;
	
	//Reg file
	// Modify D = *Number of bits you use for each register*
	RegFile #(.W(8),.D(4)) RF1 (
		.Clk       	(Clk),
		.WriteEn   	(RegWrEn), 
		.CEn		(CEn),
		.RaddrA    	(Instruction[3:0]),      
		.RaddrAcc   (4'hF), 					// Hardcoded acc as 15
		.RaddrC		(4'hE),						// Hardcoded carry as 14
		.Waddr     	(Waddr), 	       			
		.DataIn    	(RegWriteValue), 
		.DataC		(RegCarryValue),
		.DataOutA  	(ReadA), 
		.DataOutAcc	(ReadAcc),
		.DataOutC	(ReadC)
	);
	
	assign PCTarg = ReadA[7]? {2'b11,ReadA} : {2'b00,ReadA};
	
	
	assign InA = ReadA;						          // connect RF out to ALU in
	assign InAcc = ReadAcc;
	assign InC = ReadC;
	assign Instr_opcode = Instruction[7:4];
	//assign MemWrite = (Instruction[7:4] == 4'b0011);       // mem_store command
	assign RegWriteValue = CrEn? Instruction[7:0] : (PullEn? MemReadValue : ALU_out);  
	assign Maddr = PullEn? ReadA : ReadAcc;

	ALU ALU1(
		.Input(InA),      	  
		.Acc(InAcc),
		.Op(Instr_opcode),
		.Cin(InC),				  
		.Out(ALU_out),		  			
		.Zero(Zero),
		.Cout(RegCarryValue)
	);
	 
	DataMem DM1(
		.DataAddress  (Maddr), 
		.WriteEn      (MemWrite), 
		.DataIn       (ReadA), 
		.DataOut      (MemReadValue), 
		.Clk 		  (Clk),
		.Reset		  (Reset)
	);

	// count number of instructions executed
	always @(posedge Clk)
	  if (Start == 1)	   // if(start)
		 CycleCt <= 0;
	  else if(Ack == 0)   // if(!halt)
		 CycleCt <= CycleCt+16'b1;

endmodule