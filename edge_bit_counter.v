
module edge_bit_counter(
    input enable,clk,rst,
    input [5:0]prescale,
    output reg[3:0] bit_cnt,
    output reg[5:0] edge_cnt
);

always @(posedge clk) begin
  if (!rst) 
  begin
    bit_cnt<=4'b0;
    edge_cnt<=5'b0;
  end  
   else if(enable)
   begin
  if (edge_cnt!=prescale-1'b1)
   begin
    edge_cnt<=edge_cnt+1'b1;
  end  
  else
  begin
    edge_cnt<=5'b0;
    bit_cnt<=bit_cnt+1'b1;
  end
  end
  else
  begin
    edge_cnt<=5'b0;
    bit_cnt<=4'b0;
  end
end

endmodule