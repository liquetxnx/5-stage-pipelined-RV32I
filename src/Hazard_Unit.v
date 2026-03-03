module Hazard_Unit (
    input wire uses_rs1,
    input wire uses_rs2,
    input wire memwrite,

    input wire [4:0] rs1,
    input wire [4:0] rs2,

    input wire [1:0] id_ex_memtoreg,
    input wire [4:0] id_ex_rd,

    output reg [4:0] stall

);

always @(*) begin
    stall = 5'b00000;

    if(uses_rs1 && id_ex_memtoreg == 2'b01 && id_ex_rd !=0 && id_ex_rd == rs1) begin
        stall = 5'b11100;

    end


    if((uses_rs2 || memwrite) && id_ex_memtoreg == 2'b01 && id_ex_rd !=0 && id_ex_rd == rs2) begin
        stall = 5'b11100;

    end


end

endmodule