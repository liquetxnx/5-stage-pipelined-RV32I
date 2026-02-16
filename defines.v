`ifndef DEFINES_V
`define DEFINES_V

//stack pointer
`define STACK_POINTER 32'h0000_4000

// Instruction opcode
`define R_type 7'b0110011
`define I_type 7'b0010011
`define IL_type 7'b0000011
`define S_type  7'b0100011 
`define B_type  7'b1100011 
`define U_type  7'b0110111 
`define AUI_type 7'b0010111 
`define J_type  7'b1101111 
`define JALR    7'b1100111

`define ADD  4'b0001
`define SUB  4'b0010
`define AND  4'b0011
`define OR   4'b0100
`define XOR  4'b0101
`define SLL  4'b0110 // just shift left
`define SRL  4'b0111 // just shift right
`define SRA  4'b1000 // shift right but remain original sign
`define SLT  4'b1001 // set less than
`define SLTU 4'b1010 


 //immSrc
`define Imm_I 3'b000 
`define Imm_S 3'b001
`define Imm_B 3'b010
`define Imm_J 3'b011
`define Imm_U 3'b100

//alu_ctrl
`define alu_LW_SW 2'b00
`define alu_Branch 2'b01
`define alu_R_type 2'b10
`define alu_I_type 2'b11

`endif