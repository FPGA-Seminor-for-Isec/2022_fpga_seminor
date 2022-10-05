module audio_tb();

    reg clk;
    reg rst;
    reg sw;
    wire signal;

    always #1 begin
        clk = ~clk;
    end

    always begin
        $display("start simulation");
        clk = 1'b0;
        rst = 1'b1;
        sw = 1'b1;
        #10
        rst = 1'b0;
        #10000
        sw = 1'b0;
        #10000
        sw = 1'b1;
        #100000
        $finish;
    end

    sound_control sound_control(
        .clk(clk),
        .rst(rst),
        .sw(sw),
        .signal(signal)
    );
endmodule
