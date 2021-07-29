`timescale 1ns/ 1ps

//Test bench
//Arithmetic Logic Unit

module ALU_tb;
reg [ 7:0] INPUT;     	  // data inputs
reg [ 7:0] ACC;
reg [ 3:0] OP;		// ALU opcode, part of microcode
reg CIN;
wire[ 7:0] OUT;		  
wire ZERO;    
wire COUT;
reg [ 7:0] expected;
reg exp_cout;
 
// CONNECTION
ALU uut(
  .Input(INPUT),      	  
  .Acc(ACC),
  .Op(OP),
  .Cin(CIN),				  
  .Out(OUT),		  			
  .Zero(ZERO),
  .Cout(COUT)
);
	 

initial begin


	INPUT = 1;
	ACC = 100; 
	OP= 4'b0100; 		// Shift left
	test_alu_func; 		// void function call
	#5;
	
	
	INPUT = 4;
	ACC = 42;
	OP= 4'b0101; 		// Shift right
	test_alu_func; 		// void function call
	#5;
	
	INPUT = 400;
	ACC = -25;
	OP= 4'b0110; 		// Add
	test_alu_func; 		// void function call
	#5;

	INPUT = 26;
	ACC = 8;
	CIN = 1;
	OP= 4'b0111; 		// Add_Carry
	test_alu_func; 		// void function call
	#5;

	INPUT = 4;
	ACC = 2;
	OP= 4'b1000; 		// Sub
	test_alu_func; 		// void function call
	#5;

	INPUT = 4;
	ACC = 0;
	CIN = 1;
	OP= 4'b1001; 		// Sub_Carry
	test_alu_func; 		// void function call
	#5;

	INPUT = 4;
	ACC = 0;
	OP= 4'b1100; 		// Greater_Than
	test_alu_func; 		// void function call
	#5;
	end

	task test_alu_func;
		begin
			
			exp_cout = 0;
		case (OP)
			4: expected = INPUT << 1;				// Shift left
			5: expected = {1'b0,INPUT[7:1]}; 	  	// Shift right
			6: expected = INPUT + ACC;				// Add
			7: begin
				expected = INPUT + ACC + CIN;			// Add_Carry
				exp_cout = INPUT > expected;
			end
			8: expected = INPUT - ACC;				// Sub
			9: begin
				expected = INPUT - ACC - CIN;				// Sub_Carry
				exp_cout = INPUT > expected;
			end
			12: expected = INPUT > ACC;			// Greater_Than
		endcase
		#1; if(expected == OUT && exp_cout == COUT)
			begin
				$display("%t YAY!! inputs = %h %h, opcode = %b, Zero %b",$time, INPUT,ACC,OP, ZERO);
			end
			else begin 
				$display("%t FAIL! inputs = %h %h, opcode = %b, Zero %b",$time, INPUT,ACC,OP, ZERO);
			end	
		end
	endtask

endmodule