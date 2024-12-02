`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 16:16:37
// Design Name: 
// Module Name: SortingBlock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//  Данный блок сортирует два числа
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SortingBlock(input wire[7:0] inputA, input wire[7:0] inputB, output wire[7:0] outputA, output wire[7:0] outputB);
    assign outputA = inputA > inputB ? inputA : inputB;
    assign outputB = inputA > inputB ? inputB : inputA;
endmodule
