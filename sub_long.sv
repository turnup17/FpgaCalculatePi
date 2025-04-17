`timescale 1ns / 1ps
module sub_long #(parameter WIDTH = 16, parameter L = 4, parameter INT_DIGITS = 2, parameter MAX = 10000)(
    input [L-1:0][WIDTH-1:0] a,
    input [L-1:0][WIDTH-1:0] b,
    input ck,
    input rst,
    output logic finish,
    output logic [L-1:0][WIDTH-1:0] c
);    
    logic [L-1:0][WIDTH-1:0] q;
    logic [5:0]state;
    logic carry;
    always @(posedge ck) begin
        if(rst) begin
            state <= 0;
            finish <= 0;
            carry <= 0;
        end 
        if (!rst && !finish) begin
            if (state == 0) begin
                state <= 1;
            end else if (state >= L + 1) begin
                //state <= 0;
                finish <= 1;
            end else begin
                state <= state + 1;
                if (a[state - 1] >= b[state - 1] + carry) begin
                    carry <= 0;
                    q[state - 1] <= a[state - 1] - b[state - 1] - carry;
                end else begin
                    carry <= 1;
                    q[state - 1] <= a[state - 1] - b[state - 1] - carry + MAX;
                end
            end
        end
    end
    generate
        genvar i;
        for (i = 0; i < L; i = i + 1) begin:FOR2
            assign c[i] = q[i];
        end
    endgenerate

endmodule
