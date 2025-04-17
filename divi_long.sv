`timescale 1ns / 1ps
module divi_long #(parameter WIDTH = 16, parameter L = 4, parameter INT_DIGITS = 2, parameter MAX = 10000)(
    input [L-1:0][WIDTH-1:0] a,
    input [L-1:0][WIDTH-1:0] b,
    input ck,
    input rst,
    output logic finish,
    output logic [L-1:0][WIDTH-1:0] c
);    
    wire [L-1:0][WIDTH-1:0] q;
    logic [L-1:0][WIDTH-1:0] x;
    logic [L-1:0][WIDTH-1:0] next_x;
    wire [L-1:0][WIDTH-1:0] tmp1;
    wire [L-1:0][WIDTH-1:0] tmp2;
    wire [L-1:0][WIDTH-1:0] tmp3;
    wire [L-1:0][WIDTH-1:0] tmp4;
    logic [L-1:0][WIDTH-1:0] fixed_one;
    logic [L-1:0][WIDTH-1:0] test;
    logic finish1, finish2, finish3, finish4, finish5;
    logic rst1, rst2, rst3, rst4, rst5;
    logic [5:0]statei;
    logic [5:0]statej;

    mult_long #(.WIDTH(WIDTH), .L(L), .INT_DIGITS(INT_DIGITS), .MAX(MAX)) mult_long_inst_1(
        .a(b),
        .b(x),
        .ck(ck),
        .rst(rst1),
        .finish(finish1),
        .c(tmp1)
    );
    sub_long #(.WIDTH(WIDTH), .L(L), .INT_DIGITS(INT_DIGITS), .MAX(MAX)) sub_long_inst(
        .a(fixed_one),
        .b(tmp1),
        .ck(ck),
        .rst(rst2),
        .finish(finish2),
        .c(tmp2)
    );
    mult_long #(.WIDTH(WIDTH), .L(L), .INT_DIGITS(INT_DIGITS), .MAX(MAX)) mult_long_inst_2(
        .a(tmp2),
        .b(x),
        .ck(ck),
        .rst(rst3),
        .finish(finish3),
        .c(tmp3)
    );
    add_long #(.WIDTH(WIDTH), .L(L), .INT_DIGITS(INT_DIGITS), .MAX(MAX)) add_long_inst(
        .a(x),
        .b(tmp3),
        .ck(ck),
        .rst(rst4),
        .finish(finish4),
        .c(tmp4)
    );
    mult_long #(.WIDTH(WIDTH), .L(L), .INT_DIGITS(INT_DIGITS), .MAX(MAX)) mult_long_inst_3(
        .a(a),
        .b(x),
        .ck(ck),
        .rst(rst5),
        .finish(finish5),
        .c(q)
    );

    always @(posedge ck) begin
        if (rst) begin 
            integer i;
            for (i = 0; i < L; i = i + 1) begin:FOR0
                x[i] = 0;
                next_x[i] = 0;
            end
            x[L - 2 * INT_DIGITS] = 1000;
            next_x[L - 2 * INT_DIGITS] = 1000;
            for (i = 0; i < L; i = i + 1) begin:FOR1
                fixed_one[i] = 0;
            end
            fixed_one[L - INT_DIGITS] = 1;
            rst1 = 1;
            rst2 = 1;
            rst3 = 1;
            rst4 = 1;
            rst5 = 1;
            statei = 0;
            statej = 0;
            finish = 0;
        end else if (!rst && !finish) begin
            if(statei == 0 && statej == 0) begin
                statei <= 1;
                statej <= 1;
            end else if (statei >= 25) begin
                rst5 = 0;
                if (finish5) begin
                    finish <= 1;
                end
            end else begin
                if (statej >= 5) begin
                    statei <= statei + 1;
                    statej <= 1;
                end else begin
                    if (statej == 1) begin
                        rst1 = 0;
                        if (finish1) begin
                            statej <= statej + 1;
                        end
                    end else if (statej == 2) begin
                        rst2 = 0;
                        if (finish2) begin
                            statej <= statej + 1;
                        end
                    end else if (statej == 3) begin
                        rst3 = 0;
                        if (finish3) begin
                            statej <= statej + 1;
                        end
                    end else if (statej == 4) begin
                        rst4 = 0;
                        if (finish4) begin
                            statej <= statej + 1;
                            x <= tmp4;
                            rst1 <= 1;
                            rst2 <= 1;
                            rst3 <= 1;
                            rst4 <= 1;
                        end
                    end
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
