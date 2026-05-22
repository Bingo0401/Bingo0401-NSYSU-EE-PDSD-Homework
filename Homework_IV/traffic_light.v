// road A_Road B_Road 
// light G Y R

// S    A    B    Time    SGD    Midnight
// -------------------------------------
// S0   G    R    8
// S1   Y    R    2
// S2   R    R    2
// S3   R    G    8
// S4   R    Y    2
// S5   Reserved
// S6   A_Y <-> B_Y  flash mode at midnight





module synchronous_counter(clk, reset, en, clr, count);
parameter WIDTH = 3;

input clk, reset, en, clr;
output reg [WIDTH-1:0] count;

always @(posedge clk) begin
    if (reset || clr) begin
        count <= {WIDTH{1'b0}};
    end else if (en) begin
        count <= count + {{(WIDTH-1){1'b0}}, 1'b1};
    end
end

endmodule





module traffic_light(clk, reset, midnight, A_G, A_Y, A_R, B_G, B_Y, B_R);

input clk, reset, midnight;
output reg A_G, A_Y, A_R, B_G, B_Y, B_R;

reg [2:0] state;
reg [2:0] next_state;
reg counter_en;
reg counter_clr;
wire [2:0] timer_count;

localparam S0 = 3'b000;
localparam S1 = 3'b001;
localparam S2 = 3'b010;
localparam S3 = 3'b011;
localparam S4 = 3'b100;
localparam S5 = 3'b101;
localparam S6 = 3'b110;

synchronous_counter #(.WIDTH(3)) u_timer (
    .clk(clk),
    .reset(reset),
    .en(counter_en),
    .clr(counter_clr),
    .count(timer_count)
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S0;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    counter_en = 1'b1;
    counter_clr = 1'b0;

    case (state)
            S0: begin
                if (midnight) begin
                    next_state = S6;
                    counter_clr = 1'b1;
                end else if (timer_count == 3'd7) begin
                    next_state = S1;
                    counter_clr = 1'b1;
                end
            end
            S1: begin
                if (midnight) begin
                    next_state = S6;
                    counter_clr = 1'b1;
                end else if (timer_count == 3'd1) begin
                    next_state = S2;
                    counter_clr = 1'b1;
                end
            end
            S2: begin
                if (midnight) begin
                    next_state = S6;
                    counter_clr = 1'b1;
                end else if (timer_count == 3'd1) begin
                    next_state = S3;
                    counter_clr = 1'b1;
                end
            end
            S3: begin
                if (midnight) begin
                    next_state = S6;
                    counter_clr = 1'b1;
                end else if (timer_count == 3'd7) begin
                    next_state = S4;
                    counter_clr = 1'b1;
                end
            end
            S4: begin
                if (midnight) begin
                    next_state = S6;
                    counter_clr = 1'b1;
                end else if (timer_count == 3'd1) begin
                    next_state = S0;
                    counter_clr = 1'b1;
                end
            end
            S5: begin
                next_state = S0;
                counter_clr = 1'b1;
            end
            S6: begin
                if (!midnight) begin
                    next_state = S0;
                    counter_clr = 1'b1;
                end else begin
                    next_state = S6;
                end
            end
            default: begin
                next_state = S0;
                counter_en = 1'b0;
                counter_clr = 1'b1;
            end
    endcase
end

always @(*) begin
    A_G = 1'b0;
    A_Y = 1'b0;
    A_R = 1'b1;
    B_G = 1'b0;
    B_Y = 1'b0;
    B_R = 1'b1;

    case (state)
        S0: begin
            A_G = 1'b1;
            A_R = 1'b0;
        end
        S1: begin
            A_Y = 1'b1;
            A_R = 1'b0;
        end
        S2: begin
        end
        S3: begin
            B_G = 1'b1;
            B_R = 1'b0;
        end
        S4: begin
            B_Y = 1'b1;
            B_R = 1'b0;
        end
        S6: begin
            if (timer_count[0] == 1'b0) begin
                A_Y = 1'b1;
                A_R = 1'b0;
                B_R = 1'b0;
            end else begin
                B_Y = 1'b1;
                A_R = 1'b0;
                B_R = 1'b0;
            end
        end
        default: begin
        end
    endcase
end

endmodule

// coded by Bingo
