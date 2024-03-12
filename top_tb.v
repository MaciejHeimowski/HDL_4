`timescale 1ns / 1ns
`include "top.v"

module top_tb;
    reg clk_i, rst_i, btn_i;
    
    reg btnl_i, btnr_i;

    top rtc(clk_i, btnl_i, btnr_i, btnu_i, rst_i);

    initial begin
        // $dumpfile("debounce.vcd");
        // $dumpvars(0, clk_i, rst_i, btn_i);

        btnl_i = 0;
        btnr_i = 0;

        #10000 $finish;
    end

    always #1 clk_i <= ~clk_i;
endmodule