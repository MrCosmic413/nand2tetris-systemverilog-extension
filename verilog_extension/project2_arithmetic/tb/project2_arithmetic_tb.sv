// project2_arithmetic_tb.sv
// Testbench for Nand2Tetris Project 2 SystemVerilog extension

module project2_arithmetic_tb;

    // --------------------------------------------------
    // Signals for FullAdder
    // --------------------------------------------------
    logic a;
    logic b;
    logic c;
    logic sum;
    logic carry;

    ntt_full_adder full_adder_dut (
        .a(a),
        .b(b),
        .c(c),
        .sum(sum),
        .carry(carry)
    );

    // --------------------------------------------------
    // Signals for Add16
    // --------------------------------------------------
    logic [15:0] x;
    logic [15:0] y;
    logic [15:0] add_out;

    ntt_add16 add16_dut (
        .a(x),
        .b(y),
        .out(add_out)
    );

    // --------------------------------------------------
    // Signals for Inc16
    // --------------------------------------------------
    logic [15:0] inc_in;
    logic [15:0] inc_out;

    ntt_inc16 inc16_dut (
        .in(inc_in),
        .out(inc_out)
    );

    // --------------------------------------------------
    // Signals for ALU
    // --------------------------------------------------
    logic zx;
    logic nx;
    logic zy;
    logic ny;
    logic f;
    logic no;

    logic [15:0] alu_out;
    logic zr;
    logic ng;

    ntt_alu alu_dut (
        .x(x),
        .y(y),
        .zx(zx),
        .nx(nx),
        .zy(zy),
        .ny(ny),
        .f(f),
        .no(no),
        .out(alu_out),
        .zr(zr),
        .ng(ng)
    );

    initial begin
        $display("Testing Project 2 arithmetic chips...");

        // --------------------------------------------------
        // FullAdder tests
        // --------------------------------------------------
        a = 0; b = 0; c = 0; #10;
        if (sum !== 0 || carry !== 0) $error("FullAdder failed: 0 + 0 + 0");

        a = 0; b = 0; c = 1; #10;
        if (sum !== 1 || carry !== 0) $error("FullAdder failed: 0 + 0 + 1");

        a = 0; b = 1; c = 0; #10;
        if (sum !== 1 || carry !== 0) $error("FullAdder failed: 0 + 1 + 0");

        a = 0; b = 1; c = 1; #10;
        if (sum !== 0 || carry !== 1) $error("FullAdder failed: 0 + 1 + 1");

        a = 1; b = 0; c = 0; #10;
        if (sum !== 1 || carry !== 0) $error("FullAdder failed: 1 + 0 + 0");

        a = 1; b = 0; c = 1; #10;
        if (sum !== 0 || carry !== 1) $error("FullAdder failed: 1 + 0 + 1");

        a = 1; b = 1; c = 0; #10;
        if (sum !== 0 || carry !== 1) $error("FullAdder failed: 1 + 1 + 0");

        a = 1; b = 1; c = 1; #10;
        if (sum !== 1 || carry !== 1) $error("FullAdder failed: 1 + 1 + 1");

        $display("FullAdder tests passed.");

        // --------------------------------------------------
        // Add16 tests
        // --------------------------------------------------
        x = 16'd0; y = 16'd0; #10;
        if (add_out !== 16'd0) $error("Add16 failed: 0 + 0");

        x = 16'd5; y = 16'd7; #10;
        if (add_out !== 16'd12) $error("Add16 failed: 5 + 7");

        x = 16'd100; y = 16'd50; #10;
        if (add_out !== 16'd150) $error("Add16 failed: 100 + 50");

        x = 16'hFFFF; y = 16'd1; #10;
        if (add_out !== 16'h0000) $error("Add16 failed: overflow wraparound");

        $display("Add16 tests passed.");

        // --------------------------------------------------
        // Inc16 tests
        // --------------------------------------------------
        inc_in = 16'd0; #10;
        if (inc_out !== 16'd1) $error("Inc16 failed: 0 + 1");

        inc_in = 16'd5; #10;
        if (inc_out !== 16'd6) $error("Inc16 failed: 5 + 1");

        inc_in = 16'hFFFF; #10;
        if (inc_out !== 16'h0000) $error("Inc16 failed: overflow wraparound");

        $display("Inc16 tests passed.");

        // --------------------------------------------------
        // ALU tests
        // --------------------------------------------------

        // ALU should output 0
        x = 16'd123;
        y = 16'd456;
        zx = 1; nx = 0; zy = 1; ny = 0; f = 1; no = 0;
        #10;
        if (alu_out !== 16'd0 || zr !== 1 || ng !== 0)
            $error("ALU failed: output zero");

        // ALU should output 1
        x = 16'd123;
        y = 16'd456;
        zx = 1; nx = 1; zy = 1; ny = 1; f = 1; no = 1;
        #10;
        if (alu_out !== 16'd1 || zr !== 0 || ng !== 0)
            $error("ALU failed: output one");

        // ALU should output x
        x = 16'd21;
        y = 16'd99;
        zx = 0; nx = 0; zy = 1; ny = 1; f = 0; no = 0;
        #10;
        if (alu_out !== x)
            $error("ALU failed: output x");

        // ALU should output y
        x = 16'd21;
        y = 16'd99;
        zx = 1; nx = 1; zy = 0; ny = 0; f = 0; no = 0;
        #10;
        if (alu_out !== y)
            $error("ALU failed: output y");

        // ALU should output x + y
        x = 16'd12;
        y = 16'd8;
        zx = 0; nx = 0; zy = 0; ny = 0; f = 1; no = 0;
        #10;
        if (alu_out !== 16'd20)
            $error("ALU failed: x + y");

        // ALU should output x AND y
        x = 16'b0000_0000_0000_1010;
        y = 16'b0000_0000_0000_1100;
        zx = 0; nx = 0; zy = 0; ny = 0; f = 0; no = 0;
        #10;
        if (alu_out !== 16'b0000_0000_0000_1000)
            $error("ALU failed: x AND y");

        // Negative flag test
        x = 16'hFFFF;
        y = 16'd0;
        zx = 0; nx = 0; zy = 1; ny = 0; f = 1; no = 0;
        #10;
        if (ng !== 1)
            $error("ALU failed: negative flag");

        $display("ALU tests passed.");
        $display("All Project 2 SystemVerilog tests passed!");

        $finish;
    end

endmodule