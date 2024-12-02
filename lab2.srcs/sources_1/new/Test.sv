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
    reg clk;
    reg rst;
    reg valid_read;
    reg [3:0] addr;
    
    reg valid_write1;
    reg [7:0] value1;
    reg valid_write2;
    reg [7:0] value2;
    reg valid_write3;
    reg [7:0] value3;
    reg valid_write4;
    reg [7:0] value4;

    wire ready_data;
    wire [7:0] data_out;
    wire [3:0] free_space;

    SortingBuffer buffer(
        .clk(clk),
        .rst(rst),
        .valid_read(valid_read),
        .addr(addr),
        
        .valid_write1(valid_write1),
        .value1(value1),
        .valid_write2(valid_write2),
        .value2(value2),
        .valid_write3(valid_write3),
        .value3(value3),
        .valid_write4(valid_write4),
        .value4(value4),

        .ready_data(ready_data),
        .data_out(data_out),
        .free_space(free_space)
    );

    initial begin
        clk = 0;
        valid_read = 0;
        valid_write1 = 0;
        valid_write2 = 0;
        valid_write3 = 0;
        valid_write4 = 0;
        forever #5 clk = ~clk;
    end

    initial begin 
        rst = 1;
        #10;
        rst = 0;
        valid_write1 = 1;
        value1 = 3;
        valid_write2 = 1;
        value2 = 12;
        #10
        valid_write1 = 0;
        valid_write2 = 0;
        #10;
        valid_read = 1;
        addr = 0;
        #10;
        addr = 1;
        #10;
        addr = 0;
        #10;
        valid_read = 0;
        #10;
    end

endmodule
