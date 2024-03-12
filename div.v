`timescale 1ns / 1ns

module div #(parameter NDIV = 3)(
    input clk_i,
    input rst_i,
    output reg clk_o
);

integer counter = 0;

always @(posedge clk_i, posedge rst_i) begin
    if(rst_i) begin
        counter <= 0;
        clk_o <= 0;
    end
    else if(clk_i) begin
        counter <= counter + 1;
        if(counter == NDIV/2) begin
            clk_o = 1;
        end
        else if(counter == NDIV - 1) begin
            counter <= 0;
            clk_o <= 0;    
        end
    end
end
    
endmodule