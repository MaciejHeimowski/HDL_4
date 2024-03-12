`timescale 1ns / 1ns

module display(input clk_i, input rst_i, input [5:0] hour_i, input [5:0] min_i, output reg [7:0] led7_seg_o, output reg [7:0] led7_an_o);
    function [7:0] seg_char;
        input [3:0] data;
        begin
            case (data)
                4'b0000 : seg_char = 8'b0000_0011;   // 0
                4'b0001 : seg_char = 8'b1001_1111;   // 1
                4'b0010 : seg_char = 8'b0010_0101;   // 2
                4'b0011 : seg_char = 8'b0000_1101;   // 3
                4'b0100 : seg_char = 8'b1001_1001;   // 4
                4'b0101 : seg_char = 8'b0100_1001;   // 5
                4'b0110 : seg_char = 8'b0100_0001;   // 6
                4'b0111 : seg_char = 8'b0001_1111;   // 7
                4'b1000 : seg_char = 8'b0000_0001;   // 8
                4'b1001 : seg_char = 8'b0000_1001;   // 9
                4'b1010 : seg_char = 8'b0001_0001;   // A
                4'b1011 : seg_char = 8'b1100_0001;   // B
                4'b1100 : seg_char = 8'b0110_0011;   // C
                4'b1101 : seg_char = 8'b1000_0101;   // D
                4'b1110 : seg_char = 8'b0110_0001;   // E
                4'b1111 : seg_char = 8'b0111_0001;   // F
                default : seg_char = 8'b1111_1111;   // *blank*
            endcase
        end
    endfunction

    reg [2:0] digit;
    
    always @(posedge clk_i, posedge rst_i) begin
        if(rst_i) begin
            digit <= 0;
            led7_seg_o <= 8'b11111111;
            led7_an_o <= 8'b11111110;
        end
        else if(clk_i) begin
            if(digit >= 7)
                digit <= 0;
            else
                digit <= digit + 1;

            led7_an_o <= ~(1 << digit);

            case(digit)
                0: led7_seg_o <= seg_char(min_i % 10);
                1: led7_seg_o <= seg_char(min_i / 10);
                2: led7_seg_o <= 8'b11111110;
                3: led7_seg_o <= seg_char(hour_i % 10);
                4: led7_seg_o <= seg_char(hour_i / 10);
                5: led7_seg_o <= 8'b11111111;
                6: led7_seg_o <= 8'b11111111;
                7: led7_seg_o <= 8'b11111111;
            endcase
        end
    end
endmodule