module ntt_nand (
    input  logic a,
    input  logic b,
    output logic out
);
    assign out = ~(a & b);
endmodule


module ntt_not (
    input  logic in,
    output logic out
);
    ntt_nand nand0 (
        .a(in),
        .b(in),
        .out(out)
    );
endmodule


module ntt_and (
    input  logic a,
    input  logic b,
    output logic out
);
    logic nand_out;

    ntt_nand nand0 (
        .a(a),
        .b(b),
        .out(nand_out)
    );

    ntt_not not0 (
        .in(nand_out),
        .out(out)
    );
endmodule


module ntt_or (
    input  logic a,
    input  logic b,
    output logic out
);
    logic not_a;
    logic not_b;

    ntt_not not0 (
        .in(a),
        .out(not_a)
    );

    ntt_not not1 (
        .in(b),
        .out(not_b)
    );

    ntt_nand nand0 (
        .a(not_a),
        .b(not_b),
        .out(out)
    );
endmodule


module ntt_xor (
    input  logic a,
    input  logic b,
    output logic out
);
    logic not_a;
    logic not_b;
    logic a_and_not_b;
    logic not_a_and_b;

    ntt_not not0 (
        .in(a),
        .out(not_a)
    );

    ntt_not not1 (
        .in(b),
        .out(not_b)
    );

    ntt_and and0 (
        .a(a),
        .b(not_b),
        .out(a_and_not_b)
    );

    ntt_and and1 (
        .a(not_a),
        .b(b),
        .out(not_a_and_b)
    );

    ntt_or or0 (
        .a(a_and_not_b),
        .b(not_a_and_b),
        .out(out)
    );
endmodule


module ntt_mux (
    input  logic a,
    input  logic b,
    input  logic sel,
    output logic out
);
    logic not_sel;
    logic a_path;
    logic b_path;

    ntt_not not0 (
        .in(sel),
        .out(not_sel)
    );

    ntt_and and0 (
        .a(a),
        .b(not_sel),
        .out(a_path)
    );

    ntt_and and1 (
        .a(b),
        .b(sel),
        .out(b_path)
    );

    ntt_or or0 (
        .a(a_path),
        .b(b_path),
        .out(out)
    );
endmodule


module ntt_dmux (
    input  logic in,
    input  logic sel,
    output logic a,
    output logic b
);
    logic not_sel;

    ntt_not not0 (
        .in(sel),
        .out(not_sel)
    );

    ntt_and and0 (
        .a(in),
        .b(not_sel),
        .out(a)
    );

    ntt_and and1 (
        .a(in),
        .b(sel),
        .out(b)
    );
endmodule

module ntt_not16 (
    input  logic [15:0] in,
    output logic [15:0] out
);

    genvar i;

    generate
        for (i = 0; i < 16; i = i + 1) begin
            ntt_not not_gate (
                .in(in[i]),
                .out(out[i])
            );
        end
    endgenerate

endmodule


module ntt_and16 (
    input  logic [15:0] a,
    input  logic [15:0] b,
    output logic [15:0] out
);

    genvar i;

    generate
        for (i = 0; i < 16; i = i + 1) begin
            ntt_and and_gate (
                .a(a[i]),
                .b(b[i]),
                .out(out[i])
            );
        end
    endgenerate

endmodule


module ntt_or16 (
    input  logic [15:0] a,
    input  logic [15:0] b,
    output logic [15:0] out
);

    genvar i;

    generate
        for (i = 0; i < 16; i = i + 1) begin
            ntt_or or_gate (
                .a(a[i]),
                .b(b[i]),
                .out(out[i])
            );
        end
    endgenerate

endmodule


module ntt_mux16 (
    input  logic [15:0] a,
    input  logic [15:0] b,
    input  logic sel,
    output logic [15:0] out
);

    genvar i;

    generate
        for (i = 0; i < 16; i = i + 1) begin
            ntt_mux mux_gate (
                .a(a[i]),
                .b(b[i]),
                .sel(sel),
                .out(out[i])
            );
        end
    endgenerate

