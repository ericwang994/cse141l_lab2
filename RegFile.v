// Design Name:    CSE141L
// Module Name:    reg_file 
//
// Additional Comments: 					  $clog2

/* parameters are compile time directives 
       this can be an any-size reg_file: just override the params!
*/
module RegFile (Clk,WriteEn,RaddrA,RaddrAcc,Waddr,DataIn,DataOutA,DataOutAcc);
	parameter W=8, D=4;// W = data path width; D = pointer width
  input                Clk,
                       WriteEn;
  input        [D-1:0] RaddrA,				  // address pointers
                       RaddrAcc,
                       Waddr;
  input        [W-1:0] DataIn;
  output reg      [W-1:0] DataOutA;			  // showing two different ways to handle DataOutX, for
  output reg [W-1:0] DataOutAcc;				  //   pedagogic reasons only;

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
 Cin = Registers[14]            // carry register
end

// sequential (clocked) writes 
always @ (posedge Clk)
  if (WriteEn) begin	                             // works just like data_memory writes
    Registers[Waddr] <= DataIn;
    Registers[0] <= '0;
    Registers[14] <= Cout;      // carry register
  end

endmodule
