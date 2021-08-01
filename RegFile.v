// Design Name:    CSE141L
// Module Name:    reg_file 
//
// Additional Comments: 					  $clog2

/* parameters are compile time directives 
       this can be an any-size reg_file: just override the params!
*/
module RegFile (Clk,WriteEn,RaddrA,RaddrAcc,RaddrC,Waddr,DataIn,DataC,DataOutA,DataOutAcc,DataOutC);
	parameter W=8, D=4;// W = data path width; D = pointer width
  input                Clk,
                       WriteEn;
  input        [D-1:0] RaddrA;				  // address pointers
  input        [D-1:0] RaddrAcc;
  input        [D-1:0] RaddrC;
  input        [D-1:0] Waddr;
  input        [W-1:0] DataIn;
  input        [W-1:0] DataC;
  output reg [W-1:0] DataOutA;			  // showing two different ways to handle DataOutX, for
  output reg [W-1:0] DataOutAcc;				  //   pedagogic reasons only;
  output reg [W-1:0] DataOutC;
// W bits wide [W-1:0] and 2**4 registers deep 	 
reg [W-1:0] Registers[(2**D)-1:0];	  // or just registers[16] if we know D=4 always

// combinational reads 
/* can write always_comb in place of assign
    difference: assign is limited to one line of code, so
	always_comb is much more versatile     
*/

always@*
begin
 DataOutA = Registers[RaddrA];	  
 DataOutAcc = Registers[RaddrAcc];  
 DataOutC = Registers[14];          // carry register
end

// sequential (clocked) writes 
always @ (posedge Clk)
  if (WriteEn) begin	                             // works just like data_memory writes
    Registers[Waddr] <= DataIn;
    Registers[0] <= '0;
    Registers[14] <= DataC;      // carry register
  end

endmodule