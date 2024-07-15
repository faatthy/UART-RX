module deserializer(
    input sampled_bit,
    input clk,rst,
    input deser_en,
    input [5:0]edge_cnt,
    input [5:0]prescale,
    output reg[7:0] P_DATA
);
always @(posedge clk) begin
    if (!rst) begin
        P_DATA<=8'b0;
    end
    else if (deser_en) begin
        P_DATA<={sampled_bit,P_DATA[7:1]};
    end
end
endmodule
