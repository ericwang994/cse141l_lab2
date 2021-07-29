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
	wire [ 7:0] ReadA, ReadAcc;  	// reg_file outputs
	wire [ 7:0] InA, InAcc, 	  	// ALU operand inputs
					ALU_out;       	// ALU result
	wire [ 7:0] RegWriteValue, 		// data in to reg file
					MemWriteValue, 	// data in to data_memory
					MemReadValue;  	// data out from data_memory
	wire        MemWrite,	   		// data_memory write enable
					RegWrEn,	    // reg_file write enable
					Zero,		    // ALU output = 0 flag
					BeqEn,	       	// to program counter: beq enable
					BtrEn;	   		// to program counter: btr enable
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
		.BeqEn			(BeqEn),			// to PC
		.BtrEn			(BtrEn)				// to PC
	);
	
	// instruction ROM
	InstROM IR1(
		.InstAddress   (PgmCtr), 
		.InstOut       (Instruction)
	);
	
	assign LoadInst = Instruction[7:4] == 4'b0010;  // calls load specially
	
	always@*							  // assign Zero = !Out;
	begin
		Ack = Instruction[0];
	end
	
	//Reg file
	// Modify D = *Number of bits you use for each register*
	RegFile #(.W(8),.D(4)) RF1 (
		.Clk       	(Clk),
		.WriteEn   	(RegWrEn), 
		.RaddrA    	(Instruction[3:0]),      
		.RaddrAcc   (4'hF), 
		.Waddr     	(4'hF), 	       			// hardcoded register 15 as accumulator
		.DataIn    	(RegWriteValue), 
		.DataOutA  	(ReadA), 
		.DataOutAcc	(ReadAcc)
	);
	
	
	
	assign InA = ReadA;						          // connect RF out to ALU in
	assign InAcc = ReadAcc;
	assign Instr_opcode = Instruction[7:4];
	assign MemWrite = (Instruction[7:4] == 4'b0011);       // mem_store command
	assign RegWriteValue = LoadInst? MemReadValue : ALU_out;  // 2:1 switch into reg_file
	

	ALU ALU1(
		.Input(InA),      	  
		.Acc(InAcc),
		.Op(Instr_opcode),
		.Cin(),				  
		.Out(ALU_out),		  			
		.Zero(Zero),
		.Cout()
	);
	 
	DataMem DM1(
		.DataAddress  (ReadA)    , 
		.WriteEn      (MemWrite), 
		.DataIn       (MemWriteValue), 
		.DataOut      (MemReadValue)  , 
		.Clk 		  (Clk)     ,
		.Reset		  (Reset)
	);

	// count number of instructions executed
	always @(posedge Clk)
	  if (Start == 1)	   // if(start)
		 CycleCt <= 0;
	  else if(Ack == 0)   // if(!halt)
		 CycleCt <= CycleCt+16'b1;

endmodule