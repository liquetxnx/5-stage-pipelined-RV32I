/*
    ALU module made by liquetxnx on 2025/10 

    10 basic command (add, sub, and , or , xor, sll, srl, sra, slt, sltu)

    Branch flag (BrEq, BrLt, BrLtU) is made on ALU 
    : because arthimetic operation is needed.

*/

`include "defines.v"
module ALU(

    input wire [31:0] a,
    input wire [31:0] b,
    input wire [3:0] alu_src,
    
    output reg [31:0] result,
    output wire BrEq, // branch 용 output. 
    output wire BrLt,
    output wire BrLtU
);


wire signed [31:0] sa = a;
wire signed [31:0] sb = b;
wire [4:0] shamt = b[4:0];


always @(*) begin
    case(alu_src)
        `ADD: result = a+b;
        `SUB: result = a-b;
        `AND: result = a&b;
        `OR : result = a|b;
        `XOR: result = a^b;
        `SLL: result = a << shamt;
        `SRL: result = a >> shamt;
        `SRA: result = sa >>> shamt;
        `SLT: result = (sa < sb);
        `SLTU:result = (a < b);
        `B_PASS:result = b;

        default: result = 32'b0;
        
    endcase
end

    wire overflow = (a[31] == b[31]) && (result[31] != a[31]);

    assign BrEq = (result==32'b0);
    assign BrLt = overflow^result[31];
    assign BrLtU = (a <b);


endmodule
