`timescale 1ns / 1ns
`include "debounce.v"
`include "div.v"

module top(input clk_i, btnl_i, btnr_i, btnu_i, btnc_i);
    wire l, r, u;
    // L - ustawianie godzin
    // R - ustawianie minut
    // U - test 1000x
    // C - reset
    debounce #(50) l_db(clk_i, rst_i, btnl_i, l);
    debounce #(50) r_db(clk_i, rst_i, btnr_i, r);
    debounce #(50) u_db(clk_i, rst_i, btnu_i, u);

    wire clk_1s, clk_main;

    div #(1000) divider(clk_i, rst_i, clk_1s);

    assign clk_main = u ? clk_i : clk_1s;

    reg [5:0] h_val, m_val, s_val;

    always @(posedge rst_i) begin
        if(rst_i) begin
            h_val <= 0;
            m_val <= 0;
            s_val <= 0;
        end
    end

    always @(posedge clk_main) begin
        $display(h_val, " ", m_val, " ", s_val);

        s_val = s_val + 1;

        if(s_val >= 6'd59) begin
            s_val <= 0;
            m_val <= m_val + 1;
        end

        if(m_val >= 6'd59) begin
            m_val <= 0;
            h_val <= h_val + 1;
        end

        if(h_val >= 23) begin
            h_val <= 0;
            m_val <= 0;
            s_val <= 0;
        end
    end

    always @(posedge clk_i) begin
        if(l) h_val <= h_val + 1;
        if(r) m_val <= m_val + 1;
    end

endmodule