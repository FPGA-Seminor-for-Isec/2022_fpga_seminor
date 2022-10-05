module adder_tb (
);

parameter MAX = 32;
reg [4:0] a;
reg [4:0] b;
wire [5:0] out;

integer i, j;

initial begin
    a = 5'h00;
    b = 5'h00;
    i = 0;
    j = 0;
end

always begin
    #0
    $display("START SIMULATION");

    for (i = 0; i < MAX; i = i + 1) begin
        #10
        a = i;
        for (j = 0; j < MAX; j = j + 1) begin
            b = j;
            
            #10
            $display("%03d+%03d=%03d", a, b, out);
        end
    end
    
    $display("FINISH SIMULATION");
    $finish;
end

adder adder(
    .a(a),
    .b(b),
    .out(out)
);

endmodule