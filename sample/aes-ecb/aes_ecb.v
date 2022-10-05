module top(
    input clk,
    input rst,
    input run,
    input [127:0] plain_text
);
    reg [127:0] cipher_text;
    reg [127:0] decrypted_text;

    reg enc_run;
    reg enc_done;
    reg dec_run;
    reg dec_done;

    always @(posedge clk) begin
        if (run) begin
            enc_run <= 1'b1;
        end
        else begin
            enc_run <= 1'b0;
        end
    end

    always @(posedge clk) begin
        if (enc_done) begin
            dec_run <= 1'b1;
        end
        else begin
            dec_run <= 1'b0;
        end
    end


    aes_enc(.clk(clk), .rst(rst), .run(enc_run), .plain_text(plain_text), .cipher_text(cipher_text), .done(enc_done));
    aes_dec(.clk(clk), .rst(rst), .run(dec_run), .cipher_text(cipher_text), .decrypted_text(decrypted_text), .done(dec_done));

endmodule

module aes_enc(
    input clk,
    input rst,
    input run,
    input [127:0] plain_text,
    output [127:0] cipher_text,
    output done
);
// 以下記述（モジュール接続や状態遷移をうまく使う）
    reg enable;

endmodule