module timer_tb(
);
    reg             clk;
    reg             rst;
    reg             enable;
    wire    [3:0]   data;

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        enable = 1'b0;
    end

    always #1
    begin
        clk = ~clk;
    end

    always
    begin
        #10
        $display("start simulation\n");
        $display("initial data\n");
        $display("\"clk\" is %d\n", clk);
        $display("\"rst\" is %d\n", rst);
        $display("\"data\" is %02d\n", data);
        
        #1
        rst = 1'b0;
        
        #5
        $display("\"clk\" is %d\n", clk);
        $display("\"rst\" is %d\n", rst);
        $display("\"data\" is %02d\n", data);
        
        #10
        enable = 1'b1;

        #530
        enable = 1'b0;

        #20
        enable = 1'b1;

        #500
        $finish;
    end


    timer timer(
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .data(data)
    );
endmodule