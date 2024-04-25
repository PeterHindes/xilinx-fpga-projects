module main(
         input [3:0] btn
        ,input [15:0] sw
        ,output [15:0] led
    );
    reg [15:0] value = 0;
    always @(posedge btn[0])
    begin
        value = value >> 1;
        value[15] = sw[15];
    end
    assign led = value;
endmodule
