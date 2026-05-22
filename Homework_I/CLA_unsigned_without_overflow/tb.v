
`timescale 1ns/1ps

module tb;

reg  [7:0] A;
reg  [7:0] B;
reg        M;      // 0: add, 1: subtract
wire [7:0] SUM;
wire       C_out;

reg  [8:0] exp_ext;
reg  [7:0] exp_sum;
reg        exp_cout;

integer errors;
integer total;
integer SETTLE_NS = 8;
integer HOLD_NS = 10;

top UUT (
    .A(A),
    .B(B),
    .mode(M),
    .sum(SUM),
    .c_out(C_out)
);

task automatic calculate_expected_value;
    input [7:0] a_in;
    input [7:0] b_in;
    input       m_in;
    begin
        if (m_in == 1'b0)
            exp_ext = {1'b0, a_in} + {1'b0, b_in};
        else
            exp_ext = {1'b0, a_in} + {1'b0, ~b_in} + 9'b000000001;

        exp_sum  = exp_ext[7:0];
        exp_cout = exp_ext[8];
    end
endtask

task automatic run_case;
    input [8*80-1:0] desc;
    input [7:0] a_in;
    input [7:0] b_in;
    input       m_in;
    begin
        A = a_in;
        B = b_in;
        M = m_in;
        #(SETTLE_NS);

        calculate_expected_value(a_in, b_in, m_in);
        total = total + 1;

        if ((SUM !== exp_sum) || (C_out !== exp_cout)) begin
            errors = errors + 1;
            $display("| %9t | %1d | %02h | %02h |   %02h    |   %1b   |   %02h    |   %1b   | FAIL   | %0s",
                     $time, m_in, a_in, b_in, SUM, C_out, exp_sum, exp_cout, desc);
        end else begin
            $display("| %9t | %1d | %02h | %02h |   %02h    |   %1b   |   %02h    |   %1b   | PASS   | %0s",
                     $time, m_in, a_in, b_in, SUM, C_out, exp_sum, exp_cout, desc);
        end

        #(HOLD_NS);
    end
endtask

initial begin
    $display("CLA unsigned without overflow testbench");
    $display("beginning test...............");

    $fsdbDumpfile("tb.fsdb");
    $fsdbDumpvars(0, tb);

    errors = 0;
    total  = 0;

    $display("Each case is held for %0dns for clear waveform time frames.", HOLD_NS, "\n");
    $display("============================= testbench: relevant functional + edge-case vectors =============================");
    $display("|  time(ns) | M |  A |  B | DUT_SUM | DUT_C | EXP_SUM | EXP_C | RESULT | Description");
    $display("|-----------|---|----|----|---------|-------|---------|-------|--------|--------------------------------------");

    // Core addition behavior
    run_case("ADD basic: 0x12 + 0x34", 8'h12, 8'h34, 1'b0);
    run_case("ADD carry-out: 0xFF + 0x01", 8'hFF, 8'h01, 1'b0);
    run_case("ADD max + max: 0xFF + 0xFF", 8'hFF, 8'hFF, 1'b0);
    run_case("ADD zero + zero", 8'h00, 8'h00, 1'b0);

    // Core subtraction behavior
    run_case("SUB basic: 0x3A - 0x19", 8'h3A, 8'h19, 1'b1);
    run_case("SUB no borrow: 0x05 - 0x03", 8'h05, 8'h03, 1'b1);
    run_case("SUB borrow: 0x00 - 0x01", 8'h00, 8'h01, 1'b1);
    run_case("SUB underflow edge: 0x00 - 0xFF", 8'h00, 8'hFF, 1'b1);
    run_case("SUB self: A - A", 8'hA5, 8'hA5, 1'b1);

    // Edge/identity patterns
    run_case("ADD identity: A + 0", 8'hA5, 8'h00, 1'b0);
    run_case("SUB identity: A - 0", 8'hA5, 8'h00, 1'b1);
    run_case("ADD alternating bits: 0x55 + 0xAA", 8'h55, 8'hAA, 1'b0);
    run_case("SUB alternating bits: 0xAA - 0x55", 8'hAA, 8'h55, 1'b1);
    run_case("ADD nibble carry chain: 0x0F + 0x01", 8'h0F, 8'h01, 1'b0);

    $display("=== SUMMARY ===");
    $display("Total checks: %0d", total);
    $display("Errors: %0d", errors);

    if (errors == 0)
        $display("RESULT: PASS");
    else
        $display("RESULT: FAIL");

    $finish;
end

endmodule


//coded by Bingo
//
