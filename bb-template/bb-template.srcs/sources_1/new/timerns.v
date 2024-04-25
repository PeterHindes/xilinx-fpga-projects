module Clock_divider(
         input clock_in
        ,output reg clock_out1
        ,output reg clock_out2
        ,output reg clock_out3
        ,output reg clock_out4
        ,output reg clock_out5
        ,output reg clock_out6
        ,output reg clock_out7
        ,output reg clock_out8
    );

    reg[27:0] counter=28'd0;
//    parameter DIVISOR = 'd100000000;
    parameter DIVISOR = 'd1000;
    parameter PWMI = 16;
    parameter OFFSETI = 16;
    
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

     clock_out1 <= (counter- 0*(DIVISOR/PWMI+DIVISOR/OFFSETI) <DIVISOR/PWMI)?1'b1:1'b0;
     clock_out2 <= (counter- 1*(DIVISOR/PWMI+DIVISOR/OFFSETI) <DIVISOR/PWMI)?1'b1:1'b0;
     clock_out3 <= (counter- 2*(DIVISOR/PWMI+DIVISOR/OFFSETI) <DIVISOR/PWMI)?1'b1:1'b0;
     clock_out4 <= (counter- 3*(DIVISOR/PWMI+DIVISOR/OFFSETI) <DIVISOR/PWMI)?1'b1:1'b0;
     clock_out5 <= (counter- 4*(DIVISOR/PWMI+DIVISOR/OFFSETI) <DIVISOR/PWMI)?1'b1:1'b0;
     clock_out6 <= (counter- 5*(DIVISOR/PWMI+DIVISOR/OFFSETI) <DIVISOR/PWMI)?1'b1:1'b0;
     clock_out7 <= (counter- 6*(DIVISOR/PWMI+DIVISOR/OFFSETI) <DIVISOR/PWMI)?1'b1:1'b0;
     clock_out8 <= (counter- 7*(DIVISOR/PWMI+DIVISOR/OFFSETI) <DIVISOR/PWMI)?1'b1:1'b0;
    end
endmodule

module Timer_counter(
         input clock_in
        ,output reg clock_out
    );

    reg[27:0] counter=28'd0;
    parameter DIVISOR = 'd10;
//    parameter DIVISOR = 'd10000000;
    parameter PWMI = 2;
    
    always @(posedge clock_in)
    begin
     counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1))
      counter <= 28'd0;

     clock_out <= (counter<DIVISOR/PWMI)?1'b1:1'b0;
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
        			  'b11111111 ;
endmodule

module timerns(
     input mclk
    
    ,output [7:0] D0_seg
    ,[3:0] D0_a
    ,[7:0] D1_seg
    ,[3:0] D1_a
);

    // Generate Clocks
    wire c0,c1,c2,c3,c4,c5,c6,c7;
    Clock_divider dut(mclk, c0,c1,c2,c3,c4,c5,c6,c7);
    wire tc;
    Timer_counter(mclk, tc);

    // The Decimal counters
    reg [31:0] disp = 0;

    // Handle Decimal Counting On timer ticks
    always @(posedge tc)
    begin
        
        disp = disp +1;
        // i = 0
        if (disp[3:0] == 10) begin
            disp[3:0] <= 0;
            disp[7:4] = disp[7:4] + 1;
        end
        
        // i = 4
        if (disp[7:4] == 10) begin
            disp[7:4] <= 0;
            disp[11:8] = disp[11:8] + 1;
        end
        
        // i = 8
        if (disp[11:8] == 10) begin
            disp[11:8] <= 0;
            disp[15:12] = disp[15:12] + 1;
        end
        
        // i = 12
        if (disp[15:12] == 10) begin
            disp[15:12] <= 0;
            disp[19:16] = disp[19:16] + 1;
        end
        
        // i = 16
        if (disp[19:16] == 10) begin
            disp[19:16] <= 0;
            disp[23:20] = disp[23:20] + 1;
        end
        
        // i = 20
        if (disp[23:20] == 10) begin
            disp[23:20] <= 0;
            disp[27:24] = disp[27:24] + 1;
        end
        
        // i = 24
        if (disp[27:24] == 10) begin
            disp[27:24] <= 0;
            disp[31:28] = disp[31:28] + 1;
        end

        // End truncate
        if (disp[31:28] == 10) begin
            disp[31:28] = 0;
        end

    end

    // Conversions to hex
    wire [7:0] s0;
    wire [7:0] s1;
    wire [7:0] s2;
    wire [7:0] s3;
    wire [7:0] s4;
    wire [7:0] s5;
    wire [7:0] s6;
    wire [7:0] s7;


    hexEncode h0 (disp[3:0]  ,s0);
    hexEncode h4 (disp[7:4]  ,s1);
    hexEncode h8 (disp[11:8] ,s2);
    hexEncode h12(disp[15:12],s3);
    hexEncode h16(disp[19:16],s4);
    hexEncode h20(disp[23:20],s5);
    hexEncode h24(disp[27:24],s6);
    hexEncode h28(disp[31:28],s7);

    // Display
    assign D1_a = {~c3,~c2,~c1,~c0};
    assign D0_a = {~c7,~c6,~c5,~c4};
    assign D1_seg = c0 ? s0 :
                    c1 ? s1 :
                    c2 ? s2 :
                    c3 ? s3 :
                         8'b11111111 ;
    assign D0_seg = c4 ? s4 :
                    c5 ? s5 :
                    c6 ? s6 :
                    c7 ? (s7 & 8'b01111111) :
                         8'b11111111 ;

endmodule
