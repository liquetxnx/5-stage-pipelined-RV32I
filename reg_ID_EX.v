/*
    Consider to use vector because of too many variable

*/

module reg_ID_EX(

    input wire clk,
    input wire rst,
    input wire [4:0] stall,

    //from Reg_File
    input wire [31:0] id_rdata1,
    input wire [31:0] id_rdata2,
    input wire [4:0] id_rd,

    //from ImmGen
    input wire [31:0] id_imm,

    //from Control_unit
    input wire id_a_sel,
    input wire id_b_sel,
    input wire [1:0] id_alu_op,
    input wire [1:0] id_branch_flag,
    input wire id_regwrite,
    input wire id_memwrite,
    input wire [1:0] id_memtoreg,

    //from pc
    input wire [31:0] id_pc,
    input wire [31:0] id_pc_plus_4,

    //from instr
    input wire [2:0] id_funct3,
    input wire [6:0] id_funct7,

    //forwarding 
    input wire [4:0] id_rs1,
    input wire [4:0] id_rs2,
    input wire id_uses_rs1,
    input wire id_uses_rs2,

    //register data
    output reg [31:0] ex_rdata1,
    output reg [31:0] ex_rdata2,
    output reg [4:0] ex_rd,

    //imm data
    output reg [31:0] ex_imm,

    //control signal
    output reg ex_a_sel,
    output reg ex_b_sel,
    output reg [1:0] ex_alu_op,
    output reg [1:0] ex_branch_flag,
    output reg ex_regwrite,
    output reg ex_memwrite,
    output reg [1:0] ex_memtoreg,
    

   //pc
    output reg [31:0] ex_pc,
    output reg [31:0] ex_pc_plus_4,

    //branch
    output reg [6:0] ex_funct7,
    output reg [2:0] ex_funct3,

    //forwarding

    output reg [4:0] ex_rs1,
    output reg [4:0] ex_rs2,
    output reg ex_uses_rs1,
    output reg ex_uses_rs2

);

always @(posedge clk) begin
    
    if(rst || stall[2]) begin
        ex_b_sel <= 0;
        ex_alu_op <= 0;
        ex_branch_flag <= 0;
        ex_regwrite <= 0;
        ex_memwrite <= 0;
        ex_memtoreg <= 0;
        ex_uses_rs1 <= 0;
        ex_uses_rs2 <=0;

    end

    else begin
    ex_rdata1 <= id_rdata1;
    ex_rdata2 <= id_rdata2;
    ex_rd <= id_rd;

    ex_imm <= id_imm;

    ex_a_sel <= id_a_sel;

    ex_b_sel <= id_b_sel;
    ex_alu_op <= id_alu_op;
    ex_branch_flag <= id_branch_flag;
    ex_regwrite <= id_regwrite;
    ex_memwrite <= id_memwrite;
    ex_memtoreg <= id_memtoreg;



    ex_pc <= id_pc;
    ex_pc_plus_4 <= id_pc_plus_4;


    ex_funct3 <= id_funct3;
    ex_funct7 <= id_funct7;

    ex_rs1 <= id_rs1;
    ex_rs2 <= id_rs2;
    ex_uses_rs1 <= id_uses_rs1;
    ex_uses_rs2 <= id_uses_rs2;

    end
end






endmodule