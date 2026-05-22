module tb;
 
reg    [5:0] a0, a1, a2, a3, a4;
wire   [5:0] out;

reg [5:0] exp_out;
reg [2:0] exp_idx;
reg [2:0] got_idx;
localparam integer HOLD_NS = 5;
localparam integer SETTLE_NS = 5;

integer total = 0;
integer errors = 0;


median UUT (
    .a0(a0),
    .a1(a1),
    .a2(a2),
    .a3(a3),
    .a4(a4),
    .out(out)
);

//function:must return value, instant(combinational)
//task:no return value, can take time(sequential)

function [2:0] onehot_to_index;
    input [5:0] onehot;
    begin
        case (onehot)
            6'b000001: onehot_to_index = 3'd0;
            6'b000010: onehot_to_index = 3'd1;
            6'b000100: onehot_to_index = 3'd2;
            6'b001000: onehot_to_index = 3'd3;
            6'b010000: onehot_to_index = 3'd4;
            6'b100000: onehot_to_index = 3'd5;
            default:   onehot_to_index = 3'd0;
        endcase
    end
endfunction


task automatic calculate_expected_value;
    input [5:0] a0_in, a1_in, a2_in, a3_in, a4_in;
    reg [2:0] s0, s1, s2, s3, s4, s5;
    reg [2:0] c0, c1, c2, c3, c4, c5;
    begin
        s0 = a0_in[0] + a1_in[0] + a2_in[0] + a3_in[0] + a4_in[0];
        s1 = a0_in[1] + a1_in[1] + a2_in[1] + a3_in[1] + a4_in[1];
        s2 = a0_in[2] + a1_in[2] + a2_in[2] + a3_in[2] + a4_in[2];
        s3 = a0_in[3] + a1_in[3] + a2_in[3] + a3_in[3] + a4_in[3];
        s4 = a0_in[4] + a1_in[4] + a2_in[4] + a3_in[4] + a4_in[4];
        s5 = a0_in[5] + a1_in[5] + a2_in[5] + a3_in[5] + a4_in[5];

        c0 = s0;
        c1 = c0 + s1;
        c2 = c1 + s2;
        c3 = c2 + s3;
        c4 = c3 + s4;
        c5 = c4 + s5;

        exp_out = 6'b000001;
        if      (c0 >= 3) exp_out = 6'b000001;
        else if (c1 >= 3) exp_out = 6'b000010;
        else if (c2 >= 3) exp_out = 6'b000100;
        else if (c3 >= 3) exp_out = 6'b001000;
        else if (c4 >= 3) exp_out = 6'b010000;
        else if (c5 >= 3) exp_out = 6'b100000;

        exp_idx = onehot_to_index(exp_out);
    end
endtask


task automatic run_case;
    input [5:0] a0_in, a1_in, a2_in, a3_in, a4_in;
    input [8*80-1:0] desc;
    begin
        a0 = a0_in; a1 = a1_in; a2 = a2_in; a3 = a3_in; a4 = a4_in;
        calculate_expected_value(a0_in, a1_in, a2_in, a3_in, a4_in);

        #(SETTLE_NS);
        got_idx = onehot_to_index(out);
        if (out !== exp_out) begin
            $display("%6t | %b %b %b %b %b | %b    %b | %1d(%03b)   %1d(%03b) | %-6s | %-30s",
                     $time, a0, a1, a2, a3, a4, exp_out, out, exp_idx, exp_idx, got_idx, got_idx, "FAIL", desc);
            errors = errors + 1;
        end else begin
            $display("%6t | %b %b %b %b %b | %b    %b | %1d(%03b)   %1d(%03b) | %-6s | %-30s",
                     $time, a0, a1, a2, a3, a4, exp_out, out, exp_idx, exp_idx, got_idx, got_idx, "PASS", desc);
        end
        total = total + 1;
        #(HOLD_NS);
    end
endtask


//main part
initial begin

    $fsdbDumpfile("tb_median.fsdb");
    $fsdbDumpvars(0, tb);

    #5;
    $display("This is a very awesome testbench made by Bingo");
    $display("Each test is held for %0d and settles for %0d units", HOLD_NS, SETTLE_NS);
    $display("Median of five 6-bit one-hot inputs is reported");
    $display("Testing...................");
    $display(" time  |   a0      a1      a2      a3      a4    | exp_out  out   | exp_med   got_med   | Result | Description");
    $display("--------------------------------------------------------------------------------------------------------------------------------");


    $display("[MAIN FUNCTION CASES]");
    run_case(6'b100000, 6'b100000, 6'b010000, 6'b000100, 6'b000001, "main_1_example_from_TA");
    run_case(6'b000001, 6'b000010, 6'b000100, 6'b001000, 6'b010000, "main_2_sorted_unique");
    run_case(6'b000100, 6'b000100, 6'b000100, 6'b100000, 6'b000001, "main_3_clear_middle_repeat");


    $display("[EDGE CASES]");
    run_case(6'b000001, 6'b000001, 6'b000001, 6'b000001, 6'b000001, "edge_1_all_same_lowest");
    run_case(6'b100000, 6'b100000, 6'b100000, 6'b100000, 6'b100000, "edge_2_all_same_highest");
    run_case(6'b000001, 6'b000010, 6'b000100, 6'b001000, 6'b100000, "edge_3_wide_spread");


    $display("[CORNER CASES]");
    run_case(6'b010000, 6'b010000, 6'b000001, 6'b100000, 6'b000010, "corner_1_two_equal_median");
    run_case(6'b001000, 6'b000100, 6'b001000, 6'b010000, 6'b000001, "corner_2_middle_dominates");
    run_case(6'b100000, 6'b010000, 6'b010000, 6'b001000, 6'b000001, "corner_3_top_heavy");

    $display("--------------------------------------------------------------------------------------------------------------------------------");
    if (errors == 0)
        $display("SUMMARY: PASS (%0d/%0d)", total, total);
    else
        $display("SUMMARY: FAIL (%0d errors out of %0d)", errors, total);

    $finish;
end


endmodule


//coded by Bingo
