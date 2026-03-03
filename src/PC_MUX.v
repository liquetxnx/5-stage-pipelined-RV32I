/*
    pc_next made by liquetxnx 2025/12

    Reason why made it?

    Too complex code on data path when do not merge pc_next content to pc_next

*/

module PC_MUX(
    input wire [31:0] pc_plus_4,
    input wire [31:0] branch_output,
    input wire [31:0] alu_output,
    input wire [1:0] pcsrc,

    output reg [31:0] pc_next
);


always @(*) begin
    
    case(pcsrc)
    2'b00 : pc_next=pc_plus_4; // general
    2'b01 : pc_next=branch_output; // b-type branch
    2'b10 : pc_next=branch_output; // j-type jump
    2'b11 : pc_next={alu_output[31:1],1'b0}; // i-type jump

    default : pc_next = pc_plus_4;

    endcase

end


endmodule