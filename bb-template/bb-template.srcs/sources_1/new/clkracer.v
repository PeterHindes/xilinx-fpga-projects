module Clock_divider(
         input clock_in
        ,output reg clock_out
    );

    reg[27:0] counter=28'd0;
    parameter DIVISOR = 'd100000;
    parameter PWMI = 2;
    
    always @(posedge clock_in)
    begin
     counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1))
      counter <= 28'd0;

     clock_out <= (counter<DIVISOR/PWMI)?1'b1:1'b0;
    end
endmodule


module clkracer(
     input mclk
    ,output reg [15:0] led
);
    initial led = 0;
    wire hclk;
    Clock_divider c(mclk, hclk);
    always @(posedge hclk)
    begin
        led = led + 1;
    end
endmodule
