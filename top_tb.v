`timescale 1ns / 1ns
`include "top.v"

module top_tb;
    reg clk_i, rst_i;
    reg btnl_i, btnr_i, btnu_i;

    wire [7:0] led7_seg_o, led7_an_o;

    top #(100) rtc(clk_i, btnl_i, btnr_i, btnu_i, rst_i, led7_seg_o, led7_an_o);

    initial begin
        $dumpfile("top.vcd");
        $dumpvars(0, clk_i, btnl_i, btnr_i, btnu_i, rst_i, led7_seg_o, led7_an_o);

        #0 rst_i = 0;
        #0 clk_i = 0;
        #0 btnl_i = 0;
        #0 btnr_i = 0;
        #0 btnu_i = 0;

        #1 rst_i = 1;
        #1 rst_i = 0;

        #1000 btnr_i = 1;
        #1010 btnr_i = 0;

        #2000 btnl_i = 1;
        #2010 btnl_i = 0;

        #3000 btnu_i = 1;
        #3010 btnu_i = 0;

        #100000 $finish;
    end

    always #1 clk_i <= ~clk_i;
endmodule