endmodule

module ntt_or8way (
    input  logic [7:0] in,
    output logic out
);

    logic or01;
    logic or23;
    logic or45;
    logic or67;
    logic or0123;
    logic or4567;

    ntt_or or0 (.a(in[0]), .b(in[1]), .out(or01));
    ntt_or or1 (.a(in[2]), .b(in[3]), .out(or23));
    ntt_or or2 (.a(in[4]), .b(in[5]), .out(or45));
    ntt_or or3 (.a(in[6]), .b(in[7]), .out(or67));

    ntt_or or4 (.a(or01), .b(or23), .out(or0123));
    ntt_or or5 (.a(or45), .b(or67), .out(or4567));

    ntt_or or6 (.a(or0123), .b(or4567), .out(out));

endmodule


module ntt_mux4way16 (
    input  logic [15:0] a,
    input  logic [15:0] b,
    input  logic [15:0] c,
    input  logic [15:0] d,
    input  logic [1:0]  sel,
    output logic [15:0] out
);

    logic [15:0] ab;
    logic [15:0] cd;

    ntt_mux16 mux0 (
        .a(a),
        .b(b),
        .sel(sel[0]),
        .out(ab)
    );

    ntt_mux16 mux1 (
        .a(c),
        .b(d),
        .sel(sel[0]),
        .out(cd)
    );

    ntt_mux16 mux2 (
        .a(ab),
        .b(cd),
        .sel(sel[1]),
        .out(out)
    );

endmodule


module ntt_mux8way16 (
    input  logic [15:0] a,
    input  logic [15:0] b,
    input  logic [15:0] c,
    input  logic [15:0] d,
    input  logic [15:0] e,
    input  logic [15:0] f,
    input  logic [15:0] g,
    input  logic [15:0] h,
    input  logic [2:0]  sel,
    output logic [15:0] out
);

    logic [15:0] top_half;
    logic [15:0] bottom_half;

    ntt_mux4way16 mux0 (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel[1:0]),
        .out(top_half)
    );

    ntt_mux4way16 mux1 (
        .a(e),
        .b(f),
        .c(g),
        .d(h),
        .sel(sel[1:0]),
        .out(bottom_half)
    );

    ntt_mux16 mux2 (
        .a(top_half),
        .b(bottom_half),
        .sel(sel[2]),
        .out(out)
    );

endmodule


module ntt_dmux4way (
    input  logic in,
    input  logic [1:0] sel,
    output logic a,
    output logic b,
    output logic c,
    output logic d
);

    logic top;
    logic bottom;

    ntt_dmux dmux0 (
        .in(in),
        .sel(sel[1]),
        .a(top),
        .b(bottom)
    );

    ntt_dmux dmux1 (
        .in(top),
        .sel(sel[0]),
        .a(a),
        .b(b)
    );

    ntt_dmux dmux2 (
        .in(bottom),
        .sel(sel[0]),
        .a(c),
        .b(d)
    );

endmodule


module ntt_dmux8way (
    input  logic in,
    input  logic [2:0] sel,
    output logic a,
    output logic b,
    output logic c,
    output logic d,
    output logic e,
    output logic f,
    output logic g,
    output logic h
);

    logic top_half;
    logic bottom_half;

    ntt_dmux dmux0 (
        .in(in),
        .sel(sel[2]),
        .a(top_half),
        .b(bottom_half)
    );

    ntt_dmux4way dmux1 (
        .in(top_half),
        .sel(sel[1:0]),
        .a(a),
        .b(b),
        .c(c),
        .d(d)
    );

    ntt_dmux4way dmux2 (
        .in(bottom_half),
        .sel(sel[1:0]),
        .a(e),
        .b(f),
        .c(g),
        .d(h)
    );

endmodule