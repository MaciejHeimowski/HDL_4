`timescale 1ns / 1ns

module debounce #(parameter DEL = 50) (input clk_i, rst_i, btn_i, output btn_o);
    integer counter;

    reg btn_state;

    assign btn_o = btn_state;

    always @(posedge clk_i, posedge rst_i) begin
        if(rst_i) begin
            counter <= 0;
            btn_state <= 0;
        end
        else if(clk_i && (!btn_state) && btn_i) begin
            btn_state <= 1;
        end
        else if(clk_i) begin
            if(btn_state && counter < DEL) begin
                counter <= counter + 1;
            end
            else begin
                counter <= 0;
                btn_state <= 0;
            end
        end
    end

endmodule