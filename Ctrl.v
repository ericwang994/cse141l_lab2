// control decoder (combinational, not clocked)
// inputs from instrROM, ALU flags
// outputs to program_counter (fetch unit)

module Ctrl (Instruction, MemWrite, RegWrEn, CrEn, MovEn, PullEn, BeqEn, BtrEn);


  input[ 8:0] Instruction;	   // machine code
  output reg MemWrite, 
	     RegWrEn, CrEn, MovEn, PullEn, BeqEn,
             BtrEn;

// jump on right shift that generates a zero
always@*
begin
  if(Instruction[8] == 1'b1) begin                  // create
    MovEn = 0;
    PullEn = 0;
    CrEn = 1;
    BeqEn = 0;
    BtrEn = 0;
    MemWrite = 0;
    RegWrEn = 1;
  end 
  else begin
    if(Instruction[7:4] ==  4'b0000) begin          // load
      MovEn = 0;
      PullEn = 0;
      CrEn = 0;
      BeqEn = 0;
      BtrEn = 0;
      MemWrite = 0;
      RegWrEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b0001) begin     // mov
      MovEn = 1;
      PullEn = 0;
      CrEn = 0;
      BeqEn = 0;
      BtrEn = 0;
      MemWrite = 0;
      RegWrEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b0010) begin     // pull
      MovEn = 0;
      PullEn = 1;
      CrEn = 0;
      BeqEn = 0;
      BtrEn = 0;
      MemWrite = 0;
      RegWrEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b0011) begin     // store
      MovEn = 0;
      PullEn = 0;
      CrEn = 0;
      BeqEn = 0;
      BtrEn = 0;
      MemWrite = 1;
      RegWrEn = 0;
    end 
    else if(Instruction[7:4] ==  4'b0100) begin     // shift left
      MovEn = 0;
      PullEn = 0;
      CrEn = 0;
      BeqEn = 0;
      BtrEn = 0;
      MemWrite = 0;
      RegWrEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b0101) begin     // shift right
      MovEn = 0;
      PullEn = 0;
      CrEn = 0;
      BeqEn = 0;
      BtrEn = 0;
      MemWrite = 0;
      RegWrEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b0110) begin     // add
      MovEn = 0;
      PullEn = 0;
      CrEn = 0;
      BeqEn = 0;
      BtrEn = 0;
      MemWrite = 0;
      RegWrEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b0111) begin     // add carry
      MovEn = 0;
      PullEn = 0;
      CrEn = 0;
      BeqEn = 0;
      BtrEn = 0;
      MemWrite = 0;
      RegWrEn = 1;
    end
    else if(Instruction[7:4] ==  4'b1000) begin     // sub
      MovEn = 0;
      PullEn = 0;
      CrEn = 0;
      BeqEn = 0;
      BtrEn = 0;
      MemWrite = 0;
      RegWrEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b1001) begin     // sub carry
      MovEn = 0;
      PullEn = 0;
      CrEn = 0;
      BeqEn = 0;
      BtrEn = 0;
      MemWrite = 0;
      RegWrEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b1010) begin     // branch equal
      MovEn = 0;
      PullEn = 0;
      CrEn = 0;
      BeqEn = 1;
      BtrEn = 0;
      MemWrite = 0;
      RegWrEn = 0;
    end  
    else if(Instruction[7:4] ==  4'b1011) begin     // branch true
      MovEn = 0;
      PullEn = 0;
      CrEn = 0;
      BeqEn = 0;
      BtrEn = 1;
      MemWrite = 0;
      RegWrEn = 0;
    end 
    else if(Instruction[7:4] ==  4'b1100) begin     // qreater than
      MovEn = 0;
      PullEn = 0;
      CrEn = 0;
      BeqEn = 0;
      BtrEn = 0;
      MemWrite = 0;
      RegWrEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b1101) begin     // first bit
      MovEn = 0;
      PullEn = 0;
      CrEn = 0;
      BeqEn = 0;
      BtrEn = 0;
      MemWrite = 0;
      RegWrEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b1110) begin     // last bit
      MovEn = 0;
      PullEn = 0;
      CrEn = 0;
      BeqEn = 0;
      BtrEn = 0;
      MemWrite = 0;
      RegWrEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b1111) begin     // halt
      MovEn = 0;
      PullEn = 0;
      CrEn = 0;
      BeqEn = 0;
      BtrEn = 0;
      MemWrite = 0;
      RegWrEn = 0;
    end 
    else begin
      MovEn = 0;
      PullEn = 0;
      CrEn = 0;
      BeqEn = 0;
      BtrEn = 0;
      MemWrite = 0;
      RegWrEn = 0;
    end
end
end


endmodule
