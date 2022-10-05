module sound_control #(
    parameter FREQ          = 50_000_000,
    parameter FREQ_QUARTER  = 12_500_000
)(
    input       clk,
    input       rst,
    input       sw,
    output      signal);

    wire    [($clog2(FREQ_QUARTER)-1):0]        counter_in;
    reg     [($clog2(FREQ_QUARTER)-1):0]        counter;
    reg                                         signal_reg;
    wire                                        signal_in;
    wire                                        counter_pulse_in;
    wire                                        counter_pulse;


    // increment counter
    always @(posedge clk) begin
        if (rst) begin
            counter <= 0;
        end
        else begin
            counter <= counter_in;
        end
    end
    assign counter_in = (counter_pulse) ? 0 : counter + 1;

    always @(posedge clk) begin
        if (rst) begin
            counter_pulse <= 1'b0;
        end
        else begin
            counter_pulse <= counter_pulse_in;
        end
    end
    assign counter_pulse_in = (counter === FREQ_QUARTER) ? 1'b1 : 1'b0;

    always @(posedge clk) begin
        if (rst) begin
            signal_reg <= 1'b0;
        end
        else begin
            signal_reg <= signal_in;
        end
    end
    assign signal_in = (counter_pulse) ? ~signal_reg : signal_reg;

    // assign signal = (sw) ? signal_reg : 1'b0;
    assign signal = signal_reg & sw;

endmodule