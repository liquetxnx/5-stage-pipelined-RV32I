

`include "defines.v"
module stage_ID(
    input clk,
    input rst,

    input wire [31:0] if_instr,

    input wire [4:0] wb_rd,
    input wire [31:0] wb_wd,
    input wire wb_regwrite,

    output wire id_a_sel,
    output wire id_b_sel,
    output wire [1:0] id_alu_op,
    output wire [1:0] id_pc_op,
    output wire id_regwrite,
    output wire id_memwrite,
    output wire [1:0] id_memtoreg,
    output wire [4:0] id_rs1,
    output wire [4:0] id_rs2,
    output wire id_uses_rs1,
    output wire id_uses_rs2,
    output wire [31:0] id_imm,
    output wire [3:0] id_funct3,
    output wire [4:0] id_rd,

    output wire [31:0] id_rdata1,
    output wire [31:0] id_rdata2
);

wire [2:0] immsrc;
wire [31:0] temp_rdata1;
wire [31:0] temp_rdata2;

Control_Unit ctrl_inst(

    .opcode(if_instr[6:0]),

    .a_sel(id_a_sel),
    .b_sel(id_b_sel),
    .alu_op(id_alu_op),
    .pc_op(id_pc_op),
    .regwrite(id_regwrite),
    .memwrite(id_memwrite),
    .memtoreg(id_memtoreg),
    .immsrc(immsrc),
    .uses_rs1(id_uses_rs1),
    .uses_rs2(id_uses_rs2)
);

ImmGen immgen_inst(
    .instr(if_instr[31:7]),
    .immsrc(immsrc),
    .imm(id_imm)

);


Reg_File reg_inst(
    .clk(clk),
    .rst(rst),
    .regwrite(wb_regwrite),
    .rs1(if_instr[19:15]),
    .rs2(if_instr[24:20]),
    .rd(wb_rd),
    .wd(wb_wd),
    .rdata1(temp_rdata1),
    .rdata2(temp_rdata2)
);

assign id_funct3 = if_instr[14:12];
assign id_rd = if_instr[11:7];
assign id_rs1 = if_instr[19:15];
assign id_rs2 = if_instr[24:20];

//WB 단계 그 다음에 값이 써진다. 즉 ID 단계에 있는 명령어는 WB 단계에 있는 값을 볼 수 없다... 이건 여기서 forwarding으로 해결한다..
/*
    1. addi x1 x0 10
    2. addi x2 x0 3
    3. sub x3 x1 x2
    4. sub x4 x3 x1

    이 경우 4번째 단계에서 x1 값을 읽을 수가 없다. 아직 갱신이 안되었고 wb단계에만 머물고 있기 때문. 
*/


assign id_rdata1 = (wb_regwrite && wb_rd !=0 && wb_rd==id_rs1) ? wb_wd : temp_rdata1;
assign id_rdata2 = (wb_regwrite && wb_rd !=0 && wb_rd==id_rs2) ? wb_wd : temp_rdata2;

//시작시 단계 사이 레지스터들을 초기화하지 않은 돈케어로 mux 입력을 받으니 mux가 작동하지 않는 문제 생김


endmodule
