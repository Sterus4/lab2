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
    output reg [4:0] free_space,
    output reg is_locked
    );

    reg lock;
    assign is_locked = lock;
    reg [7:0] mem [19:0]; // Основная памать
    wire [7:0] outputs[19:0];

    reg [4:0] current_count;
    wire [2:0] count_of_queries;
    Sorting20Full mainSorting(.inputs(mem), .outputs(outputs), .clk(clk));
    integer i;
    integer j;

    assign count_of_queries = valid_write1 + valid_write2 + valid_write3 + valid_write4;
    assign free_space = 16 - current_count;

    initial begin
        current_count = 0;
        ready_data = 0;
        lock <= 0;
        for(i = 0; i < 20; i = i + 1) begin
            mem[i] <= -1;
        end
    end

    always @(posedge clk or posedge rst) begin

        if (lock == 1) begin
            lock <= 0;
        end else begin     
            if (rst) begin 
                current_count <= 0;
                ready_data <= 0;
                lock <= 1;
                for(j = 0; j < 20; j = j + 1) begin
                    mem[j] = -1;
                end
            end else begin
                if (valid_read && addr < current_count || (valid_write1 || valid_write2 || valid_write3 || valid_write4) && count_of_queries <= free_space) begin
                    lock <= 1;
                end

                if (count_of_queries <= free_space) begin
                    // Не учитывает считывание
                    if(!valid_read || addr >= current_count) begin 
                        current_count <= current_count + count_of_queries;
                    end
                    if (valid_write1) begin
                        mem[19] <= value1;
                    end else begin
                        mem[19] <= -1;
                    end
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
                end else begin 
                    mem[19] <= -1;
                    mem[18] <= -1;
                    mem[17] <= -1;
                    mem[16] <= -1;
                    //mem[19:16] <= -11;
                end
                // Проверки на считывание
                if (valid_read && addr < current_count) begin
                    // Действительно считываем значение (оно есть и valid_read установлен)
                    for(i = 0; i < 16; i = i + 1) begin
                        if (i == addr) begin
                            mem[i] <= -1;
                        end else begin
                            mem[i] <= outputs[i];
                        end
                    end
                    if(count_of_queries <= free_space) begin
                        current_count <= current_count + count_of_queries - 1;    
                    end else begin
                        current_count <= current_count - 1;
                    end
                    data_out <= outputs[addr];
                    ready_data <= 1;
                end else begin
                    ready_data <= 0;
                    mem[15:0] <= outputs[15:0];
                end 
            end
        end
    end

endmodule
