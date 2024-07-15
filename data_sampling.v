module data_sampling(
    input [5:0]edge_cnt,
    input data_samp_en,clk,rst,
    input [5:0]prescale,
    input RX_IN,
    output reg sampled_bit
);
reg [2:0] samples;
always @(posedge clk) begin
    if (!rst) begin
        sampled_bit<=1'b0;
        samples<=3'b0;
    end
    else if (data_samp_en) begin
        if (edge_cnt==(prescale>>1'b1)) begin
            samples[1]<=RX_IN;     // half bit
        end
        else if (edge_cnt== ((prescale>>1'b1)-1'b1)) begin
            samples[0]<=RX_IN;    //half bit before
        end
        else if (edge_cnt== ((prescale>>1'b1)+1'b1)) begin
            samples[2]=RX_IN;   //half bit after here sampling is done 
	    sampled_bit=((samples[0]&&samples[1])|(samples[0]&&samples[2])|(samples[1]&&samples[2]));
        end
    end
    else
    begin
      samples<=3'b0;
      sampled_bit<=1'b0;
    end
end
endmodule

