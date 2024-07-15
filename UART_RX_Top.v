module UART_RX_TOP(
    input RX_IN,
    input [5:0]prescale,
    input clk,rst,PAR_EN,parity_type,
    output wire[7:0] P_DATA,
    output wire data_valid,
    output wire stop_error,parity_error
);
wire enable;
wire parity_check_en;
wire sampled_bit;
wire [3:0]bit_cnt;
wire [5:0]edge_cnt;
wire data_samp_en,deser_en;
wire start_check_en,start_glitch;
wire stop_check_en;

UART_RX_FSM Fsm(
.clk(clk),
.rst(rst),
.RX_IN(RX_IN),
.prescale(prescale),
.edge_cnt(edge_cnt),
.PAR_EN(PAR_EN),
.bit_cnt(bit_cnt),
.parity_error(parity_error),
.start_glitch(start_glitch),
.stop_error(stop_error),
.parity_check_en(parity_check_en),
.start_check_en(start_check_en),
.stop_check_en(stop_check_en),
.deser_en(deser_en),
.enable(enable),
.data_samp_en(data_samp_en),
.data_valid(data_valid)
);

deserializer Desrializer(
.sampled_bit(sampled_bit),
.clk(clk),
.rst(rst),
.deser_en(deser_en),
.edge_cnt(edge_cnt),
.prescale(prescale),
.P_DATA(P_DATA)
);


data_sampling Data_Sampling(
.edge_cnt(edge_cnt),
.data_samp_en(data_samp_en),
.clk(clk),
.rst(rst),
.prescale(prescale),
.RX_IN(RX_IN),
.sampled_bit(sampled_bit)
);


parity_check Parity_Check(
.parity_check_en(parity_check_en),
.sampled_bit(sampled_bit),
.clk(clk),
.rst(rst),
.parity_type(parity_type),
.P_DATA(P_DATA),
.parity_error(parity_error)
);


start_check Start_Check(
.clk(clk),
.rst(rst),
.start_glitch(start_glitch),
.start_check_en(start_check_en),
.sampled_bit(sampled_bit)
);


stop_check Stop_Check(
.stop_check_en(stop_check_en),
.sampled_bit(sampled_bit),
.clk(clk),
.rst(rst),
.stop_error(stop_error)
);


edge_bit_counter Edge_Bit_Counter(
.enable(enable),
.clk(clk),
.rst(rst),
.prescale(prescale),
.bit_cnt(bit_cnt),
.edge_cnt(edge_cnt)
);

endmodule
