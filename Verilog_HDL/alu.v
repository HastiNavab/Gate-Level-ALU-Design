module ALU1bit(
    input a,
    input b,
    input cin,
    input [2:0] op,
    output reg result,
    output cout
);
    wire sum, carry;
    reg X, Y;
    
    assign sum = X ^ Y ^ cin;
    assign carry = (X & Y) | (X & cin) | (Y & cin);
    
    always @(*) begin
        case(op)
            3'b000: result = a | ~b;
            3'b001: result = ~a ^ b;
            3'b010: result = ~(a & b);
            3'b011: result = a ;
            3'b100: begin
                X = a;
                Y = b;
                result = sum;
            end
            3'b101: begin
                X = b;
                Y = b;
                result = sum;
            end
            3'b110: begin
                X = b;
                Y = ~a;
                result = sum;
            end
            3'b111: begin
                X = a;
                Y = 1'b0;
                result = sum;
            end
            default: result = 1'b0;
        endcase
    end
    
    assign cout = (op[2] == 1'b1) ? carry : 1'b0;
endmodule

module ALU4bit(
    input [3:0] A,
    input [3:0] B,
    input [2:0] op,
    output [4:0] Result
);
    wire [3:0] carry_out;
    wire cin0;
    
    assign cin0 = (op == 3'b111) ? 1'b1 : 1'b0;
    
    ALU1bit alu0 (
        .a(A[0]),
        .b(B[0]),
        .cin(cin0),
        .op(op),
        .result(Result[0]),
        .cout(carry_out[0])
    );
    
    ALU1bit alu1 (
        .a(A[1]),
        .b(B[1]),
        .cin(carry_out[0]),
        .op(op),
        .result(Result[1]),
        .cout(carry_out[1])
    );
    
    ALU1bit alu2 (
        .a(A[2]),
        .b(B[2]),
        .cin(carry_out[1]),
        .op(op),
        .result(Result[2]),
        .cout(carry_out[2])
    );
    
    ALU1bit alu3 (
        .a(A[3]),
        .b(B[3]),
        .cin(carry_out[2]),
        .op(op),
        .result(Result[3]),
        .cout(Result[4])
    );
endmodule