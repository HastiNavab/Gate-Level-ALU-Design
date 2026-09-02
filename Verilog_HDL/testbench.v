timescale 1ns/1ps
module tb_ALU4bit();
    reg [3:0] A, B;
    reg [2:0] op;
    wire [4:0] Result;

    ALU4bit uut (
        .A(A),
        .B(B),
        .op(op),
        .Result(Result)
    );

    initial begin
        $display("Start Testing ALU4bit...");

        op = 3'b000; A = 4'b1100; B = 4'b1010; #10;
        op = 3'b001; A = 4'b1100; B = 4'b1010; #10;
        op = 3'b010; A = 4'b1100; B = 4'b1010; #10;
        op = 3'b011; A = 4'b1100; B = 4'b1010; #10;
        op = 3'b100; A = 4'b0011; B = 4'b0101; #10;
        op = 3'b101; A = 4'b0011; B = 4'b0101; #10;
        op = 3'b110; A = 4'b0010; B = 4'b0100; #10;
        op = 3'b111; A = 4'b0011; B = 4'b0101; #10;

        $display("Finished Testing.");
        $finish;
    end
endmodule
