module Clock_divider(
         input clock_in
        ,output reg clock_out1
        ,output reg clock_out2
    );

    reg[27:0] counter=28'd0;
    //parameter DIVISOR = 'd100000000;
    parameter DIVISOR = 'd1000;
    parameter PWMI = 20;
    parameter OFFSETI = 4;
    
    // The frequency of the output clk_out
    //  = The frequency of the input clk_in divided by DIVISOR
    // For example: Fclk_in = 50Mhz, if you want to get 1Hz signal to blink LEDs
    // You will modify the DIVISOR parameter value to 28'd50.000.000
    // Then the frequency of the output clk_out = 50Mhz/50.000.000 = 1Hz
    always @(posedge clock_in)
    begin
     counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1))
      counter <= 28'd0;

     clock_out1 <= (counter<DIVISOR/PWMI)?1'b1:1'b0;
     clock_out2 <= (counter-DIVISOR/PWMI-DIVISOR/OFFSETI<DIVISOR/PWMI)?1'b1:1'b0;
//-DIVISOR/OFFSETI
    end
endmodule

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

module negate(input [3:0] in, output [3:0] out);

    assign out = ~(in)+1 ;

endmodule

module demo(
         input [15:0] sw
        ,input mclk
        //,output [7:0] D0_seg
        //,output [3:0] D0_a
        ,output [7:0] D1_seg
        ,output [3:0] D1_a
    );
    
    wire [3:0] swnum_neg;
    
    negate n (sw[3:0], swnum_neg);
    
    wire hclk, gclk;
    Clock_divider cd(mclk,hclk,gclk);
    
//    assign D0_a = hclk ? 'b1110 : 'b1111;
    assign D1_a = hclk ? 'b1110 :
                  gclk ? 'b1101 :
                         'b1111 ;
//    assign D1_a = 'b1110;
    
    hexEncode h1(sw[3] ?  swnum_neg : sw[3:0] , d1num);
    
    assign d1sym = sw[3] ? 'b10111111 : 'b11111111;

    wire [7:0] d1num;
    wire [7:0] d1sym;
    
    
    assign D1_seg =
    (hclk?d1num:'b11111111) &
    (gclk?d1sym:'b11111111);
    
endmodule