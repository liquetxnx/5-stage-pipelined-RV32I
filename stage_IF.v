module stage_IF(
    
    input wire clk,
    input wire rst,

    input wire [31:0] jalr_addr,
    input wire [31:0] branch_addr,
    input wire [1:0] pcsrc,

    input wire [4:0] stall,

    output wire [31:0] instr,
    output wire [31:0] pc,
    output wire [31:0] pc4

);

wire [31:0] pc_next;




Adder pc4_inst(
    .a(pc),
    .b(32'd4),
    .c(pc4)
);

PC_MUX pc_mux_inst(

    .pc_plus_4(pc4),
    .branch_output(branch_addr),
    .alu_output(jalr_addr),
    .pcsrc(pcsrc),
    .pc_next(pc_next)

);

PC pc_inst(
    .clk(clk),
    .rst(rst),
    .stall(stall),
    .pc_in(pc_next),
    .pc_out(pc)

);

IM im_inst(
    .addr(pc),
    .instr(instr)
);



endmodule
