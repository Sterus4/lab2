`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 16:44:35
// Design Name: 
// Module Name: Test
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


module Test();
    reg [7:0] inputs1 [0:19];
    wire [7:0] outputs1 [0:19];
    Sorting20Full mySorting20Line(.inputs(inputs1), .outputs(outputs1));
    
    integer i;
    integer j;
    initial begin
        integer j;
        for(j = 0; j < 20; j = j + 1) begin
            integer i;
            for(i = 0; i < 20; i = i + 1) begin
                inputs1[i] = i + $urandom%10;   
            end
            #10;
        end
    end
endmodule
