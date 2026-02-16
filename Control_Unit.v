/*
    Control unit made by liquetxnx on 2026/2/1

*/

`include "defines.v"

module Control_Unit(
    input wire [6:0] opcode,

    output reg a_sel,
    output reg b_sel,
    output reg [1:0] alu_op,
    output reg [1:0] pc_op,
    output reg regwrite,
    output reg memwrite,
    output reg [1:0] memtoreg, 
    output reg [2:0] immsrc,

    //forwarding signal
    output reg uses_rs1,
    output reg uses_rs2

);



always @(*) begin

    //default : 이거 default 구문 안썼을 때 랫치 생기는지 확인해봐야함. 나중에 vivado schmatic 에서 확인 ㄱㄱ
    a_sel=0; b_sel=0; alu_op=2'b00; pc_op =2'b00; regwrite= 0; memwrite=0; memtoreg = 2'b00; immsrc = 3'b000;
    uses_rs1=0; uses_rs2=0;
    case(opcode)

    `R_type: begin
        alu_op=2'b10; regwrite= 1; immsrc = 3'b101; uses_rs1=1; uses_rs2=1;
    end

    `I_type: begin
        b_sel=1; alu_op=2'b11;regwrite= 1; immsrc = 3'b000; uses_rs1=1;
    end

    `IL_type: begin
        b_sel=1; regwrite= 1; memtoreg = 2'b01; uses_rs1=1;
    end

    `S_type: begin
        b_sel=1; memwrite=1; immsrc = 3'b001; uses_rs1=1;
    end
        
    `B_type:begin
        alu_op=2'b01; pc_op =2'b01; immsrc = 3'b010;
    end

    `U_type:begin
        regwrite= 1; memtoreg = 2'b10; immsrc = 3'b100;
    end

    `AUI_type : begin
        a_sel=1; b_sel=1; regwrite= 1; immsrc = 3'b100;
    end

    `J_type : begin
        pc_op =2'b10; regwrite= 1; memtoreg = 2'b11; immsrc = 3'b011;
    end

    `JALR : begin
        b_sel=1; pc_op =2'b11; regwrite= 1; memtoreg = 2'b11; uses_rs1=1;
    end

    endcase

end

endmodule