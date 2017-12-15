//8x18 queue
`include "define.sv"
module queue(
            input clk,
			input rst,
			input read,
			input write,
			input en,
			input [`DATA_SIZE-1:0] queue_in,
			output logic queue_full,
			output logic queue_empty,
			output logic [`DATA_SIZE-1:0] queue_out
			);
  //logic [2:0] ptr;
  logic [2:0] read_ptr,write_ptr;
  logic [17:0] ram [7:0];//deepth 8 each has 8 bit 

  //logic [2:0] state, next;
  //logic [2:0] counter_write, counter_read;
  
 always_ff@(posedge clk) begin 
    if(rst) begin
	  for(int i=0;i<8;i++) begin
	    ram[i] <= 18'd0; 
	  end
      write_ptr <=3'b000;
	  read_ptr <= 3'b000;
	  queue_full <= 1'b0;
      queue_empty <= 1'b1;
	  queue_out <= `DATA_SIZE'd0;
	end  
	else begin
      if(en) begin 
        if(write) begin
          ram[write_ptr] <= queue_in;
		  $display("xx,x,x,x,,x,xQQ");
          write_ptr <= write_ptr + 1;
		end  
        else if(read) begin
          queue_out <= ram[read_ptr];
          read_ptr <= read_ptr + 1;
        end		
        else
		  queue_out <= queue_out;
		
		
		if(write_ptr == read_ptr && write_ptr!=3'b000) begin
		    queue_empty <= 1'b1;
		end
		else
		    queue_empty <= 1'b0;
      end
      else 
          queue_out <= queue_out;	  
    end
  end
endmodule