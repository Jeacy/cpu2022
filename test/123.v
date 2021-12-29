module test(
    a,b,c
);
    input a;
    input b;
    output reg c;
    always @(*) begin
        c = a * b;
        
    end
endmodule

多个文件一起lint检查