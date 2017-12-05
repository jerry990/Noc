`include "router.sv"
module top(input clk,
           input rst);

logic clk;
logic rst;
logic [17:0] W12_1;
logic [17:0] W12_2;
logic [17:0] W13_1;
logic [17:0] W13_2;
logic [17:0] W24_1;
logic [17:0] W24_2;
logic [17:0] W34_1;
logic [17:0] W34_2;

logic [17:0] W_IN_r1;
logic [17:0] S_IN_r1;
logic [17:0] W_OUT_r1;
logic [17:0] S_OUT_r1;

logic [17:0] E_IN_r2;
logic [17:0] S_IN_r2;
logic [17:0] E_OUT_r2;
logic [17:0] S_OUT_r2;

logic [17:0] W_IN_r3;
logic [17:0] N_IN_r3;
logic [17:0] W_OUT_r3;
logic [17:0] N_OUT_r3;

logic [17:0] E_IN_r4;
logic [17:0] N_IN_r4;
logic [17:0] E_OUT_r4;
logic [17:0] N_OUT_r4;

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
router r3(
clk,
rst,
W_IN_r3,
W34_2,
N_IN_r3,
W13_1,
W_OUT_r3,
W34_1,
N_OUT_r3,
W13_2
);

router r4(
clk,
rst,
W34_1,
E_IN_r4,
N_IN_r4,
W24_1,
W34_2,
E_OUT_r4,
N_OUT_r4,
W24_2
);

endmodule