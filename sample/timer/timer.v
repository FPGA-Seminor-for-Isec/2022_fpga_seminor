module timer #(
    parameter VALUE = 10,
    // parameter FREQ = 100_000_000
    parameter FREQ = 10
)(
    input                                       clk,
    input                                       rst,
    input                                       enable,
    output          [($clog2(VALUE+1)-1):0]     data
);

    wire            [($clog2(VALUE+1)-1):0]     data_in;
    reg             [($clog2(VALUE+1)-1):0]     data_reg;

    wire            [($clog2(FREQ+1)-1):0]      count_clock_in;
    reg             [($clog2(FREQ+1)-1):0]      count_clock;

    wire                                        sec_pulse_in;
    reg                                         sec_pulse;

    reg                                         enable_sync;

    assign data = data_reg;

    always @(posedge clk) begin
        if (rst) begin
            enable_sync <= 0;
        end
        else begin
            enable_sync <= enable;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            data_reg <= 0;
        end
        else begin
            if (enable_sync) begin
                data_reg <= data_in;
            end
            else begin
                data_reg <= data_reg;
            end
        end
    end
    assign data_in = sec_pulse ? ((data_reg == (VALUE - 1)) ? 0: data_reg + 1): data_reg;

    // generate pulse signal every 1 second
    always @(posedge clk) begin
        if (rst) begin
            sec_pulse <= 1'b0;
        end
        else begin
            if (enable_sync) begin
                sec_pulse <= sec_pulse_in;
            end
            else begin
                sec_pulse <= 1'b0;
            end
        end
    end
    assign sec_pulse_in = (count_clock == (FREQ - 1)) ? 1'b1 : 1'b0;

    // count up for 1 second from "clk"
    always @(posedge clk) begin
        if (rst) begin
            count_clock <= 0;
        end
        else begin
            if (enable_sync) begin
                count_clock <= count_clock_in;
            end
            else begin
                count_clock <= count_clock;
            end
        end
    end
    assign count_clock_in = (count_clock == (FREQ - 1)) ? 0: count_clock + 1;

endmodule