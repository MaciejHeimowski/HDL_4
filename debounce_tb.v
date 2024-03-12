`timescale 1ns / 1ns
`include "debounce.v"

module debounce_tb;
    reg clk_i, rst_i, btn_i;
    
    wire btn_o;

    debounce  #(50) uut(clk_i, rst_i, btn_i, btn_o);

    initial begin
        $dumpfile("debounce.vcd");
        $dumpvars(0, clk_i, rst_i, btn_i, btn_o);

        #0 rst_i = 0;
        #0 btn_i = 0;
        #0 clk_i = 0;

        #1 rst_i = 1;
        #1 rst_i = 0;

        #10 btn_i = 1;
        #10 btn_i = 0;
        #20 btn_i = 1;
        #5  btn_i = 0;

        #100 $finish;
    end

    always #1 clk_i <= ~clk_i;
endmodule