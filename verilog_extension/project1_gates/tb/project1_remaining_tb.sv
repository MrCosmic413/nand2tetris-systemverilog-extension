module project1_remaining_tb;

    logic [7:0] in8;
    logic or8_out;

    logic [15:0] a;
    logic [15:0] b;
    logic [15:0] c;
    logic [15:0] d;
    logic [15:0] e;
    logic [15:0] f;
    logic [15:0] g;
    logic [15:0] h;

    logic [1:0] sel2;
    logic [2:0] sel3;

    logic [15:0] mux4_out;
    logic [15:0] mux8_out;

    logic in1;

    logic d4_a;
    logic d4_b;
    logic d4_c;
    logic d4_d;

    logic d8_a;
    logic d8_b;
    logic d8_c;
    logic d8_d;
    logic d8_e;
    logic d8_f;
    logic d8_g;
    logic d8_h;

    ntt_or8way or8_test (
        .in(in8),
        .out(or8_out)
    );

    ntt_mux4way16 mux4_test (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel2),
        .out(mux4_out)
    );

    ntt_mux8way16 mux8_test (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g),
        .h(h),
        .sel(sel3),
        .out(mux8_out)
    );

    ntt_dmux4way dmux4_test (
        .in(in1),
        .sel(sel2),
        .a(d4_a),
        .b(d4_b),
        .c(d4_c),
        .d(d4_d)
    );

    ntt_dmux8way dmux8_test (
        .in(in1),
        .sel(sel3),
        .a(d8_a),
        .b(d8_b),
        .c(d8_c),
        .d(d8_d),
        .e(d8_e),
        .f(d8_f),
        .g(d8_g),
        .h(d8_h)
    );

    initial begin
        $display("testing remaining project 1 gates");

        // or8way tests
        in8 = 8'b00000000; #10;
        if (or8_out !== 0) $error("or8way failed: all zeros should output 0");

        in8 = 8'b00000001; #10;
        if (or8_out !== 1) $error("or8way failed: bit 0 is 1, output should be 1");

        in8 = 8'b10000000; #10;
        if (or8_out !== 1) $error("or8way failed: bit 7 is 1, output should be 1");

        in8 = 8'b00100000; #10;
        if (or8_out !== 1) $error("or8way failed: one middle bit is 1, output should be 1");


        // mux4way16 tests
        a = 16'h1111;
        b = 16'h2222;
        c = 16'h3333;
        d = 16'h4444;

        sel2 = 2'b00; #10;
        if (mux4_out !== 16'h1111) $error("mux4way16 failed: sel 00 should choose a");

        sel2 = 2'b01; #10;
        if (mux4_out !== 16'h2222) $error("mux4way16 failed: sel 01 should choose b");

        sel2 = 2'b10; #10;
        if (mux4_out !== 16'h3333) $error("mux4way16 failed: sel 10 should choose c");

        sel2 = 2'b11; #10;
        if (mux4_out !== 16'h4444) $error("mux4way16 failed: sel 11 should choose d");


        // mux8way16 tests
        a = 16'h0001;
        b = 16'h0002;
        c = 16'h0003;
        d = 16'h0004;
        e = 16'h0005;
        f = 16'h0006;
        g = 16'h0007;
        h = 16'h0008;

        sel3 = 3'b000; #10;
        if (mux8_out !== 16'h0001) $error("mux8way16 failed: sel 000 should choose a");

        sel3 = 3'b001; #10;
        if (mux8_out !== 16'h0002) $error("mux8way16 failed: sel 001 should choose b");

        sel3 = 3'b010; #10;
        if (mux8_out !== 16'h0003) $error("mux8way16 failed: sel 010 should choose c");

        sel3 = 3'b011; #10;
        if (mux8_out !== 16'h0004) $error("mux8way16 failed: sel 011 should choose d");

        sel3 = 3'b100; #10;
        if (mux8_out !== 16'h0005) $error("mux8way16 failed: sel 100 should choose e");

        sel3 = 3'b101; #10;
        if (mux8_out !== 16'h0006) $error("mux8way16 failed: sel 101 should choose f");

        sel3 = 3'b110; #10;
        if (mux8_out !== 16'h0007) $error("mux8way16 failed: sel 110 should choose g");

        sel3 = 3'b111; #10;
        if (mux8_out !== 16'h0008) $error("mux8way16 failed: sel 111 should choose h");


        // dmux4way tests
        in1 = 1;

        sel2 = 2'b00; #10;
        if ({d4_a, d4_b, d4_c, d4_d} !== 4'b1000) $error("dmux4way failed: sel 00 should send input to a");

        sel2 = 2'b01; #10;
        if ({d4_a, d4_b, d4_c, d4_d} !== 4'b0100) $error("dmux4way failed: sel 01 should send input to b");

        sel2 = 2'b10; #10;
        if ({d4_a, d4_b, d4_c, d4_d} !== 4'b0010) $error("dmux4way failed: sel 10 should send input to c");

        sel2 = 2'b11; #10;
        if ({d4_a, d4_b, d4_c, d4_d} !== 4'b0001) $error("dmux4way failed: sel 11 should send input to d");


        // dmux8way tests
        in1 = 1;

        sel3 = 3'b000; #10;
        if ({d8_a, d8_b, d8_c, d8_d, d8_e, d8_f, d8_g, d8_h} !== 8'b10000000) $error("dmux8way failed: sel 000 should send input to a");

        sel3 = 3'b001; #10;
        if ({d8_a, d8_b, d8_c, d8_d, d8_e, d8_f, d8_g, d8_h} !== 8'b01000000) $error("dmux8way failed: sel 001 should send input to b");

        sel3 = 3'b010; #10;
        if ({d8_a, d8_b, d8_c, d8_d, d8_e, d8_f, d8_g, d8_h} !== 8'b00100000) $error("dmux8way failed: sel 010 should send input to c");

        sel3 = 3'b011; #10;
        if ({d8_a, d8_b, d8_c, d8_d, d8_e, d8_f, d8_g, d8_h} !== 8'b00010000) $error("dmux8way failed: sel 011 should send input to d");

        sel3 = 3'b100; #10;
        if ({d8_a, d8_b, d8_c, d8_d, d8_e, d8_f, d8_g, d8_h} !== 8'b00001000) $error("dmux8way failed: sel 100 should send input to e");

        sel3 = 3'b101; #10;
        if ({d8_a, d8_b, d8_c, d8_d, d8_e, d8_f, d8_g, d8_h} !== 8'b00000100) $error("dmux8way failed: sel 101 should send input to f");

        sel3 = 3'b110; #10;
        if ({d8_a, d8_b, d8_c, d8_d, d8_e, d8_f, d8_g, d8_h} !== 8'b00000010) $error("dmux8way failed: sel 110 should send input to g");

        sel3 = 3'b111; #10;
        if ({d8_a, d8_b, d8_c, d8_d, d8_e, d8_f, d8_g, d8_h} !== 8'b00000001) $error("dmux8way failed: sel 111 should send input to h");


        $display("all remaining project 1 gate tests complete");
        $finish;
    end

endmodule
