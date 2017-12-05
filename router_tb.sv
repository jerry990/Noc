`include "router.sv"
module router_tb;

logic clk;
logic rst;
logic [17:0] W_IN;
logic [17:0] E_IN;
logic [17:0] N_IN;
logic [17:0] S_IN;

logic[17:0] W_OUT;
logic[17:0] E_OUT;
logic[17:0] S_OUT;
logic[17:0] N_OUT;

logic [17:0] L_IN;
logic [17:0] L_OUT;

logic [1:0] X_IN,Y_IN;

always #1 clk =~clk;

router r1 ( 
 clk,
 rst,
 W_IN,
 E_IN,
 N_IN,
 S_IN,
 X_IN,
 Y_IN,
 W_OUT,
E_OUT,
N_OUT,
S_OUT,
L_IN,
 /* output logic [17:0] L_IN_W,
  output logic [17:0] L_IN_N,
  output logic [17:0] L_IN_S,
  output logic [17:0] L_IN_E,*/
 L_OUT  

);


//top top1(clk,rst);






initial begin
  clk = 1'b0;
  rst = 1'b1;
  X_IN = 2'b11;
  Y_IN = 2'b01;
  #3
  rst= 1'b0;
  S_IN = 18'h1a349;
  //top1.W_IN_r1 = 32'hA1345678;
  /*#2;
  W_IN = 32'h54230000;
  E_IN = 32'h83330000;
  N_IN = 32'h82230000;
  S_IN = 32'h83230000;
  #2
  W_IN = 32'h82230000;
  E_IN = 32'h12230000;
  N_IN = 32'h82130000;
  S_IN = 32'h82230000;*/
end

initial
  begin
    $fsdbDumpfile("router.fsdb");
    $fsdbDumpvars(0, router_tb);
    #1000000 $finish;
  end

endmodule