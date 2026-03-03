/*
    Register_file made by liquetxnx on 2025/10

*/
`include "defines.v"

module Reg_File(
    input wire clk,
    input wire rst,


    input wire regwrite,


    input wire [4:0] rs1,// register r1 : instr[19:15]
    input wire [4:0] rs2, // register r2 : instr[24:20]
    input wire [4:0] rd, // register rd : instr[11:7]
    input wire [31:0] wd, // Write Data to Reg


    output wire [31:0] rdata1, // this output go to ALU A input
    output wire [31:0] rdata2
);

reg [31:0] rg [31:0];



always @(posedge clk) begin
    rg[0] <= 32'h0; //always fix x0 to 0
    if (rst) begin
        rg[2] <= `STACK_POINTER; //fix stack pointer 
    end

    if(regwrite==1 && rd != 5'b0) begin
        rg[rd] <= wd;
    end
end

assign rdata1 = rg[rs1];
assign rdata2 = rg[rs2];



endmodule