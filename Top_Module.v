`include "defines.v"

module Top_Module(
    input clk,
    input rst
);

//control signal
wire [4:0] stall;
wire [1:0] if_in_pcsrc;



//IF data
wire [31:0] if_out_instr;
wire [31:0] if_out_pc;
wire [31:0] if_out_pc4;

wire [31:0] if_in_jalr_addr;
wire [31:0] if_in_branch_addr;

//ID data input
wire [31:0] id_in_instr;
wire [31:0] id_in_pc;
wire [31:0] id_in_pc4;


//ID output wire
wire [31:0] id_out_imm;
wire [4:0] id_out_rd;
wire [31:0] id_out_rdata1;
wire [31:0] id_out_rdata2;

//ID output signal
wire id_out_a_sel;
wire id_out_b_sel;
wire [1:0] id_out_alu_op;
wire [1:0] id_out_branch_flag;
wire id_out_regwrite;
wire id_out_memwrite;
wire [1:0] id_out_memtoreg;
wire id_out_uses_rs1;
wire id_out_uses_rs2;

//EX wire
wire ex_in_a_sel;
wire ex_in_b_sel;
wire [1:0] ex_in_alu_op;
wire [1:0] ex_in_branch_flag;
wire ex_in_regwrite;
wire ex_in_memwrite;
wire [1:0] ex_in_memtoreg;

//forwarding wire - related ex 
wire ex_uses_rs1;
wire ex_uses_rs2;
wire [4:0] ex_rs1;
wire [4:0] ex_rs2;
wire [1:0] ex_forwarding_a;
wire [1:0] ex_forwarding_b;
wire [1:0] forwarding_rdata2;

wire [31:0] rdata2_for_forwarding;

wire [31:0] ex_in_rdata1;
wire [31:0] ex_in_rdata2;
wire [4:0] ex_in_rd;
wire [31:0] ex_in_pc;
wire [31:0] ex_in_pc4;

wire [2:0] ex_in_funct3;
wire [6:0] ex_in_funct7;
wire [31:0] ex_in_imm;

wire [1:0]  ex_out_pcsrc;
wire [31:0] ex_out_branch_output;
wire [31:0] ex_out_alu_output;
//end


//Mem wire
wire [4:0]  mem_in_rd;
wire [31:0] mem_in_alu_output;
wire [31:0] mem_in_rdata2;
wire [31:0] mem_in_pc4;
wire [31:0] mem_in_imm;

wire        mem_in_regwrite;
wire        mem_in_memwrite;
wire [1:0]  mem_in_memtoreg;

wire [31:0] mem_out_data;

//WB wire
wire [4:0] wb_rd;
wire wb_regwrite;
wire [31:0] wb_data;

wire [31:0] wb_in_alu_output;
wire [31:0] wb_in_imm;
wire [31:0] wb_in_mem_output;
wire [1:0] wb_in_memtoreg;
wire [31:0] wb_in_pc4;


stage_IF if_inst(
    .clk(clk),
    .rst(rst),
    .stall(stall),
    .jalr_addr(if_in_jalr_addr),
    .branch_addr(if_in_branch_addr),
    .pcsrc(if_in_pcsrc),
    .instr(if_out_instr),
    .pc(if_out_pc),
    .pc4(if_out_pc4)
);

reg_IF_ID reg_if_id_inst(
    .clk(clk),
    .rst(rst),
    .stall(stall),
    .if_instr(if_out_instr),
    .if_pc(if_out_pc),
    .if_pc_plus_4(if_out_pc4),
    .id_instr(id_in_instr),
    .id_pc(id_in_pc),
    .id_pc_plus_4(id_in_pc4)

);

stage_ID id_inst(
    .clk(clk),
    .rst(rst),

    .if_instr(id_in_instr),

    .wb_rd(wb_rd),
    .wb_wd(wb_data),
    .wb_regwrite(wb_regwrite),

    .id_a_sel(id_out_a_sel),
    .id_b_sel(id_out_b_sel),
    .id_alu_op(id_out_alu_op),
    .id_pc_op(id_out_branch_flag),
    .id_regwrite(id_out_regwrite),
    .id_memwrite(id_out_memwrite),
    .id_memtoreg(id_out_memtoreg),

    .id_imm(id_out_imm),
    .id_rd(id_out_rd),

    .id_rdata1(id_out_rdata1),
    .id_rdata2(id_out_rdata2),

    .id_uses_rs1(id_out_uses_rs1),
    .id_uses_rs2(id_out_uses_rs2)

);

Hazard_Unit hazard_inst(
    .uses_rs1(id_out_uses_rs1),
    .uses_rs2(id_out_uses_rs2),

    .rs1(id_in_instr[19:15]),
    .rs2(id_in_instr[24:20]),

    .id_ex_memtoreg(ex_in_memtoreg),
    .id_ex_rd(ex_in_rd),

    .stall(stall)


);


reg_ID_EX reg_id_ex_inst(
    .clk(clk),
    .rst(rst),
    .stall(stall),


    //from Reg_File
    .id_rdata1(id_out_rdata1),
    .id_rdata2(id_out_rdata2),
    .id_rd(id_out_rd),

    //from ImmGen
    .id_imm(id_out_imm),

    //from Control_unit
    .id_a_sel(id_out_a_sel),
    .id_b_sel(id_out_b_sel),
    .id_alu_op(id_out_alu_op),
    .id_branch_flag(id_out_branch_flag),
    .id_regwrite(id_out_regwrite),
    .id_memwrite(id_out_memwrite),
    .id_memtoreg(id_out_memtoreg),

    //from pc
    .id_pc(id_in_pc),
    .id_pc_plus_4(id_in_pc4),

    //from instr
    .id_funct3(id_in_instr[14:12]),
    .id_funct7(id_in_instr[31:25]),
    
    .id_rs1(id_in_instr[19:15]),
    .id_rs2(id_in_instr[24:20]),
    .id_uses_rs1(id_out_uses_rs1),
    .id_uses_rs2(id_out_uses_rs2),

    .ex_rdata1(ex_in_rdata1),
    .ex_rdata2(ex_in_rdata2),
    .ex_rd(ex_in_rd),
    .ex_imm(ex_in_imm),

    .ex_a_sel        (ex_in_a_sel),
    .ex_b_sel        (ex_in_b_sel),
    .ex_alu_op       (ex_in_alu_op),
    .ex_branch_flag  (ex_in_branch_flag),
    .ex_regwrite     (ex_in_regwrite),
    .ex_memwrite     (ex_in_memwrite),
    .ex_memtoreg     (ex_in_memtoreg),
    .ex_pc           (ex_in_pc),
    .ex_pc_plus_4    (ex_in_pc4),

    .ex_funct7       (ex_in_funct7),
    .ex_funct3       (ex_in_funct3),

    .ex_rs1(ex_rs1),
    .ex_rs2(ex_rs2),
    .ex_uses_rs1(ex_uses_rs1),
    .ex_uses_rs2(ex_uses_rs2)
);


Forwarding_Unit forwarding_inst(
    .uses_rs1(ex_uses_rs1),
    .uses_rs2(ex_uses_rs2),
    .rs1(ex_rs1),
    .rs2(ex_rs2),
    .ex_mem_rd(mem_in_rd),
    .mem_wb_rd(wb_rd),
    .ex_mem_regwrite(mem_in_regwrite),
    .mem_wb_regwrite(wb_regwrite),

    .memwrite(ex_in_memwrite),

    .forwarding_a_sel(ex_forwarding_a),
    .forwarding_b_sel(ex_forwarding_b),
    .forwarding_rdata2(forwarding_rdata2)

);


stage_EX ex_inst(
    .a_sel         (ex_in_a_sel),
    .b_sel         (ex_in_b_sel),
    .alu_op        (ex_in_alu_op),
    .pc_op         (ex_in_branch_flag),

    .forwarding_a_sel(ex_forwarding_a),
    .forwarding_b_sel(ex_forwarding_b),

    .funct3        (ex_in_funct3),
    .funct7        (ex_in_funct7),
    .pc            (ex_in_pc),
    .rdata1        (ex_in_rdata1),
    .rdata2        (ex_in_rdata2),
    .imm           (ex_in_imm),
    
    .ex_mem_alu_output(mem_in_alu_output),
    .mem_wb_wd(wb_data),

    .pcsrc         (ex_out_pcsrc),

    .branch_output (ex_out_branch_output),
    .alu_output    (ex_out_alu_output)

);
assign if_in_jalr_addr=ex_out_alu_output;
assign if_in_branch_addr=ex_out_branch_output;
assign if_in_pcsrc = ex_out_pcsrc;


Mux_4to1 rdata2_mux_inst(
    .sel(forwarding_rdata2),
    .a(ex_in_rdata2),
    .b(mem_in_alu_output),
    .c(wb_in_alu_output),
    .d(0),
    .out(rdata2_for_forwarding)
);

reg_EX_MEM reg_ex_mem_inst(
    .clk           (clk),
    .rst (rst),
    .ex_rd         (ex_in_rd),
    .ex_alu_output (ex_out_alu_output),
    .ex_rdata2     (rdata2_for_forwarding),
    .ex_pc_plus_4  (ex_in_pc4),
    .ex_imm        (ex_in_imm),

    .mem_rd        (mem_in_rd),
    .mem_alu_output(mem_in_alu_output),
    .mem_rdata2    (mem_in_rdata2),
    .mem_pc_plus_4 (mem_in_pc4),
    .mem_imm       (mem_in_imm),          

    .ex_regwrite   (ex_in_regwrite),
    .ex_memwrite   (ex_in_memwrite),
    .ex_memtoreg   (ex_in_memtoreg),

    .mem_regwrite  (mem_in_regwrite),
    .mem_memwrite  (mem_in_memwrite),
    .mem_memtoreg  (mem_in_memtoreg)
);
stage_MEM stage_mem_inst(
    .clk(clk),
    .alu_output(mem_in_alu_output),
    .rdata2(mem_in_rdata2),
    .memwrite(mem_in_memwrite),
    .wb_data(mem_out_data)

);

// MEM/WB pipeline register instance
reg_MEM_WB reg_mem_wb_inst(
    .clk          (clk),
    .rst(rst),
    .mem_mem_output (mem_out_data),
    .mem_alu_output (mem_in_alu_output),
    .mem_imm        (mem_in_imm),
    .mem_pc_plus_4  (mem_in_pc4),
    .mem_rd         (mem_in_rd),

    .wb_mem_output  (wb_in_mem_output),
    .wb_alu_output  (wb_in_alu_output),
    .wb_imm         (wb_in_imm),
    .wb_pc_plus_4   (wb_in_pc4),
    .wb_rd          (wb_rd),

    .mem_memtoreg   (mem_in_memtoreg),
    .mem_regwrite   (mem_in_regwrite),

    .wb_memtoreg    (wb_in_memtoreg),
    .wb_regwrite    (wb_regwrite)
);

stage_WB wb_inst (

    .alu_output(wb_in_alu_output),
    .mem_data(wb_in_mem_output),
    .imm(wb_in_imm),
    .pc_plus_4(wb_in_pc4),

    .memtoreg(wb_in_memtoreg),
    .wd(wb_data)
);




endmodule