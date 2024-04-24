//`timescale 1ns / 1ps
module hexEncode(
  input [3:0] bin, 
  output [7:0] hex
);
    assign hex =
      (bin == 4'h0) ? 'b11000000 :
      (bin == 4'h1) ? 'b11111001 :
      (bin == 4'h2) ? 'b10100100 :
      (bin == 4'h3) ? 'b10110000 :
      (bin == 4'h4) ? 'b10011001 :
      (bin == 4'h5) ? 'b10010010 :
      (bin == 4'h6) ? 'b10000010 :
      (bin == 4'h7) ? 'b11111000 :
      (bin == 4'h8) ? 'b10000000 :
      (bin == 4'h9) ? 'b10010000 :
      (bin == 4'hA) ? 'b10001000 :
      (bin == 4'hB) ? 'b10000011 :
      (bin == 4'hC) ? 'b11000110 :
      (bin == 4'hD) ? 'b10100001 :
      (bin == 4'hE) ? 'b10000110 :
      (bin == 4'hF) ? 'b10001110 :
        			'b11111111;
endmodule
module sw(
        input [15:0] sw
        ,output [7:0] D1_seg
        ,output [3:0] D1_a
    );
    assign D1_a = 'b1110;
    hexEncode h1( sw[ 3: 0] , D1_seg );
endmodule

//module sw(
//        input [15:0] sw,
////        input [3:0] btn,
//        input mclk,
//        output [7:0] D0_seg, D1_seg,
//        output [3:0] D0_a, D1_a
//    );
//    reg [7:0] selection = 8'b11111110;
//    reg [9:0] number = 0;
//    reg [24:0] counter = 0;
//    always @(posedge mclk) begin
//        if (counter == 100000000/10000) begin
//            selection = selection << 1;
//            number = number + 1;
//            counter <= 0;
//        end
//    end
//    assign D1_a = selection[3:0];
//    assign D0_a = selection[7:4];
////    wire [7:0] segs;
//    sevenseg_encoder s1(number[4:0],D0_seg);
//    sevenseg_encoder s2(number[9:5],D1_seg);

////    assign D0_seg=segs;
////    assign D1_seg=segs;
//endmodule

//module sw(
//        input mclk,
//        output [7:0] D0_seg, D1_seg,
//        output [3:0] D0_a, D1_a
//    );
//    assign D1_a = 'b1110;
//    assign D0_a = 'b1110;
//    reg [7:0] sw = 0;
//    reg [24:0] counter = 0; // 25 million cycles for 0.25 seconds
//    always @(posedge mclk) begin
//        counter <= counter + 1;
//        if (counter == 25000000) begin // Reached 0.25 second
//            sw = sw+1;
//            counter <= 0; // Reset counter
//        end
//    end
//    sevenseg_encoder s0( sw % 10 , D1_seg );
//    sevenseg_encoder s1( sw / 10 , D0_seg );
//endmodule



