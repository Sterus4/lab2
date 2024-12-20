`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 18:54:36
// Design Name: 
// Module Name: Sorting20Full
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


module Sorting20Full(
    input wire clk,
    input wire [7:0] inputs [0:19], 
    output wire [7:0] outputs [0:19]);
    reg [7:0] saves[0:19];
    wire [7:0] common1[0:19];
    wire [7:0] common2[0:19];
    wire [7:0] common3[0:19];
    wire [7:0] common4[0:19];
    wire [7:0] common5[0:19];
    wire [7:0] common6[0:19];
    wire [7:0] common7[0:19];
    wire [7:0] common8[0:19];
    wire [7:0] common9[0:19];
    
    always @(posedge clk) begin
        //TODO maybe we should iterate
        saves <= common5;
    end

    Sorting20Line s1(inputs, common1);
    Sorting20Line s2(common1, common2);
    Sorting20Line s3(common2, common3);
    Sorting20Line s4(common3, common4);
    Sorting20Line s5(common4, common5);

    Sorting20Line s6(saves, common6);
    Sorting20Line s7(common6, common7);
    Sorting20Line s8(common7, common8);
    Sorting20Line s9(common8, common9);
    Sorting20Line s10(common9, outputs);

endmodule
