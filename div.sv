module div(
            input clk,
            input rst,
            output logic o_clk,
			output logic o_rst
            );
 
  logic [3:0] cnt;
  logic [3:0] cnt2;
 
  always_ff@(posedge clk) begin
    if (rst)begin
      cnt <= 0;
	end
    else if (cnt == 4'd1) begin// 0 ~ 1
      cnt <= 0;
	end
    else begin
      cnt <= cnt + 1;  
	end
	
	if(rst)
	  cnt2 <= 0;
    else if(cnt2 == 4'd4)	
	  cnt2 <= cnt2;  
	else
	  cnt2 <= cnt2+1;
  end
  
  always_ff@(posedge clk) begin
    if (rst)begin
      o_clk <= 0;
	  o_rst <= 1;
	end
    
	else if (cnt < 4'd1) begin// 0~5 
      o_clk <= 0;
	end
    
	else  begin            // 6~11
      o_clk <= 1;
	end
    
	if(cnt2 < 4'd4)
      o_rst<=1;
    else
      o_rst<=0;
    end
   
endmodule