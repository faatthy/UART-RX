module start_check(
    input start_check_en,
    input sampled_bit,
    input clk,rst,
    output reg start_glitch
);
always @(posedge clk) begin
    if (!rst) begin
        start_glitch<=1'b0;
    end
    else if (start_check_en) begin
        start_glitch=(sampled_bit)?1'b1:1'b0;
    end
end
endmodule
