module m_seq(
    input               clk,
    input               rst,
    input               set,
    input   [9:0]       seed,
    output              data,
    output              done
);

reg                             done_reg;
reg                             data_reg;

wire                            data_in;
wire                            done_in;

reg                             state;
wire                            state_in;

reg         [9:0]               lfsr;
wire        [9:0]               lfsr_in;

reg         [10:0]              count;
wire        [10:0]              count_in;

always @(posedge clk) begin
    if (rst) begin
        state <= 0;
    end
    else begin
        state <= state_in;
    end
end
assign state_in = set | state & ~done_reg;

assign done = done_reg;
always @(posedge clk) begin
    if (rst) begin
        done_reg <= 0;
    end
    else begin
        done_reg <= done_in;
    end
end
assign done_in = (state & (count == 11'h3fe)) ? 1 : 0;

always @(posedge clk) begin
    if (rst) begin
        lfsr = 0;
    end
    else begin
        if (state) begin
            lfsr <= lfsr_in;
        end
        else begin
            lfsr <= seed;
        end
    end
end
assign lfsr_in = {lfsr[8:0], 1'b0} ^ (10'h009 & {9{lfsr[9]}});
// assign lfsr_in = {lfsr[8:0], 1'b0} ^ (10'h009 & {lfsr[9],lfsr[9],lfsr[9],lfsr[9],lfsr[9],lfsr[9],lfsr[9],lfsr[9],lfsr[9],lfsr[9]});

// output data
assign data = data_reg;
always @(posedge clk) begin
    if (rst) begin
        data_reg <= 0;
    end
    else begin
        if (state) begin
            data_reg <= data_in;
        end
    end
end
assign data_in = lfsr_in[9];

always @(posedge clk) begin
    if (rst) begin
        count <= 0;
    end
    else begin
        count <= count_in;
    end
end
assign count_in = (state) ? ((count == 11'h3fe) ? 0 : count + 1): count;

endmodule