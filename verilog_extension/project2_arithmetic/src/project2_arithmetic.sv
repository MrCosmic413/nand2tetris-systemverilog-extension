// project2_arithmetic.sv
// Nand2Tetris Project 2 arithmetic chips in SystemVerilog


// Half Adder

module ntt_half_adder(
    input  logic a,
    input  logic b,
    output logic sum,
    output logic carry
);

    assign sum   = a ^ b;
    assign carry = a & b;

endmodule



// Full Adder

module ntt_full_adder(
    input  logic a,
    input  logic b,
    input  logic c,
    output logic sum,
    output logic carry
);

    logic first_sum;
    logic first_carry;
    logic second_carry;

    ntt_half_adder ha0 (
        .a(a),
        .b(b),
        .sum(first_sum),
        .carry(first_carry)
    );

    ntt_half_adder ha1 (
        .a(first_sum),
        .b(c),
        .sum(sum),
        .carry(second_carry)
    );

    assign carry = first_carry | second_carry;

endmodule


// Add16

module ntt_add16(
    input  logic [15:0] a,
    input  logic [15:0] b,
    output logic [15:0] out
);

    logic [15:0] carry;

    ntt_half_adder bit0 (
        .a(a[0]),
        .b(b[0]),
        .sum(out[0]),
        .carry(carry[0])
    );

    genvar i;
    generate
        for (i = 1; i < 16; i = i + 1) begin : add_bits
            ntt_full_adder fa (
                .a(a[i]),
                .b(b[i]),
                .c(carry[i-1]),
                .sum(out[i]),
                .carry(carry[i])
            );
        end
    endgenerate

endmodule


// Inc16

module ntt_inc16(
    input  logic [15:0] in,
    output logic [15:0] out
);

    ntt_add16 add_one (
        .a(in),
        .b(16'b0000_0000_0000_0001),
        .out(out)
    );

endmodule

// -------------------------
// ALU

// Inputs:
// x, y = 16-bit data inputs
// zx = zero x
// nx = negate x
// zy = zero y
// ny = negate y
// f  = function select: 0 = AND, 1 = ADD
// no = negate output
//
// Outputs:
// out = 16-bit result
// zr  = 1 if out == 0
// ng  = 1 if out is negative
// -------------------------
module ntt_alu(
    input  logic [15:0] x,
    input  logic [15:0] y,
    input  logic zx,
    input  logic nx,
    input  logic zy,
    input  logic ny,
    input  logic f,
    input  logic no,
    output logic [15:0] out,
    output logic zr,
    output logic ng
);

    logic [15:0] x_zeroed;
    logic [15:0] x_ready;

    logic [15:0] y_zeroed;
    logic [15:0] y_ready;

    logic [15:0] and_out;
    logic [15:0] add_out;
    logic [15:0] function_out;

    logic [15:0] final_out;

    // Prepare x
    assign x_zeroed = zx ? 16'b0000_0000_0000_0000 : x;
    assign x_ready  = nx ? ~x_zeroed : x_zeroed;

    // Prepare y
    assign y_zeroed = zy ? 16'b0000_0000_0000_0000 : y;
    assign y_ready  = ny ? ~y_zeroed : y_zeroed;

    // Build both possible operations
    assign and_out = x_ready & y_ready;

    ntt_add16 alu_adder (
        .a(x_ready),
        .b(y_ready),
        .out(add_out)
    );

    // Choose AND or ADD
    assign function_out = f ? add_out : and_out;

    // Optional final negation
    assign final_out = no ? ~function_out : function_out;

    // Final outputs
    assign out = final_out;
    assign zr  = (final_out == 16'b0000_0000_0000_0000);
    assign ng  = final_out[15];

endmodule