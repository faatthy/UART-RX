	module parity_check(
    input parity_check_en,
    input sampled_bit,
    input clk,rst,
    input parity_type,
    input [7:0] P_DATA,
    output reg parity_error
);
reg parity_bit;
always @(posedge clk) begin
    if (!rst) begin
        parity_error<=1'b0;
        parity_bit<=1'b0;
    end
    else if (parity_check_en) begin
        if (!parity_type) begin
            parity_bit=^P_DATA;
        end
        else
         begin
            parity_bit=~^P_DATA;
        end
        parity_error=(parity_bit==sampled_bit)?1'b0:1'b1;
    end
end
endmodule
