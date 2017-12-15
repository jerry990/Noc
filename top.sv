`include "router.sv"
`include "queue.sv"
`include "define.sv"
`include "div.sv"
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
  
  logic [17:0] L_IN_r1;
  logic [17:0] L_IN_r2;
  logic [17:0] L_IN_r3;
  logic [17:0] L_IN_r4;
  
  logic [17:0] L_OUT_r1;
  logic [17:0] L_OUT_r2;
  logic [17:0] L_OUT_r3;
  logic [17:0] L_OUT_r4;
  
  logic read_1;
  logic write_1;
  logic queue_empty_1;
  logic queue_full_1;
  
  logic read_2;
  logic write_2;
  logic queue_empty_2;
  logic queue_full_2;
  
  logic read_3;
  logic write_3;
  logic queue_empty_3;
  logic queue_full_3;
  
  logic read_4;
  logic write_4;
  logic queue_empty_4;
  logic queue_full_4;
  
 
  logic o_clk,o_rst;
  
  div div12(
            .clk(clk),
            .rst(rst),
            .o_clk(o_clk),
			.o_rst(o_rst)
            );
  
  //logic read,write,en,queue_full,queue_empty;
  //logic [`DATA_SIZE-1:0] queue_in; 
  //logic [`DATA_SIZE-1:0] queue_out;
  router r1 ( 
   clk,
   rst,
   W_IN_r1,
   W12_2,
   W13_2,
   S_IN_r1,
   2'b01,
   2'b01,
   W_OUT_r1,
   W12_1,
   W13_1,
   S_OUT_r1,
   L_IN_r1,
   write_1,
   en_1,
   read_1,
   /* output logic [17:0] L_IN_W,
    output logic [17:0] L_IN_N,
    output logic [17:0] L_IN_S,
    output logic [17:0] L_IN_E,*/
   L_OUT_r1  
  
  );
  
  router r2 ( 
   clk,
   rst,
   W12_1,
   E_IN_r2,
   W24_2,
   S_IN_r2,
   2'b10,
   2'b01,
   W12_2,
   E_OUT_r2,
   W24_1,
   S_OUT_r2,
   L_IN_r2,
   write_2,
   en_2,
   read_2,
   /* output logic [17:0] L_IN_W,
    output logic [17:0] L_IN_N,
    output logic [17:0] L_IN_S,
    output logic [17:0] L_IN_E,*/
   L_OUT_r2  
  
  );
  router r3 ( 
   clk,
   rst,
   W_IN_r3,
   W34_2,
   N_IN_r3,
   W13_1,
   2'b01,
   2'b10,
   W_OUT_r3,
   W34_1,
   N_OUT_r3,
   W13_2,
   L_IN_r3,
   write_3,
   en_3,
   read_3,
   /* output logic [17:0] L_IN_W,
    output logic [17:0] L_IN_N,
    output logic [17:0] L_IN_S,
    output logic [17:0] L_IN_E,*/
   L_OUT_r3  
  
  );
  
  router r4 ( 
   clk,
   rst,
   W34_1,
   E_IN_r4,
   N_IN_r4,
   W24_1,
   2'b10,
   2'b10,
   W34_2,
   E_OUT_r4,
   N_OUT_r4,
   W24_2,
   
   L_IN_r4,
   write_4,
   en_4,
   read_4,
   /* output logic [17:0] L_IN_W,
    output logic [17:0] L_IN_N,
    output logic [17:0] L_IN_S,
    output logic [17:0] L_IN_E,*/
   L_OUT_r4  
  
  );
  
  
  queue q1(
            .clk(o_clk),
  			.rst(o_rst),
  			.read(read_1),
  			.write(write_1),
  			.en(en_1),
  			.queue_out(L_IN_r1),
  			.queue_full(queue_full_1),
  			.queue_empty(queue_empty_1),
  			.queue_in(L_OUT_r1)
  			
     );
     
     queue q2(
            .clk(o_clk),
  			.rst(o_rst),
  			.read(read_2),
  			.write(write_2),
  			.en(en_2),
  			.queue_out(L_IN_r2),
  			.queue_full(queue_full_2),
  			.queue_empty(queue_empty_2),
  			.queue_in(L_OUT_r2)
  			
     );
     
     queue q3(
            .clk(o_clk),
  			.rst(o_rst),
  			.read(read_3),
  			.write(write_3),
  			.en(en_3),
  			.queue_out(L_IN_r3),
  			.queue_full(queue_full_3),
  			.queue_empty(queue_empty_3),
  			.queue_in(L_OUT_r3)
  			
     );
     
     queue q4(
            .clk(o_clk),
  			.rst(o_rst),
  			.read(read_4),
  			.write(write_4),
  			.en(en_4),
  			.queue_out(L_IN_r4),
  			.queue_full(queue_full_4),
  			.queue_empty(queue_empty_4),
  			.queue_in(L_OUT_r4)
  			
     );
  
  
  
endmodule