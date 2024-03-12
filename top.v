`timescale 1ns / 1ns
`include "debounce.v"
`include "div.v"
`include "display.v"

module top #(parameter TPS = 10) (input clk_i, input btnl_i, input btnr_i, input btnu_i,  input rst_i, output [7:0] led7_seg_o, output [7:0] led7_an_o);
    wire inc_hour, inc_minute, speedup;
    debounce #(50) l_db(clk_i, rst_i, btnl_i, inc_hour);
    debounce #(50) r_db(clk_i, rst_i, btnr_i, inc_minute);
    debounce #(50) u_db(clk_i, rst_i, btnu_i, speedup);

    reg [5:0] h_val, m_val, s_val;

    display disp(clk_i, rst_i, h_val, m_val, led7_seg_o, led7_an_o);

    integer tick_counter;

    initial $dumpvars(0, h_val, m_val, s_val);

    always @(posedge rst_i) begin
        if(rst_i) begin
            h_val <= 0;
            m_val <= 0;
            s_val <= 0;

            tick_counter <= 0;
        end
    end

    always @(posedge clk_i) begin
        if(tick_counter >= (speedup ? 1 : TPS - 1)) begin
            tick_counter <= 0;

            if(s_val >= 59) begin
                s_val <= 0;
                m_val <= m_val + 1;
            end
            else begin
                s_val <= s_val + 1;
            end

            if(m_val >= 59 && s_val >= 59) begin
                m_val <= 0;
                h_val <= h_val + 1;
            end

            if(h_val >= 23 && m_val >= 59 && s_val >= 59) begin
                h_val <= 0;
                m_val <= 0;
                s_val <= 0;
            end
        end
        else begin
            tick_counter <= tick_counter + 1;

            if(tick_counter % (TPS / 5) == 0 && btnl_i == 1) begin
                if(h_val < 23)
                    h_val <= h_val + 1;
                else
                    h_val <= 0;
            end

            if(tick_counter % (TPS / 5) == 0 && btnr_i == 1) begin
                if(m_val < 59)
                    m_val <= m_val + 1;
                else
                    m_val <= 0;
            end
        end
    end

endmodule