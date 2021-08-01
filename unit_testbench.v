//  CSE141L Summer session1 2021
//  pulses start while loading program 1 operand into CPU
//  waits for done pulse from CPU 
//  reads and verifies result from CPU against its own computation
`timescale 1ns/1ps

module test_bench_1;

reg reset,  // Reset signal  
    clk,    // system clock runs testbench and CPU
    start;  // request to CPU

wire done;  // acknowledge back from CPU

// ***** instantiate your top level design here *****
  CPU dut(
    .Clk     (clk  ),   // input: use your own port names, if different
    .Reset   (reset ),   // input: some prefer to call this ".reset"
    .Start   (start),   // input: launch program
    .Ack     (done )    // output: "program run complete"
  );


// program 1 variables
reg[7:0] load;      // divident;
reg[7:0] acc;	     // divisor;
reg[7:0] result;	     // final result
reg[7:0] carry;
// program 1 desired values

reg[23:0] real_result;	     // final correct result
real quotientR;			    //  quotient in $real format
reg[63:0] tmp;
reg[63:0] quotient;


// clock -- controls all timing, data flow in hardware and test bench
always begin
    #5 clk = ~clk;
end

initial begin
    clk = 0;
    // launch program 1 with the first input
    #5 reset = 1; start = 1;
    #10 reset = 0;
    dut.DM1.Core[0] = 1;
    dut.DM1.Core[1] = 17;
    
    #40 start = 0;
    #20 wait(done);

    result = 1;
    acc = dut.RF1.Registers[15];
    carry = dut.RF1.Registers[14];
    $display ("Accumulator = %h", acc);

    if(acc==result) 
        $display("success -- match");
    else 
        $display("OOPS! expected 0, got %h", acc);
    $stop;
end

endmodule