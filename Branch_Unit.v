/*
    Branch unit made by liquetxnx on 2025/12

*/

module Branch_Unit(
    input wire [1:0] pc_op,
    input wire BrEq,
    input wire BrLt,
    input wire BrLtU,

    input wire [2:0] funct3,

    output reg [1:0] pcsrc
);

always @(*) begin
    if(pc_op == 2'b01) begin
        
        case(funct3)
            3'b000 : pcsrc = (BrEq ? pc_op : 2'b00 );
            3'b001 : pcsrc = (~BrEq ? pc_op : 2'b00 );
            3'b100 : pcsrc = (BrLt ? pc_op : 2'b00 );
            3'b101 : pcsrc = (~BrLt ? pc_op : 2'b00 );
            3'b110 : pcsrc = (BrLtU ? pc_op : 2'b00 );
            3'b111 : pcsrc = (~BrLtU ? pc_op : 2'b00 );
            
            default pcsrc= pc_op;
        endcase
    end

    else begin
        pcsrc = pc_op;
    end

end


endmodule