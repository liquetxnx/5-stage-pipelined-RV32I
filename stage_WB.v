module stage_WB(

    input wire [31:0] alu_output,
    input wire [31:0] mem_data,
    input wire [31:0] imm,
    input wire [31:0] pc_plus_4,

    input wire [1:0] memtoreg,

    output reg [31:0] wd
);



//wb mux
always @(*) begin
    case(memtoreg)
    2'b00 : wd = alu_output;
    2'b01 : wd = mem_data;
    2'b10 : wd = imm;
    2'b11 : wd = pc_plus_4;
    endcase
end

endmodule;