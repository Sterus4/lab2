`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 19:32:20
// Design Name: 
// Module Name: SortingBuffer
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


module SortingBuffer(
    input wire clk,
    input wire rst,
    input wire valid_read,
    input wire [3:0] addr,
    
    input wire valid_write1,
    input wire [7:0] value1,
    input wire valid_write2,
    input wire [7:0] value2,
    input wire valid_write3,
    input wire [7:0] value3,
    input wire valid_write4,
    input wire [7:0] value4,

    output reg ready_data,
    output reg [7:0] data_out,
    output reg [3:0] free_space
    );
    reg [7:0] mem [19:0]; // Основная памать
    wire [7:0] outputs[19:0];
    reg [3:0] current_count;
    wire [1:0] count_of_queries;
    Sorting20Full mainSorting(.inputs(mem), .outputs(outputs));
    integer i;
    integer j;

    assign count_of_queries = valid_write1 + valid_write2 + valid_write3 + valid_write4;

    initial begin
        current_count = 0;
        free_space = 16;
        ready_data = 0;
        for(i = 0; i < 20; i = i + 1) begin
            mem[i] = -1;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin 
            current_count <= 0;
            free_space <= 16;
            ready_data <= 0;
            for(j = 0; j < 20; j = j + 1) begin
                mem[j] = -1;
            end
        end else begin    
            if (valid_write1) begin
                mem[19] <= value1;
            end else begin
                mem[19] <= -1;
            end
            // Выставляем все значения на свои места (пока без проверки переполнения)
            if (valid_write2) begin
                mem[18] <= value2;
            end else begin
                mem[18] <= -1;
            end
            
            if (valid_write3) begin
                mem[17] <= value3;
            end else begin
                mem[17] <= -1;
            end
            
            if (valid_write4) begin
                mem[16] <= value4;
            end else begin
                mem[16] <= -1;
            end
            // Проверки на считывание
            if (valid_read) begin
                for(i = 0; i < 16; i = i + 1) begin
                    if (i == addr)begin
                        mem[i] <= -1;
                    end else begin
                        mem[i] <= outputs[i];
                    end
                end
                data_out <= outputs[addr];
                ready_data <= 1;
            end else begin
                mem[15:0] <= outputs[15:0];
            end
        end
    end

endmodule
