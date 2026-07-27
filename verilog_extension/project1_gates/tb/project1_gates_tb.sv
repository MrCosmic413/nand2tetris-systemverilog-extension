module project1_gates_tb;

    logic a;
    logic b;
    logic sel;
    logic in;

    logic nand_out;
    logic not_out;
    logic and_out;
    logic or_out;
    logic xor_out;
    logic mux_out;
    logic dmux_a;
    logic dmux_b;

    ntt_nand nand_test (
        .a(a),
        .b(b),
        .out(nand_out)
    );

    ntt_not not_test (
        .in(in),
        .out(not_out)
    );

    ntt_and and_test (
        .a(a),
        .b(b),
        .out(and_out)
    );

    ntt_or or_test (
        .a(a),
        .b(b),
        .out(or_out)
    );

    ntt_xor xor_test (
        .a(a),
        .b(b),
        .out(xor_out)
    );

    ntt_mux mux_test (
        .a(a),
        .b(b),
        .sel(sel),
        .out(mux_out)
    );

    ntt_dmux dmux_test (
        .in(in),
        .sel(sel),
        .a(dmux_a),
        .b(dmux_b)
    );

    initial begin
        $display("testing project 1 one-bit gates");

        // nand tests
        a = 0; b = 0; #10;
        if (nand_out !== 1) $error("nand failed: 0 nand 0 should be 1");

        a = 0; b = 1; #10;
        if (nand_out !== 1) $error("nand failed: 0 nand 1 should be 1");

        a = 1; b = 0; #10;
        if (nand_out !== 1) $error("nand failed: 1 nand 0 should be 1");

        a = 1; b = 1; #10;
        if (nand_out !== 0) $error("nand failed: 1 nand 1 should be 0");


        // not tests
        in = 0; #10;
        if (not_out !== 1) $error("not failed: not 0 should be 1");

        in = 1; #10;
        if (not_out !== 0) $error("not failed: not 1 should be 0");


        // and tests
        a = 0; b = 0; #10;
        if (and_out !== 0) $error("and failed: 0 and 0 should be 0");

        a = 0; b = 1; #10;
        if (and_out !== 0) $error("and failed: 0 and 1 should be 0");

        a = 1; b = 0; #10;
        if (and_out !== 0) $error("and failed: 1 and 0 should be 0");

        a = 1; b = 1; #10;
        if (and_out !== 1) $error("and failed: 1 and 1 should be 1");


        // or tests
        a = 0; b = 0; #10;
        if (or_out !== 0) $error("or failed: 0 or 0 should be 0");

        a = 0; b = 1; #10;
        if (or_out !== 1) $error("or failed: 0 or 1 should be 1");

        a = 1; b = 0; #10;
        if (or_out !== 1) $error("or failed: 1 or 0 should be 1");

        a = 1; b = 1; #10;
        if (or_out !== 1) $error("or failed: 1 or 1 should be 1");


        // xor tests
        a = 0; b = 0; #10;
        if (xor_out !== 0) $error("xor failed: 0 xor 0 should be 0");

        a = 0; b = 1; #10;
        if (xor_out !== 1) $error("xor failed: 0 xor 1 should be 1");

        a = 1; b = 0; #10;
        if (xor_out !== 1) $error("xor failed: 1 xor 0 should be 1");

        a = 1; b = 1; #10;
        if (xor_out !== 0) $error("xor failed: 1 xor 1 should be 0");


        // mux tests
        a = 0; b = 1; sel = 0; #10;
        if (mux_out !== 0) $error("mux failed: sel 0 should choose a");

        a = 0; b = 1; sel = 1; #10;
        if (mux_out !== 1) $error("mux failed: sel 1 should choose b");

        a = 1; b = 0; sel = 0; #10;
        if (mux_out !== 1) $error("mux failed: sel 0 should choose a");

        a = 1; b = 0; sel = 1; #10;
        if (mux_out !== 0) $error("mux failed: sel 1 should choose b");


        // dmux tests
        in = 0; sel = 0; #10;
        if (dmux_a !== 0 || dmux_b !== 0) $error("dmux failed: in 0 sel 0 should output 0,0");

        in = 0; sel = 1; #10;
        if (dmux_a !== 0 || dmux_b !== 0) $error("dmux failed: in 0 sel 1 should output 0,0");

        in = 1; sel = 0; #10;
        if (dmux_a !== 1 || dmux_b !== 0) $error("dmux failed: in 1 sel 0 should output 1,0");

        in = 1; sel = 1; #10;
        if (dmux_a !== 0 || dmux_b !== 1) $error("dmux failed: in 1 sel 1 should output 0,1");


        $display("all one-bit project 1 gate tests complete");
        $finish;
    end

endmodule

