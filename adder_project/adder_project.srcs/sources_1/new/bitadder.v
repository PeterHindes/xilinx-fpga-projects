`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2024 09:15:06 PM
// Design Name: 
// Module Name: bitadder
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


module bitadder(
    output wire [15:0] led
    );
    //assign ledleds_4bits_tri_o[0] = btns_4bits_tri_i[0]^btns_4bits_tri_i[1]^btns_4bits_tri_i[2];
    //assign ledleds_4bits_tri_o[1] = (btns_4bits_tri_i[0]&btns_4bits_tri_i[1])|(btns_4bits_tri_i[0]&btns_4bits_tri_i[2])|(btns_4bits_tri_i[1]&btns_4bits_tri_i[2]);
    assign led[0] = 1;
endmodule
