`timescale 1ns / 1ps
module mult_long #(parameter WIDTH = 16, parameter L = 4, parameter INT_DIGITS = 2, parameter MAX = 10000)(
    input [L-1:0][WIDTH-1:0] a,
    input [L-1:0][WIDTH-1:0] b,
    input ck,
    input rst,
    output logic finish,
    output logic [L-1:0][WIDTH-1:0] c
);    
    logic [6:0]statei;
    logic [6:0]statej;
    logic [2*L-1:0][WIDTH-1:0] q;
    logic [2*WIDTH-1:0] tmp_res;
    logic [WIDTH-1:0] garbage;
    logic [WIDTH-1:0] fixed_zero;
    always @(posedge ck) begin
        if(rst) begin
            statei <= 0;
            statej <= 0;
            finish <= 0;
            fixed_zero <= 0;
            q <= 0;
        end 
        if (!rst && !finish) begin
            if (statei == 0 && statej == 0) begin
                statei <= 1;
                statej <=1;
            end else if (statei >= L + 1) begin
                //state <= 0;
                finish <= 1;
            end else begin
                if (statej >= L + 1) begin
                    statej <= 1;
                    statei <= statei + 1;
                end else begin
                    tmp_res = {fixed_zero, a[statej - 1]} * {fixed_zero, b[statei - 1]};
                    tmp_res = tmp_res + {fixed_zero, q[statej + statei - 2]};
                    if (tmp_res >= MAX) begin
                        {garbage, q[statej + statei - 1]} = {fixed_zero, q[statej + statei - 1]} + tmp_res / MAX; //dubious about how division works
                        {garbage, q[statej + statei - 2]} = tmp_res % MAX;
                        statej <= statej + 1;
                    end else begin
                        {garbage, q[statej + statei - 2]} = tmp_res;
                        statej <= statej + 1;
                    end
                end
            end
        end
    end
    generate
        genvar i;
        for (i = L - INT_DIGITS; i < 2 * L - INT_DIGITS; i = i + 1) begin:FOR3
            assign c[i - L + INT_DIGITS] = q[i];
        end
    endgenerate

endmodule
