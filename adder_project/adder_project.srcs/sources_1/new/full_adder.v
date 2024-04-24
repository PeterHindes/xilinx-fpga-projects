`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2024 08:42:32 PM
// Design Name: 
// Module Name: full_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module full_adder(
    input wire [3:0] btn,
    output wire [3:0] led
    );
    assign led[0] = btn[0]^btn[1]^btn[2];
    assign led[1] = (btn[0]&btn[1])|(btn[0]&btn[2])|(btn[1]&btn[2]);
endmodule
