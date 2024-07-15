module UART_RX_FSM(
    input clk,rst,
    input RX_IN,
    input [5:0]prescale,edge_cnt,
    input PAR_EN,
    input [3:0]bit_cnt,
    input parity_error,start_glitch,stop_error,
    output  parity_check_en,start_check_en,stop_check_en,
    output  deser_en,enable,data_samp_en,
    output reg data_valid
);
reg data_valid_comp;
localparam idle_state =3'b000 ;
localparam start_state =3'b001 ;
localparam data_sampling_state =3'b010;
localparam parity_check_state = 3'b011;
localparam stop_check_state = 3'b100;
//localparam data_valid_state = 3'b101;
localparam consequent_frame_state =3'b101 ;

reg [2:0] state_reg;
reg [2:0] state_next;

always @(posedge clk) begin
    if (!rst) begin
        state_reg<=idle_state;
        data_valid<=1'b0;
    end
    else
    begin
      state_reg<=state_next;
      data_valid<=data_valid_comp;
    end
end
always @(*) begin
    case (state_reg)
      idle_state  : begin
        if (RX_IN) begin
            state_next=idle_state;
        end
        else
        begin
          state_next=start_state;
        end
      end
      start_state:begin
        if (edge_cnt==((prescale>>1'b1)+2'd3)&&start_glitch) begin
            state_next=idle_state;
        end
        else if(edge_cnt==prescale-1'b1) begin
            state_next=data_sampling_state;
        end
        else
        begin
          state_next=start_state;
        end
      end
      data_sampling_state:begin
        if (bit_cnt==4'd8&&edge_cnt==prescale-1'b1) begin
          if (PAR_EN) begin
            state_next=parity_check_state;
          end
          else
          begin
            state_next=stop_check_state;
          end
        end
      end
      parity_check_state:begin
        if (edge_cnt==prescale-1'b1) begin
            state_next=stop_check_state;
        end
        else
        begin
          state_next=parity_check_state;
        end
        end
      stop_check_state:begin
        if (edge_cnt==prescale-'d2) begin  //before stop by one clock cycle to check it will go to idle or start state 
            state_next=consequent_frame_state;
        end
        else
        begin
          state_next=stop_check_state;
        end
      end
      consequent_frame_state:begin
        if(!RX_IN)begin
          state_next=start_state;
        end
        else
        begin
          state_next=idle_state;
        end
      end
        default: state_next=idle_state;
    endcase
end
always @(*) begin
  if (state_reg==consequent_frame_state) begin
    if (PAR_EN) begin
      if (!parity_error&&!stop_error) begin
        data_valid_comp=1'b1;
      end
      else
      begin
        data_valid_comp=1'b0;
      end
    end
    else
    begin
      if (!stop_error) begin
        data_valid_comp=1'b1;
      end
      else
      begin
        data_valid_comp=1'b0;  
      end
    end
  end
  else
  begin
    data_valid_comp=1'b0;
  end
end
assign deser_en=((state_reg==data_sampling_state)&&(edge_cnt==(prescale>>'d1)+'d2))?1'b1:1'b0;
assign start_check_en=((state_reg==start_state)&&(edge_cnt==(prescale>>'d1)+'d2))?1'b1:1'b0;
assign stop_check_en=((state_reg==stop_check_state)&&(edge_cnt==(prescale>>'d1)+'d2))?1'b1:1'b0;
assign parity_check_en=((state_reg==parity_check_state)&&(edge_cnt==(prescale>>'d1)+'d2))?1'b1:1'b0;
assign enable= ((state_next == idle_state)) ? 'd0: 'd1;
assign data_samp_en=(state_reg==idle_state)?1'b0:1'b1;

endmodule
