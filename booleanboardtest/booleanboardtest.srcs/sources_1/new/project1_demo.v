//timescale 1ns / 1ps

    module project1_demo(
        input mclk,
        input [15:0] sw,
        output [15:0] led,
        output [7:0] D0_seg, D1_seg,
        output [3:0] D0_a, D1_a
    );

    reg [28:0] cnt29 = 29'd0;
    reg [15:0] led_reg;
    reg [7:0] seg_reg;

    always @(posedge mclk) cnt29 <= cnt29 + 1;

    always @(posedge cnt29[24])
    begin
        if (cnt29[28:25] == 4'b0) begin
            led_reg <= 16'hFFFE;
            seg_reg <= 8'hFE;
        end
        else begin
            seg_reg <= {seg_reg[6:0], seg_reg[7]};
            led_reg <= {led_reg[14:0], led_reg[15]};
        end
    end

    assign led = sw | led_reg;
    assign D0_a = 4'h0;
    assign D1_a = 4'h0;
    assign D0_seg = seg_reg;
    assign D1_seg = seg_reg;

    endmodule