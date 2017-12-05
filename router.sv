module router(
  input clk,
  input rst,
  input [17:0] W_IN,
  input [17:0] E_IN,
  input [17:0] N_IN,
  input [17:0] S_IN,
  input [1:0] X_IN,
  input [1:0] Y_IN,
  output logic [17:0] W_OUT,
  output logic [17:0] E_OUT,
  output logic [17:0] N_OUT,
  output logic [17:0] S_OUT,
  output logic [17:0] L_IN,
 /* output logic [17:0] L_IN_W,
  output logic [17:0] L_IN_N,
  output logic [17:0] L_IN_S,
  output logic [17:0] L_IN_E,*/
  output logic [17:0] L_OUT  
);

  logic [1:0] cs,ns;
  logic [1:0] x,y;
  
  
  always_ff@(posedge clk) begin
    if(rst) begin
	  cs <= 2'b00;
	  x <= X_IN;
	  y <= Y_IN;
	end
	else
      cs <= ns;	
  end
  
  always_comb begin
    case(cs) 
      2'b00: begin
	    //W_IN
	    if(W_IN[17:16] > x) begin//x
		  E_OUT = {W_IN[17:14],x,W_IN[11:0]};// W -> E  
		end
		else if(W_IN[17:16] == x) begin// y
		  if(W_IN[15:14] > y) begin
		    N_OUT = {W_IN[17:12],y,W_IN[9:0]};// W -> N
		  end
		  else if(W_IN[15:14] < y) begin
		    S_OUT = {W_IN[17:12],y,W_IN[9:0]};// W -> S
		  end
		  else
		    L_IN = W_IN; 
		end
		ns = 2'b01;
	  end


      2'b01: begin
        //E_IN   
        if(E_IN[17:16] < x) begin// x
		  W_OUT = {E_IN[17:14],x,E_IN[11:0]};// E -> W  
		end
        else if(E_IN[17:16] == x) begin// y
		  if(E_IN[15:14] > y) begin
		    N_OUT = {E_IN[17:12],y,E_IN[9:0]};// E -> N
		  end
		  else if(W_IN[15:14] < y) begin
		    S_OUT = {E_IN[17:12],y,E_IN[9:0]};// E -> S
		  end
		  else
		    L_IN = E_IN; 
		end
        ns = 2'b10;
      end	  
      2'b10: begin
        //N_IN   
        if(N_IN[15:14] < y) begin// y
		  S_OUT = {N_IN[17:12],y,N_IN[9:0]};// N->S  
		end
        else if(N_IN[15:14] == y) begin// x
		  if(N_IN[17:16] > x) begin
		    E_OUT = {N_IN[17:14],x,N_IN[11:0]};// N -> E
		  end


		  else if(N_IN[17:16] < x) begin
		    W_OUT = {N_IN[17:14],x,N_IN[11:0]};// N -> W
		  end
		  else
		    L_IN = N_IN; 
		end
        ns = 2'b11;
      end
      2'b11: begin
        //S_IN   
        if(S_IN[15:14] > y) begin// y
		  N_OUT = {S_IN[17:12],y,S_IN[9:0]};// S->N  
		end
        else if(S_IN[15:14] == y) begin// x
		  if(S_IN[17:16] > x) begin
		    E_OUT = {S_IN[17:14],x,S_IN[11:0]};// N -> E
		  end


		  else if(S_IN[17:16] < x) begin
		    W_OUT = {S_IN[17:14],x,S_IN[11:0]};// N -> W
		  end
		  else
		    L_IN = S_IN; 
		end
        ns = 2'b00;
      end
  endcase
 end
endmodule



 


