`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 17:12:14
// Design Name: 
// Module Name: Sorting20Line
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


module Sorting20Line(
    input wire [7:0] inputs [0:19], 
    output wire [7:0] outputs [0:19]);
wire [7:0] common[0:19];

generate
    genvar i;
    for(i = 0; i < 10; i = i + 1) begin
        SortingBlock i_sortingBlock(.inputA(inputs[2*i]), .inputB(inputs[2*i + 1]), .outputA(common[2*i]), .outputB(common[2*i + 1]));
    end
endgenerate
generate
    genvar j;
    for(j = 1; j < 10; j = j + 1) begin
        SortingBlock j_sortingBlock(.inputA(common[2*j - 1]), .inputB(common[2*j]), .outputA(outputs[2*j - 1]), .outputB(outputs[2*j]));
    end
endgenerate
assign outputs[0] = common[0];
assign outputs[19] = common[19];
endmodule
