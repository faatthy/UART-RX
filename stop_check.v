module stop_check(
    input stop_check_en,
    input sampled_bit,
    input clk,rst,
    output reg stop_error
);
always @(posedge clk) begin
    if (!rst) begin
        stop_error<=1'b0;
    end
    else if (stop_check_en) begin
        stop_error<=(sampled_bit)?1'b0:1'b1;
    end
end
endmodule
