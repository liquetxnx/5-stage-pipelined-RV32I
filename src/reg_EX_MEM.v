module reg_EX_MEM(
    input clk,
    input rst,
    input wire [4:0] ex_rd,
    input wire [31:0] ex_alu_output,
    input wire [31:0] ex_rdata2,
    input wire [31:0] ex_pc_plus_4,
    input wire [31:0] ex_imm,

    output reg [4:0] mem_rd,
    output reg [31:0] mem_alu_output,
    output reg [31:0] mem_rdata2,
    output reg [31:0] mem_pc_plus_4,
    output reg [31:0] mem_imm,

    //control signal
    input wire ex_regwrite,
    input wire ex_memwrite,
    input wire [1:0] ex_memtoreg,

    output reg mem_regwrite,
    output reg mem_memwrite,
    output reg [1:0] mem_memtoreg

);
//ex stage에서 쓴 것 : alu관련 signal, branch 관련 signal, 
// 넘어가야할 data : rd, aluouput, imm, pc_plus_4 (WB로) 
// 넘어가야할 sig : memtoreg(wb mux), memwrite, regwrite


always @(posedge clk) begin

    if (rst) begin
        mem_regwrite <= 0;
        mem_memwrite <= 0;
        mem_memtoreg <= 0;
    end

    else begin
    mem_rd <= ex_rd;
    mem_alu_output <= ex_alu_output;
    mem_rdata2 <= ex_rdata2;
    mem_pc_plus_4 <= ex_pc_plus_4;

    mem_imm <= ex_imm;

    mem_regwrite <= ex_regwrite;
    mem_memwrite <= ex_memwrite;
    mem_memtoreg <= ex_memtoreg;
    end
end





endmodule