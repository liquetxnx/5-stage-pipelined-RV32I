module reg_IF_ID(
    input wire clk,
    input wire rst,
    input wire [31:0] if_instr,
    input wire [31:0] if_pc,
    input wire [31:0] if_pc_plus_4,
    input wire [4:0] stall,

    output reg [31:0] id_instr,
    output reg [31:0] id_pc,
    output reg [31:0] id_pc_plus_4
    

);



always @(posedge clk) begin

        if(rst ) begin
            id_instr <= 32'h0000_0013; //addi x0 x0 0
        end

        else if (stall[3]) begin
            id_instr <= id_instr;
            id_pc <= id_pc;
            id_pc_plus_4 <= id_pc_plus_4;
        end

        else begin
        id_instr <= if_instr;
        id_pc <= if_pc;
        id_pc_plus_4 <= if_pc_plus_4;

        end
    
    
end

endmodule