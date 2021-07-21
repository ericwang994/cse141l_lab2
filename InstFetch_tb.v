`timescale 1ns/ 1ps

module InstFetch_tb;

reg RESET,     	  
    START,
    CLK,
    BRANCHABS,
    BRANCHRELEN,
    ALU_FLAG;
reg [9:0] TARGET;
wire[ 9:0] PROGCTR;		  

reg [ 9:0] expected;

always #5 CLK=~CLK;

// CONNECTION
InstFetch test_if(
  .Reset(RESET),      	  
  .Start(START),
  .Clk(CLK),
  .BranchAbs(BRANCHABS),				  
  .BranchRelEn(BRANCHRELEN),		  			
  .ALU_flag(ALU_FLAG),
  .Target(TARGET),
  .ProgCtr(PROGCTR)
);

initial begin
    CLK = 0;
    
    // reset test
    RESET = 1;
    START = 1;
    BRANCHABS = 1;
    BRANCHRELEN = 1;
    ALU_FLAG = 1;
    TARGET = 9'h1FF;
    #9;
    test_fetch_func;
    
    // start test
    RESET = 0;
    START = 1;
    BRANCHABS = 1;
    BRANCHRELEN = 1;
    ALU_FLAG = 1;
    TARGET = 9'h1FF;
    #9;
    test_fetch_func;

    // increment test
    RESET = 0;
    START = 0;
    BRANCHABS = 0;
    BRANCHRELEN = 0;
    ALU_FLAG = 0;
    TARGET = 9'h1FF;
    #9;
    test_fetch_func;

    // branch absolute test
    RESET = 0;
    START = 0;
    BRANCHABS = 1;
    BRANCHRELEN = 1;
    ALU_FLAG = 1;
    TARGET = 9'h011;
    #9;
    test_fetch_func;

    // branch relative test
    RESET = 0;
    START = 0;
    BRANCHABS = 0;
    BRANCHRELEN = 1;
    ALU_FLAG = 0;
    TARGET = 9'h011;
    #9;
    test_fetch_func;

    ALU_FLAG = 1;
    #9;
    test_fetch_func;
    $stop;
    end
    task test_fetch_func;
		begin	
            if(RESET)
                expected = 0;				        // for reseting
            else if(START)						// hold while start asserted; commence when released
                expected = expected;
            else if(BRANCHABS)	                // unconditional absolute jump
                expected = TARGET;
            else if(BRANCHRELEN && ALU_FLAG)    // conditional relative jump
                expected = TARGET + expected;
            else
                expected = expected+9'h001; 	        // default increment (no need for ARM/MIPS +4 -- why?)
		#1; if(expected == PROGCTR)
			begin
				$display("%t YAY!! FLAGS = R:%b S:%b Ba:%b Br:%b A:%b, Target = %b, ProgCtr = %b, expected = %b",$time, RESET,START,BRANCHABS,BRANCHRELEN,ALU_FLAG, TARGET, PROGCTR, expected);
			end
			else begin 
				$display("%t FAIL! FLAGS = R:%b S:%b Ba:%b Br:%b A:%b, Target = %b, ProgCtr = %b, expected = %b",$time, RESET,START,BRANCHABS,BRANCHRELEN,ALU_FLAG, TARGET, PROGCTR, expected);
			end	
		end
	endtask
endmodule