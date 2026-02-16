module reg_MEM_WB(
    input clk,
    input rst,
    input wire [31:0] mem_mem_output,
    input wire [31:0] mem_alu_output,
    input wire [31:0] mem_imm,
    input wire [31:0] mem_pc_plus_4,
    input wire [4:0] mem_rd,

    output reg [31:0] wb_mem_output,
    output reg [31:0] wb_alu_output,
    output reg [31:0] wb_imm,
    output reg [31:0] wb_pc_plus_4,
    output reg [4:0] wb_rd,

    //control signal
    input wire [1:0] mem_memtoreg,
    input wire mem_regwrite,

    output reg [1:0] wb_memtoreg,
    output reg wb_regwrite
);
//mem -> wb 
// data : alu_output, mem_output, imm, pc_plus_4, rd
// sig : memtoreg, regwrite

always @(posedge clk) begin

    if(rst) begin
        wb_memtoreg <= 0;
        wb_regwrite <=0;
    end

    else begin
    wb_mem_output <= mem_mem_output;


    wb_alu_output <= mem_alu_output;
    wb_imm <= mem_imm;
    wb_pc_plus_4 <= mem_pc_plus_4;
    wb_rd <= mem_rd;

    wb_memtoreg <= mem_memtoreg;
    wb_regwrite <= mem_regwrite;
    end
end

endmodule