module add(
         input [3:0] btn
        ,input [15:0] sw
        ,output [15:0] led
    );
    reg [15:0] num1 = 0;
    reg [15:0] num2 = 0;
    
    assign led = num1 + num2;
    
    always @(posedge btn[0])
    begin
        num1 <= sw;
    end
    always @(posedge btn[1])
    begin
        num2 <= sw;
    end
    
endmodule
