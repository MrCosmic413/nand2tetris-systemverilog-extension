module project1_16bit_tb;

    logic [15:0] in;
    logic [15:0] a;
    logic [15:0] b;
    logic sel;

    logic [15:0] not_out;
    logic [15:0] and_out;
    logic [15:0] or_out;
    logic [15:0] mux_out;

    ntt_not16 not16_test (
        .in(in),
        .out(not_out)
    );

    ntt_and16 and16_test (
        .a(a),
        .b(b),
        .out(and_out)
    );

    ntt_or16 or16_test (
        .a(a),
        .b(b),
        .out(or_out)
    );

    ntt_mux16 mux16_test (
        .a(a),
        .b(b),
        .sel(sel),
        .out(mux_out)
    );

    initial begin
        $display("testing project 1 16-bit gates");

        // not16 tests
        in = 16'h0000; #10;
        if (not_out !== 16'hffff) $error("not16 failed: not 0000 should be ffff");

        in = 16'haaaa; #10;
        if (not_out !== 16'h5555) $error("not16 failed: not aaaa should be 5555");

        in = 16'hffff; #10;
        if (not_out !== 16'h0000) $error("not16 failed: not ffff should be 0000");


        // and16 tests
        a = 16'haaaa;
        b = 16'hcccc;
        #10;
        if (and_out !== 16'h8888) $error("and16 failed: aaaa and cccc should be 8888");

        a = 16'hffff;
        b = 16'h1234;
        #10;
        if (and_out !== 16'h1234) $error("and16 failed: ffff and 1234 should be 1234");


        // or16 tests
        a = 16'haaaa;
        b = 16'hcccc;
        #10;
        if (or_out !== 16'heeee) $error("or16 failed: aaaa or cccc should be eeee");

        a = 16'h0000;
        b = 16'h1234;
        #10;
        if (or_out !== 16'h1234) $error("or16 failed: 0000 or 1234 should be 1234");


        // mux16 tests
        a = 16'haaaa;
        b = 16'h5555;

        sel = 0; #10;
        if (mux_out !== 16'haaaa) $error("mux16 failed: sel 0 should choose a");

        sel = 1; #10;
        if (mux_out !== 16'h5555) $error("mux16 failed: sel 1 should choose b");


        $display("all 16-bit project 1 gate tests complete");
        $finish;
    end

endmodule