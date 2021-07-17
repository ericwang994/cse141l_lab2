// Module Name:    ALU 
// Project Name:   CSE141L
//



	 
module ALU(Input,Acc,OP,Cin,Out,Zero,Cout);

	input [ 7:0] Input; 	// reg value or imm value
	input [ 7:0] Acc;	// accumulator reg value
	input [ 3:0] OP;	 	// operation bits
	input Cin;		 	 	// implicit carry reg value
	output reg [7:0] Out; 	// logic in SystemVerilog
	output reg Zero;		
	output reg Cout;

	always@* // always_comb in systemverilog
	begin 
		Out = 0;
		case (OP)
		4'b0100: Out = Input << 1;			// Shift left
		4'b0101: Out = {1'b0,Input[7:1]}; 	// Shift right
		4'b0110: Out = Input + Acc; 		// ADD
		4'b0111: begin
			Out = Input + Acc + Cin; 		// ADD_CARRY
			Cout = Input > Out;
		end
		4'b1000: Out = Input - Acc; 		// SUB
		4'b1001: begin
			Out = Input - Acc - Cin; 		// SUB_CARRY
			Cout = Input > Out;
		end
		4'b1100: Out = Acc < Input; 		// Greater Than
			
		default: Out = 0;
	  	endcase
	end 

	always@*							  	// assign Zero = !Out;
	begin
		case(Out)
			'b0     : Zero = 1'b1;
			default : Zero = 1'b0;
      endcase
	end


endmodule