`timescale 1ns/1ps

module traffic_light_tb;

reg clk;

// Traffic-light DUT signals
reg t_reset;
reg midnight;
wire A_G, A_Y, A_R, B_G, B_Y, B_R;

// Counter DUT signals
reg c_reset;
reg c_en;
reg c_clr;
wire [2:0] c_count;
reg [2:0] expected_c_count;

integer errors;
integer i;
integer phase;
integer phase_cycle;
integer actual_phase;

traffic_light UUT (
    .clk(clk),
    .reset(t_reset),
    .midnight(midnight),
    .A_G(A_G),
    .A_Y(A_Y),
    .A_R(A_R),
    .B_G(B_G),
    .B_Y(B_Y),
    .B_R(B_R)
);

synchronous_counter #(.WIDTH(3)) counter_UUT (
    .clk(clk),
    .reset(c_reset),
    .en(c_en),
    .clr(c_clr),
    .count(c_count)
);

always #5 clk = ~clk;

task expect_lights;
    input integer s;
    begin
        case (s)
            0: if ({A_G, A_Y, A_R, B_G, B_Y, B_R} !== 6'b100001) begin
                   $display("[TRAFFIC][FAIL] t=%0t S0 expected 100001 got %b%b%b%b%b%b", $time, A_G, A_Y, A_R, B_G, B_Y, B_R);
                   errors = errors + 1;
               end
            1: if ({A_G, A_Y, A_R, B_G, B_Y, B_R} !== 6'b010001) begin
                   $display("[TRAFFIC][FAIL] t=%0t S1 expected 010001 got %b%b%b%b%b%b", $time, A_G, A_Y, A_R, B_G, B_Y, B_R);
                   errors = errors + 1;
               end
            2: if ({A_G, A_Y, A_R, B_G, B_Y, B_R} !== 6'b001001) begin
                   $display("[TRAFFIC][FAIL] t=%0t S2 expected 001001 got %b%b%b%b%b%b", $time, A_G, A_Y, A_R, B_G, B_Y, B_R);
                   errors = errors + 1;
               end
            3: if ({A_G, A_Y, A_R, B_G, B_Y, B_R} !== 6'b001100) begin
                   $display("[TRAFFIC][FAIL] t=%0t S3 expected 001100 got %b%b%b%b%b%b", $time, A_G, A_Y, A_R, B_G, B_Y, B_R);
                   errors = errors + 1;
               end
            4: if ({A_G, A_Y, A_R, B_G, B_Y, B_R} !== 6'b001010) begin
                   $display("[TRAFFIC][FAIL] t=%0t S4 expected 001010 got %b%b%b%b%b%b", $time, A_G, A_Y, A_R, B_G, B_Y, B_R);
                   errors = errors + 1;
               end
            6: begin
                   if ((phase_cycle % 2) == 1) begin
                       if ({A_G, A_Y, A_R, B_G, B_Y, B_R} !== 6'b010000) begin
                           $display("[TRAFFIC][FAIL] t=%0t S6 expected 010000 got %b%b%b%b%b%b", $time, A_G, A_Y, A_R, B_G, B_Y, B_R);
                           errors = errors + 1;
                       end
                   end else begin
                       if ({A_G, A_Y, A_R, B_G, B_Y, B_R} !== 6'b000010) begin
                           $display("[TRAFFIC][FAIL] t=%0t S6 expected 000010 got %b%b%b%b%b%b", $time, A_G, A_Y, A_R, B_G, B_Y, B_R);
                           errors = errors + 1;
                       end
                   end
               end
        endcase
    end
endtask

task decode_actual_phase;
    output integer s;
    begin
        case ({A_G, A_Y, A_R, B_G, B_Y, B_R})
            6'b100001: s = 0; // S0
            6'b010001: s = 1; // S1
            6'b001001: s = 2; // S2
            6'b001100: s = 3; // S3
            6'b001010: s = 4; // S4
            6'b010000,
            6'b000010: begin
                if (phase == 6) s = 6;
                else s = -1;
            end
            default: s = -1;
        endcase
    end
endtask

initial begin
    clk = 1'b0;
    errors = 0;
    midnight = 1'b0;
    c_reset = 1'b1;
    c_en = 1'b0;
    c_clr = 1'b0;
    //$dumpfile("traffic_light.vcd");
    //$dumpvars(0, traffic_light_tb);
    $fsdbDumpfile("tb.fsdb");
    $fsdbDumpvars(0, traffic_light_tb);
    $display("\nStarting test for traffic light");
    $display(" Time(ns) | Cycle  | MIDN | Expected | Actual | Lights | A_G A_Y A_R B_G B_Y B_R | Check");
    $display("--------------------------------------------------------------------------------------------");

    // -------------------------------
    // Verify traffic_light timing
    // -------------------------------
    t_reset = 1'b1;
    repeat (2) @(posedge clk);
    t_reset = 1'b0;

    phase = 0;
    phase_cycle = 0;

    // Normal mode: run through all normal states twice
    for (i = 0; i < 44; i = i + 1) begin
        @(negedge clk);
        decode_actual_phase(actual_phase);
        if (actual_phase == phase) begin
            $display("%9d | %6d |  %1b   | S%7d | S%5d | %6b |  %1b   %1b   %1b   %1b   %1b   %1b  | %5s",
                     $time, i, midnight, phase, actual_phase, {A_G, A_Y, A_R, B_G, B_Y, B_R},
                     A_G, A_Y, A_R, B_G, B_Y, B_R, "PASS");
        end else begin
            $display("%9d | %6d |  %1b   | S%7d | S%5d | %6b |  %1b   %1b   %1b   %1b   %1b   %1b  | %5s",
                     $time, i, midnight, phase, actual_phase, {A_G, A_Y, A_R, B_G, B_Y, B_R},
                     A_G, A_Y, A_R, B_G, B_Y, B_R, "FAIL");
        end
        expect_lights(phase);

        phase_cycle = phase_cycle + 1;
        case (phase)
            0, 3: if (phase_cycle == 8) begin phase = phase + 1; phase_cycle = 0; end
            1, 2: if (phase_cycle == 2) begin phase = phase + 1; phase_cycle = 0; end
            4: if (phase_cycle == 2) begin phase = 0; phase_cycle = 0; end
        endcase
    end

    // Midnight flashing mode: 6 flashes
    midnight = 1'b1;
    phase = 6;
    phase_cycle = 0;
    for (i = 0; i < 6; i = i + 1) begin
        @(negedge clk);
        decode_actual_phase(actual_phase);
        if (actual_phase == phase) begin
            $display("%9d | MIDN%2d |  %1b   | S%7d | S%5d | %6b |  %1b   %1b   %1b   %1b   %1b   %1b  | %5s",
                     $time, i, midnight, phase, actual_phase, {A_G, A_Y, A_R, B_G, B_Y, B_R},
                     A_G, A_Y, A_R, B_G, B_Y, B_R, "PASS");
        end else begin
            $display("%9d | MIDN%2d |  %1b   | S%7d | S%5d | %6b |  %1b   %1b   %1b   %1b   %1b   %1b  | %5s",
                     $time, i, midnight, phase, actual_phase, {A_G, A_Y, A_R, B_G, B_Y, B_R},
                     A_G, A_Y, A_R, B_G, B_Y, B_R, "FAIL");
        end
        phase_cycle = phase_cycle + 1;
        expect_lights(phase);
    end

    // Back to normal mode: one full cycle
    midnight = 1'b0;
    phase = 0;
    phase_cycle = 0;
    for (i = 0; i < 22; i = i + 1) begin
        @(negedge clk);
        decode_actual_phase(actual_phase);
        if (actual_phase == phase) begin
            $display("%9d | NORM%2d |  %1b   | S%7d | S%5d | %6b |  %1b   %1b   %1b   %1b   %1b   %1b  | %5s",
                     $time, i, midnight, phase, actual_phase, {A_G, A_Y, A_R, B_G, B_Y, B_R},
                     A_G, A_Y, A_R, B_G, B_Y, B_R, "PASS");
        end else begin
            $display("%9d | NORM%2d |  %1b   | S%7d | S%5d | %6b |  %1b   %1b   %1b   %1b   %1b   %1b  | %5s",
                     $time, i, midnight, phase, actual_phase, {A_G, A_Y, A_R, B_G, B_Y, B_R},
                     A_G, A_Y, A_R, B_G, B_Y, B_R, "FAIL");
        end
        expect_lights(phase);

        phase_cycle = phase_cycle + 1;
        case (phase)
            0, 3: if (phase_cycle == 8) begin phase = phase + 1; phase_cycle = 0; end
            1, 2: if (phase_cycle == 2) begin phase = phase + 1; phase_cycle = 0; end
            4: if (phase_cycle == 2) begin phase = 0; phase_cycle = 0; end
        endcase
    end

    // Midnight flashing mode again: 6 flashes
    midnight = 1'b1;
    phase = 6;
    phase_cycle = 0;
    for (i = 0; i < 6; i = i + 1) begin
        @(negedge clk);
        decode_actual_phase(actual_phase);
        if (actual_phase == phase) begin
            $display("%9d | MIDN%2d |  %1b   | S%7d | S%5d | %6b |  %1b   %1b   %1b   %1b   %1b   %1b  | %5s",
                     $time, i, midnight, phase, actual_phase, {A_G, A_Y, A_R, B_G, B_Y, B_R},
                     A_G, A_Y, A_R, B_G, B_Y, B_R, "PASS");
        end else begin
            $display("%9d | MIDN%2d |  %1b   | S%7d | S%5d | %6b |  %1b   %1b   %1b   %1b   %1b   %1b  | %5s",
                     $time, i, midnight, phase, actual_phase, {A_G, A_Y, A_R, B_G, B_Y, B_R},
                     A_G, A_Y, A_R, B_G, B_Y, B_R, "FAIL");
        end
        phase_cycle = phase_cycle + 1;
        expect_lights(phase);
    end

    // Explicit reset test during operation
    // Keep midnight high to verify reset forces normal S0 output anyway.
    midnight = 1'b1;
    t_reset = 1'b1;
    #1;
    decode_actual_phase(actual_phase);
    if (actual_phase == 0) begin
        $display("%9d | RESET  |  %1b   | S%7d | S%5d | %6b |  %1b   %1b   %1b   %1b   %1b   %1b  | %5s",
                 $time, midnight, 0, actual_phase, {A_G, A_Y, A_R, B_G, B_Y, B_R},
                 A_G, A_Y, A_R, B_G, B_Y, B_R, "PASS");
    end else begin
        $display("%9d | RESET  |  %1b   | S%7d | S%5d | %6b |  %1b   %1b   %1b   %1b   %1b   %1b  | %5s",
                 $time, midnight, 0, actual_phase, {A_G, A_Y, A_R, B_G, B_Y, B_R},
                 A_G, A_Y, A_R, B_G, B_Y, B_R, "FAIL");
        errors = errors + 1;
    end
    expect_lights(0);

    // Release reset and verify restart from S0.
    t_reset = 1'b0;
    midnight = 1'b0;
    phase = 0;
    phase_cycle = 0;
    @(negedge clk);
    decode_actual_phase(actual_phase);
    if (actual_phase != 0) begin
        $display("[TRAFFIC][FAIL] t=%0t reset release expected S0 got S%0d", $time, actual_phase);
        errors = errors + 1;
    end
    expect_lights(0);

    // -------------------------------
    // Verify synchronous_counter individually
    // -------------------------------
    $display("\nStarting test for syncronous counter");
    $display(" Time(ns) | Step   | RST EN CLR | Expected | Actual | Check");
    $display("---------------------------------------------------------------");

    c_reset = 1'b1; c_en = 1'b0; c_clr = 1'b0;
    @(negedge clk);
    expected_c_count = 3'd0;
    if (c_count !== expected_c_count) begin
        $display("%9d | RESET  |  %1b   %1b   %1b  |      %3b |    %3b | %5s", $time, c_reset, c_en, c_clr, expected_c_count, c_count, "FAIL");
        errors = errors + 1;
    end else begin
        $display("%9d | RESET  |  %1b   %1b   %1b  |      %3b |    %3b | %5s", $time, c_reset, c_en, c_clr, expected_c_count, c_count, "PASS");
    end

    c_reset = 1'b0; c_en = 1'b1; c_clr = 1'b0;
    for (i = 1; i <= 8; i = i + 1) begin
        @(negedge clk);
        expected_c_count = (i == 8) ? 3'd0 : i[2:0];
        if (c_count !== expected_c_count) begin
            $display("%9d | COUNT%2d|  %1b   %1b   %1b  |      %3b |    %3b | %5s", $time, i, c_reset, c_en, c_clr, expected_c_count, c_count, "FAIL");
            errors = errors + 1;
        end else begin
            $display("%9d | COUNT%2d|  %1b   %1b   %1b  |      %3b |    %3b | %5s", $time, i, c_reset, c_en, c_clr, expected_c_count, c_count, "PASS");
        end
    end

    c_clr = 1'b1; c_en = 1'b1; // Test clear overrides enable
    @(negedge clk);
    expected_c_count = 3'd0;
    if (c_count !== expected_c_count) begin
        $display("%9d | CLEAR  |  %1b   %1b   %1b  |      %3b |    %3b | %5s", $time, c_reset, c_en, c_clr, expected_c_count, c_count, "FAIL");
        errors = errors + 1;
    end else begin
        $display("%9d | CLEAR  |  %1b   %1b   %1b  |      %3b |    %3b | %5s", $time, c_reset, c_en, c_clr, expected_c_count, c_count, "PASS");
    end

    c_clr = 1'b0; c_en = 1'b0; // Test hold (no enable)
    @(negedge clk);
    expected_c_count = 3'd0;
    if (c_count !== expected_c_count) begin
        $display("%9d | HOLD   |  %1b   %1b   %1b  |      %3b |    %3b | %5s", $time, c_reset, c_en, c_clr, expected_c_count, c_count, "FAIL");
        errors = errors + 1;
    end else begin
        $display("%9d | HOLD   |  %1b   %1b   %1b  |      %3b |    %3b | %5s", $time, c_reset, c_en, c_clr, expected_c_count, c_count, "PASS");
    end

    if (errors == 0) begin
        $display("[PASS] All tests passed.");
    end else begin
        $display("[FAIL] Total errors: %0d", errors);
    end

    $finish;
end

endmodule



//coded by ChatGPT codex
