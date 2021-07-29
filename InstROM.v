// Design Name: 
// Module Name:    InstROM 
// Project Name:   CSE141L
// Tool versions: 
// Description: Verilog module -- instruction ROM template	
//	 preprogrammed with instruction values (see case statement)
//
// Revision: 
//

module InstROM (InstAddress, InstOut) ;
  input       [9:0] InstAddress;
  output reg  [8:0] InstOut;
	
  reg[8:0] inst_rom[(2**10)-1:0];
  always@* InstOut = inst_rom[InstAddress];
 
  initial begin		                  // load from external text file
  	$readmemb("machine_code.txt",inst_rom);
  end 
  
endmodule