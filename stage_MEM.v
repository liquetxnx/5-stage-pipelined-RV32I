module stage_MEM(
    input wire clk,
    input wire [31:0] alu_output,
    input wire [31:0] rdata2,


    //control signal
    input wire memwrite,


    output [31:0] wb_data

);
Memory mem_inst(
    .clk(clk),
    .memwrite(memwrite),
    .addr(alu_output),
    .wd2(rdata2),
    .data(wb_data)
);

endmodule