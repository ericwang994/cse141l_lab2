// Module Name:    ALU 
// Project Name:   CSE141L
//



	 
module ALU(Input,Acc,Op,Cin,Out,Zero,Cout);

	input [ 7:0] Input; 	// reg value or imm value
	input [ 7:0] Acc;	// accumulator reg value
	input [ 3:0] Op;	 	// operation bits
	input [ 7:0] Cin;		 	 	// implicit carry reg value
	output reg [7:0] Out; 	// logic in SystemVerilog
	output reg Zero;		
	output reg [7:0] Cout;

	always@* // always_comb in systemverilog
	begin 
		Out = 0;
		Cout = 0;
		case (Op)
		4'b0000: Out = Input;				// load
		4'b0001: Out = Acc;					// mov
		4'b0100: Out = Acc << 1;			// Shift left
		4'b0101: Out = {1'b0,Acc[7:1]}; 	// Shift right
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
		4'b1010: Out = Acc;					// branch equal
		4'b1011: Out = Acc; 				// branch true
		4'b1100: Out = Acc < Input; 		// Greater Than
		4'b1101: Out = Input[0];			// Fbit
		4'b1110: Out = Input[7];			// Lbit
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