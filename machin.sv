`timescale 1ns / 1ps
module machin #(parameter WIDTH = 16, parameter L = 4, parameter INT_DIGITS = 2, parameter MAX = 10000)(
    input ck,
    input rst,
    output logic finish,
    output logic [L-1:0][WIDTH-1:0] out
);    
    wire [L-1:0][WIDTH-1:0] q;
    logic [L-1:0][WIDTH-1:0] const_1;
    logic [L-1:0][WIDTH-1:0] const_2;
    logic [L-1:0][WIDTH-1:0] const_3;
    wire [L-1:0][WIDTH-1:0] next_a;
    wire [L-1:0][WIDTH-1:0] next_b;
    wire [L-1:0][WIDTH-1:0] next_c_1;
    wire [L-1:0][WIDTH-1:0] next_c_2;
    wire [L-1:0][WIDTH-1:0] next_pi_1;
    wire [L-1:0][WIDTH-1:0] next_pi_2;
    logic [L-1:0][WIDTH-1:0] a;
    logic [L-1:0][WIDTH-1:0] b;
    logic [L-1:0][WIDTH-1:0] c;
    logic [L-1:0][WIDTH-1:0] pi;
    logic finish1, finish2, finish3, finish4, finish5, finish6;
    logic rst1, rst2, rst3, rst4, rst5, rst6;
    logic [6:0]statei;
    logic [6:0]statej;

    divi_long #(.WIDTH(WIDTH), .L(L), .INT_DIGITS(INT_DIGITS), .MAX(MAX)) divi_long_inst_1(
        .a(b),
        .b(const_2),
        .ck(ck),
        .rst(rst1),
        .finish(finish1),
        .c(next_b)
    );
    divi_long #(.WIDTH(WIDTH), .L(L), .INT_DIGITS(INT_DIGITS), .MAX(MAX)) divi_long_inst_2(        
        .a(a),
        .b(const_1),
        .ck(ck),
        .rst(rst2),
        .finish(finish2),
        .c(next_a)
    );
    sub_long #(.WIDTH(WIDTH), .L(L), .INT_DIGITS(INT_DIGITS), .MAX(MAX)) sub_long_inst_1(
        .a(a),
        .b(b),
        .ck(ck),
        .rst(rst3),
        .finish(finish3),
        .c(next_c_1)
    );
    divi_long #(.WIDTH(WIDTH), .L(L), .INT_DIGITS(INT_DIGITS), .MAX(MAX)) divi_long_inst_3(
        .a(c),
        .b(const_3),
        .ck(ck),
        .rst(rst4),
        .finish(finish4),
        .c(next_c_2)
    );
    sub_long #(.WIDTH(WIDTH), .L(L), .INT_DIGITS(INT_DIGITS), .MAX(MAX)) sub_long_inst_2(
        .a(pi),
        .b(c),
        .ck(ck),
        .rst(rst5),
        .finish(finish5),
        .c(next_pi_1)
    );
    add_long #(.WIDTH(WIDTH), .L(L), .INT_DIGITS(INT_DIGITS), .MAX(MAX)) add_long_inst(
        .a(pi),
        .b(c),
        .ck(ck),
        .rst(rst6),
        .finish(finish6),
        .c(next_pi_2)
    );

    always @(posedge ck) begin
        if (rst) begin 
            integer i;
            for (i = 0; i < L; i = i + 1) begin:FOR0
                a[i] = 0;
                b[i] = 0;
                pi[i] = 0;
                const_1[i] = 0;
                const_2[i] = 0;
                const_3[i] = 0;
            end
            const_1[L - INT_DIGITS] = 25;
            const_2[L - INT_DIGITS] = 7121;
            const_2[L - INT_DIGITS + 1] = 5;
            a[L - INT_DIGITS] = 80;
            b[L - INT_DIGITS] = 956;
            rst1 = 1;
            rst2 = 1;
            rst3 = 1;
            rst4 = 1;
            rst5 = 1;
            rst6 = 1;
            statei = 0;
            statej = 0;
            finish = 0;
        end else if (!rst && !finish) begin
            if(statei == 0 && statej == 0) begin
                statei <= 1;
                statej <= 1;
            end else if (statei >= 41) begin
                finish <= 1;
            end else begin
                if (statej >= 6) begin
                    statei <= statei + 1;
                    statej <= 1;
                end else begin
                    if (statej == 1) begin
                        rst1 = 0;
                        if (finish1) begin
                            statej <= statej + 1;
                            b <= next_b;
                        end
                    end else if (statej == 2) begin
                        rst2 = 0;
                        if (finish2) begin
                            statej <= statej + 1;
                            a <= next_a;
                        end
                    end else if (statej == 3) begin
                        rst3 = 0;
                        if (finish3) begin
                            statej <= statej + 1;
                            c <= next_c_1;
                            const_3[L-INT_DIGITS] = 2 * statei - 1;
                        end
                    end else if (statej == 4) begin
                        rst4 = 0;
                        if (finish4) begin
                            statej <= statej + 1;
                            c <= next_c_2;
                        end
                    end else if (statej == 5) begin
                        if (statei % 2 == 0) begin
                            rst5 = 0;
                            if (finish5) begin
                                statej <= statej + 1;
                                pi <= next_pi_1;
                                rst1 <= 1;
                                rst2 <= 1;
                                rst3 <= 1;
                                rst4 <= 1;
                                rst5 <= 1;
                                rst6 <= 1;
                            end
                        end else begin
                            rst6 = 0;
                            if (finish6) begin
                                statej <= statej + 1;
                                pi <= next_pi_2;
                                rst1 <= 1;
                                rst2 <= 1;
                                rst3 <= 1;
                                rst4 <= 1;
                                rst5 <= 1;
                                rst6 <= 1;
                            end
                        end
                    end
                end
            end
        end
    end
    
    generate
        genvar i;
        for (i = 0; i < L; i = i + 1) begin:FOR2
            assign out[i] = pi[i];
        end
    endgenerate
endmodule
