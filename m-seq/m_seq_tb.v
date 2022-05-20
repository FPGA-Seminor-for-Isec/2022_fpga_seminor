module m_seq_tb(
);

reg                 clk;
reg                 rst;
reg                 set;
reg     [9:0]       seed;
wire                data;
wire                done;

integer             i;

initial begin
    clk = 0;
    rst = 1;
    set = 0;
    seed = 4'b0;
end

always begin
    #1
    clk = ~clk;
end

always begin
    #0
    $display("START SIMULATION");
    #10
    seed = 1;
    $display("seed = %010b", seed);
    $display("f(x) = x^10 + x^3 + 1");
    #10
    rst = 0;
    $display("rst = %d", rst);
    
    #10
    set = 1;
    $display("set = %d", set);
    $display("*** start ***");
    #2
    set = 0;
    i = 0;
    $display("set = %d", set);
    // $display("i = %02d, data = %01b", i, data);
    for(i = 1; i < 1030; i = i + 1) begin
        #2
        $display("i = %04d, data = %01b", i, data);
    end
    $display("FINISH SIMULATION");
    $finish;
end

m_seq m_seq(
    .clk(clk),
    .rst(rst),
    .set(set),
    .seed(seed),
    .data(data),
    .done(done)
);

endmodule