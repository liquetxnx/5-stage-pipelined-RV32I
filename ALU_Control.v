/*
    ALU control made by liquetxnx on 2025/12

    ALU_control is separated by Control_ unit 

    : Control unit is too heavy if add alu_control

*/

`include "defines.v"

module ALU_Control(
    input wire [6:0] funct7,
    input wire [2:0] funct3,
    input wire [1:0] alu_op,
    
    output reg [3:0] alu_src

);



always @(*) begin
    case(alu_op)
    2'b00 : alu_src=`ADD;
    2'b01 : alu_src=`SUB;
    2'b10 : begin
        //R-Type
        case (funct3)
        3'b000 : alu_src=(funct7[5] ? `SUB : `ADD);
        3'b001 : alu_src=`SLL;
        3'b010 : alu_src=`SLT;
        3'b011 : alu_src=`SLTU;
        3'b100 : alu_src=`XOR;
        3'b101 : alu_src=(funct7[5] ? `SRA : `SRL);
        3'b110 : alu_src=`OR;
        3'b111 : alu_src=`AND;
        default: alu_src=`ADD;

        endcase
    end
    
    2'b11 : begin
        //I-type
        case(funct3)
        3'b000 : alu_src=`ADD;
        3'b001 : alu_src=`SLL;
        3'b010 : alu_src=`SLT;
        3'b011 : alu_src=`SLTU;
        3'b100 : alu_src=`XOR;
        3'b101 : alu_src=(funct7[5] ? `SRA : `SRL);
        3'b110 : alu_src=`OR;
        3'b111 : alu_src=`AND;
        default: alu_src=`ADD;
        endcase
    end
    
    default:alu_src= `ADD;
    endcase
end
endmodule