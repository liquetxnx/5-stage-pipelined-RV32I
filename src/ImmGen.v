/*
    ImmGen made by liquetxnx on 2025/10

*/
`include "defines.v"

module ImmGen(
    input wire [31:7] instr,
    input wire [2:0] immsrc,

    output reg [31:0] imm
);


wire [31:0] imm_i = {{20{instr[31]}},instr[31:20]};
wire [31:0] imm_s = {{20{instr[31]}},instr[31:25],instr[11:7]};
wire [31:0] imm_b = {{20{instr[31]}},instr[7], instr[30:25], instr[11:8], 1'b0};
wire [31:0] imm_j = {{12{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0};
wire [31:0] imm_u = {instr[31:12],12'b0};


always @(*) begin
    case(immsrc) 
        `Imm_I : imm = imm_i;
        `Imm_S: imm = imm_s;
        `Imm_B: imm = imm_b;
        `Imm_J : imm = imm_j;
        `Imm_U : imm = imm_u;
        default : imm = 32'd0;
    endcase

end


endmodule