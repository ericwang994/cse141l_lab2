// Module Name:    InstFetch 
// Project Name:   CSE141L
//



	 
module InstFetch(Reset,Start,Clk,BranchEqual,BranchTrue,ALU_flag,Target,ProgCtr);

  input              Reset,			   	// reset, init, etc. -- force PC to 0 
                     Start,			   	// begin next program in series
                     Clk,			   	// PC can change on pos. edges only
                     BranchEqual,	       	// jump unconditionally to Target value	   
                     BranchTrue,	   	// jump conditionally to Target + PC
                     ALU_flag;		  	// flag from ALU, e.g. Zero, Carry, Overflow, Negative (from ARM)
  input       [9:0] Target;		   		// jump ... "how high?"
  output reg[9:0] ProgCtr ;          	// the program counter register itself
  
  
  //// program counter can clear to 0, increment, or jump
	always @(posedge Clk)
	begin 
		if(Reset)
		  ProgCtr <= 0;				        // for first program; want different value for 2nd or 3rd
		else if(Start)						// hold while start asserted; commence when released
		  ProgCtr <= ProgCtr;
		else if(BranchEqual && ALU_flag)	                // unconditional absolute jump
		  ProgCtr <= Target + ProgCtr;
		else if(BranchTrue && !ALU_flag)    // conditional relative jump
		  ProgCtr <= Target + ProgCtr;
		else
		  ProgCtr <= ProgCtr+'b1; 	        // default increment (no need for ARM/MIPS +4 -- why?) A: indexed with inst_rom var in InstROM.v
	end


endmodule

/* Note about Start: if your programs are spread out, with a gap in your machine code listing, you will want 
to make Start cause an appropriate jump. If your programs are packed sequentially, such that program 2 begins 
right after Program 1 ends, then you won't need to do anything special here. 
*/