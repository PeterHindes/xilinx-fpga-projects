module Clock_divider(
         input clock_in
        ,output reg clock_out
    );

    reg[27:0] counter=28'd0;
    parameter DIVISOR = 'd100000000;
    parameter PWMI = 2;
    
    always @(posedge clock_in)
    begin
     counter <= counter + 28'd1;
     if(counter>=(DIVISOR-1))
      counter <= 28'd0;

     clock_out <= (counter<DIVISOR/PWMI)?1'b1:1'b0;
    end
endmodule


module clkled(
     input mclk
    ,output [15:0] led
);
    Clock_divider c(mclk, led[0]);
endmodule
