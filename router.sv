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
  input [17:0] L_IN,
  output logic queue_write,
  output logic queue_enable,
  input queue_read,
  output logic [17:0] L_OUT  
);

  logic [2:0] cs,ns;
  logic [1:0] x,y;
  
  integer ii;
  
  always_ff@(posedge clk) begin
    if(rst) begin
	  cs <= 3'b001;
	  x <= X_IN;
	  y <= Y_IN;
	 
	end
	else
      cs <= ns;	
  end
 
  always_ff@(posedge clk) begin
    if(rst) begin
	  ii <= 0;
	  ns <= 3'b010;
	end
	else begin
      case(cs) 
        3'b000: begin
	      //W_IN
		 // if(ii == 0) begin
	        if(W_IN[17:16] > x) begin//x
	  	      E_OUT <= {W_IN[17:14],x,W_IN[11:0]};// W -> E 
              N_OUT <= N_OUT;
              S_OUT <= S_OUT;
              W_OUT <= W_OUT;
              L_OUT <= L_OUT;			
	  	      queue_write <= 1'b0;
	  	      queue_enable <= 1'b0;		  
	  	    end
	  	    else if(W_IN[17:16] == x) begin// y
	  	      if(W_IN[15:14] > y) begin
	  	        N_OUT <= {W_IN[17:12],y,W_IN[9:0]};// W -> N
                E_OUT <= E_OUT;
                S_OUT <= S_OUT;
                W_OUT <= W_OUT;
                L_OUT <= L_OUT;			
	  	        queue_write <= 1'b0;
	  	        queue_enable <= 1'b0;		  
	  	      end
	  	      else if(W_IN[15:14] < y) begin
	  	        S_OUT <= {W_IN[17:12],y,W_IN[9:0]};// W -> S
			    N_OUT <= N_OUT;
                E_OUT <= E_OUT;
                W_OUT <= W_OUT;
                L_OUT <= L_OUT;			
	  	        queue_write <= 1'b0;
	  	        queue_enable <= 1'b0;		  
	  	      end
	  	      else begin
	  	        L_OUT <= {W_IN[17:14],x,y,W_IN[9:0]};
                N_OUT <= N_OUT;
                S_OUT <= S_OUT;
                W_OUT <= W_OUT;
                E_OUT <= E_OUT;			
	  	        queue_write <= 1'b1;
	  	        queue_enable <= 1'b1;		  
	  	      end
	  	    end
            else begin
              N_OUT <= N_OUT;
              S_OUT <= S_OUT;
              W_OUT <= W_OUT;
              L_OUT <= L_OUT;
              E_OUT <= E_OUT;			
	  	      queue_write <= 1'b0;
	  	      queue_enable <= 1'b0;		  
	  	    end		  
	  	    ns <= 3'b001;
		 //   ii <= ii+1;
		//  end
       //   else begin
	//	    queue_write <= 1'b0;
	//  	    queue_enable <= 1'b0;
    //        ii<=0;   			
	//	  end
        end
      
      
        3'b001: begin
          //E_IN   
		//  if(ii == 0)begin
            if(E_IN[17:16] < x) begin// x
	  	      W_OUT <= {E_IN[17:14],x,E_IN[11:0]};// E -> W
              N_OUT <= N_OUT;
              E_OUT <= E_OUT;
              S_OUT <= S_OUT;			
	  	      L_OUT <= L_OUT;
			  			
	  	      queue_write <= 1'b0;
	  	      queue_enable <= 1'b0;
	  	    end
            else if(E_IN[17:16] == x) begin// y
	  	      if(E_IN[15:14] > y) begin
	  	        N_OUT <= {E_IN[17:12],y,E_IN[9:0]};// E -> N
	  		    S_OUT <= S_OUT;
                E_OUT <= E_OUT;
                W_OUT <= W_OUT;			
	  	        L_OUT <= L_OUT;
			  
 			    queue_write <= 1'b0;
	  		    queue_enable <= 1'b0;
	  	      end
	  	      else if(W_IN[15:14] < y) begin
	  	        S_OUT <= {E_IN[17:12],y,E_IN[9:0]};// E -> S
	  		    N_OUT <= N_OUT;
                E_OUT <= E_OUT;
                W_OUT <= W_OUT;			
	  	        L_OUT <= L_OUT;
			  
			    queue_write <= 1'b0;
	  		    queue_enable <= 1'b0;
	  	      end
	  	      else begin
	  	        L_OUT <= E_IN;
                N_OUT <= N_OUT;
                E_OUT <= E_OUT;
                W_OUT <= W_OUT;			
	  	        S_OUT <= S_OUT;
			  
			    queue_write <= 1'b1;
	  		    queue_enable <= 1'b1; 
              end			
	  	    end
		    else begin
              L_OUT <= L_OUT;
              N_OUT <= N_OUT;
              S_OUT <= S_OUT;
              W_OUT <= W_OUT;			
	  	      E_OUT <= E_OUT;		  
	  	      queue_write <= 1'b0;
	  		  queue_enable <= 1'b0;
		    end		  
            ns <= 3'b010;
		//    ii <= ii+1;
		  end
        //  else begin
		//    queue_write <= 1'b0;
	  	//    queue_enable <= 1'b0;
        //    ii<=0;   			
		//  end
     //   end	  
        
		3'b010: begin
          //N_IN   
		//  if(ii==0) begin
          if(N_IN[15:14] < y) begin// y
	  	    S_OUT <= {N_IN[17:12],y,N_IN[9:0]};// N->S
            N_OUT <= N_OUT;
            E_OUT <= E_OUT;
            W_OUT <= W_OUT;			
	  	    L_OUT <= L_OUT;
			  
			queue_write <= 1'b0;
	  	    queue_enable <= 1'b0;		  
	  	  end
          else if(N_IN[15:14] == y) begin// x
	  	  if(N_IN[17:16] > x) begin
	  	    E_OUT <= {N_IN[17:14],x,N_IN[11:0]};// N -> E
	  		N_OUT <= N_OUT;
            S_OUT <= S_OUT;
            W_OUT <= W_OUT;			
	  	    L_OUT <= L_OUT;
			  
			queue_write <= 1'b0;
	  		queue_enable <= 1'b0;
	  	  end
      
      
	  	  else if(N_IN[17:16] < x) begin
	  	    W_OUT <= {N_IN[17:14],x,N_IN[11:0]};// N -> W
	  		N_OUT <= N_OUT;
            E_OUT <= E_OUT;
            S_OUT <= S_OUT;			
	  	    L_OUT <= L_OUT;
			  
			queue_write <= 1'b0;
	  		queue_enable <= 1'b0;
	  	  end
	  	  else begin
	  	    L_OUT <= N_IN;
	  		N_OUT <= N_OUT;
            E_OUT <= E_OUT;
            W_OUT <= W_OUT;			
	  	    S_OUT <= S_OUT;
			  
			queue_write <= 1'b1;
	  		queue_enable <= 1'b1;
            end			
	  	  end
		  else begin
            L_OUT <= L_OUT;
            N_OUT <= N_OUT;
            S_OUT <= S_OUT;
            W_OUT <= W_OUT;			
	  	    E_OUT <= E_OUT;		  
	  	    queue_write <= 1'b0;
	  		queue_enable <= 1'b0;
		  end		  
          ns <= 3'b011;
	//	  ii<=ii+1;
		end
    //    else begin
	//	  queue_write <= 1'b0;
	//  	  queue_enable <= 1'b0;
    //      ii<=0;   			
	//	end
     // end
        3'b011: begin
          //S_IN   
		//  if(ii==0) begin
          if(S_IN[15:14] > y) begin// y
	  	    N_OUT <= {S_IN[17:12],y,S_IN[9:0]};// S->N
            S_OUT <= S_OUT;
            E_OUT <= E_OUT;
            W_OUT <= W_OUT;			
	  	    L_OUT <= L_OUT;
			queue_write <= 1'b0;
	  	    queue_enable <= 1'b0;		  
	  	  end
          else if(S_IN[15:14] == y) begin// x
	  	    if(S_IN[17:16] > x) begin
	  	      E_OUT <= {S_IN[17:14],x,S_IN[11:0]};// N -> E
	  	 	  N_OUT <= N_OUT;
              S_OUT <= S_OUT;
              W_OUT <= W_OUT;			
	  	      L_OUT <= L_OUT;
			  
			  queue_write <= 1'b0;
	  		  queue_enable <= 1'b0;
	  	    end
      
      
	  	    else if(S_IN[17:16] < x) begin
	  	      W_OUT <= {S_IN[17:14],x,S_IN[11:0]};// N -> W
	  		  N_OUT <= N_OUT;
              E_OUT <= E_OUT;
              S_OUT <= S_OUT;			
	  	      L_OUT <= L_OUT;
			  
			  queue_write <= 1'b0;
	  		  queue_enable <= 1'b0;
	  	    end
	  	    else begin
	  	      L_OUT <= S_IN;
			  N_OUT <= N_OUT;
              E_OUT <= E_OUT;
              W_OUT <= W_OUT;			
	  	      S_OUT <= S_OUT;
			   
	  		  queue_write <= 1'b1;
	  		  queue_enable <= 1'b1;
            end			
	  	  end
		  else begin
            L_OUT <= L_OUT;
            N_OUT <= N_OUT;
            S_OUT <= S_OUT;
            W_OUT <= W_OUT;			
	  	    E_OUT <= E_OUT;		  
	  	    queue_write <= 1'b0;
	  		queue_enable <= 1'b0;
		  end		  
          ns <= 3'b100;
		//  ii<=ii+1;
		end
        //else begin
		//  queue_write <= 1'b0;
	  	//  queue_enable <= 1'b0;
        //  ii <= 0;   			
		//end
      //end
		3'b100: begin
        //L_IN
		//  if(ii==0) begin
	      if(L_IN[17:16] > x && L_IN != 18'd0) begin//x
	  	    E_OUT <= {L_IN[17:14],x,L_IN[11:0]};// L -> E 
            N_OUT <= N_OUT;
            S_OUT <= S_OUT;
            W_OUT <= W_OUT;
            L_OUT <= L_OUT;			
	  	    queue_write <= 1'b0;
	  	    queue_enable <= 1'b0;		  
	  	  end
	  	  else if(L_IN[17:16] == x && L_IN != 18'd0) begin// y
	  	    if(L_IN[15:14] > y) begin
	  	      N_OUT <= {L_IN[17:12],y,L_IN[9:0]};// L -> N
              W_OUT <= W_OUT;
              S_OUT <= S_OUT;
              E_OUT <= E_OUT;			
	  	      L_OUT <= L_OUT;
			  queue_write <= 1'b0;
	  		  queue_enable <= 1'b0; 
	  	    end
	  	   
	  	    else begin
	  	      S_OUT <= {L_IN[17:12],y,L_IN[9:0]};// L -> S
			  N_OUT <= N_OUT;
              E_OUT <= E_OUT;
              W_OUT <= W_OUT;			
	  	      L_OUT <= L_OUT;
			  queue_write <= 1'b0;
	  		  queue_enable <= 1'b0; 
	  	    
	  	    end
	  	  end
          else begin
            L_OUT <= L_OUT;
            N_OUT <= N_OUT;
            S_OUT <= S_OUT;
            W_OUT <= W_OUT;			
	  	    E_OUT <= E_OUT;		   
	  	    queue_write <= 1'b0;
	  		queue_enable <= 1'b0;
		  end		  
	  	  ns <= 3'b101;
		//  ii <= ii+1;
		end
        //else begin
		//  queue_write <= 1'b0;
	  	//  queue_enable <= 1'b0;
        //  ii <= 0;   			
	//	end
	  //  end
		default: begin
        //reset
	      L_OUT <= 18'd0;
          N_OUT <= 18'd0;
          S_OUT <= 18'd0;
          W_OUT <= 18'd0;			
	  	  E_OUT <= 18'd0;		   
	  	  queue_write <= 1'b0;
	  	  queue_enable <= 1'b0;
	  	  ns <= 3'b000;
		 
	    end
      endcase
	  end
	end  
endmodule
      
      
      
      
      
      
      