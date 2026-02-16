module stage_EX(

    //input EX signal
    input wire a_sel, 
    input wire b_sel, 
    input wire [1:0] alu_op, 
    input wire [1:0] pc_op,
    
    input wire [1:0] forwarding_a_sel,
    input wire [1:0] forwarding_b_sel,

    //input data
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    input wire [31:0] pc,
    input wire [31:0] rdata1,
    input wire [31:0] rdata2,
    input wire [31:0] imm,

    input wire [31:0] ex_mem_alu_output,
    input wire [31:0] mem_wb_wd,

    //output sig
    output wire [1:0] pcsrc,

    //output data
    output wire [31:0] branch_output,
    output wire [31:0] alu_output

);

wire [3:0] alu_src;
wire [31:0] alu_a_input;
wire [31:0] alu_b_input;
wire BrEq;
wire BrLt;
wire BrLtU;


wire [31:0] temp_a;
wire [31:0] temp_b;


Mux_2to1 a_inst(
    .sel(a_sel),
    .a(rdata1),
    .b(pc),
    .out(temp_a)
);

Mux_4to1 forwarding_a_inst(
    .sel(forwarding_a_sel),
    .a(temp_a),
    .b(ex_mem_alu_output),
    .c(mem_wb_wd),
    .d(0), // not use

    .out(alu_a_input)
);
Mux_2to1 b_inst(
    .sel(b_sel),
    .a(rdata2),
    .b(imm),
    .out(temp_b)
);
Mux_4to1 forwarding_b_inst(
    .sel(forwarding_b_sel),
    .a(temp_b),
    .b(ex_mem_alu_output),
    .c(mem_wb_wd),
    .d(0), // not use

    .out(alu_b_input)
);

ALU_Control alu_ctrl_inst(
    .funct7(funct7),
    .funct3(funct3),
    .alu_op(alu_op),
    .alu_src(alu_src)
);

ALU alu_inst(
    .alu_src(alu_src),
    .a(alu_a_input),
    .b(alu_b_input),
    .result(alu_output),
    .BrEq(BrEq),
    .BrLt(BrLt),
    .BrLtU(BrLtU)
);

Branch_Unit branch_inst(
    .pc_op(pc_op),
    .pcsrc(pcsrc),
    .BrEq(BrEq),
    .BrLtU(BrLtU),
    .BrLt(BrLt),
    .funct3(funct3)
);

Adder branch_adder_inst(
    .a(imm),
    .b(pc),
    .c(branch_output)
);

endmodule