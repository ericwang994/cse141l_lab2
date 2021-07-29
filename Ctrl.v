// control decoder (combinational, not clocked)
// inputs from instrROM, ALU flags
// outputs to program_counter (fetch unit)

module Ctrl (Instruction, BeqEn, BtrEn);


  input[ 8:0] Instruction;	   // machine code
  output reg BeqEn,
             BtrEn;

// jump on right shift that generates a zero
always@*
begin
  if(Instruction[8] == 1'b1) begin
    // CrEn = 1;
  end 
  else begin
    if(Instruction[7:4] ==  4'b0000) begin          // load
    end 
    else if(Instruction[7:4] ==  4'b0001) begin     // mov
      // BeqEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b0010) begin     // pull
      // BeqEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b0011) begin     // store
      // BeqEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b0100) begin     // shift left
      // BeqEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b0101) begin     // shift right
      // BeqEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b0110) begin     // add
      // BeqEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b0111) begin     // add carry
      // BeqEn = 1;
    end
    else if(Instruction[7:4] ==  4'b1000) begin     // sub
      // BeqEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b1001) begin     // sub carry
      // BeqEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b1010) begin     // branch equal
      // BeqEn = 1;
    end  
    else if(Instruction[7:4] ==  4'b1011) begin     // branch true
      // BtrEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b1100) begin     // qreater than
      // BeqEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b1101) begin     // first bit
      // BeqEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b1110) begin     // last bit
      // BeqEn = 1;
    end 
    else if(Instruction[7:4] ==  4'b1111) begin     // halt
      // BeqEn = 1;
    end 
    else
      BtrEn = 0;
	end
	 
end


endmodule

