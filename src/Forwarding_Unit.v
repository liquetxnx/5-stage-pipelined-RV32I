module Forwarding_Unit (
    input wire uses_rs1,
    input wire uses_rs2,
    input wire [4:0] rs1,
    input wire [4:0] rs2,
    input wire [4:0] ex_mem_rd,
    input wire [4:0] mem_wb_rd,
    input wire ex_mem_regwrite,
    input wire mem_wb_regwrite,

    input wire memwrite,

    output reg [1:0] forwarding_a_sel,
    output reg [1:0] forwarding_b_sel,
    output reg [1:0] forwarding_rdata2

);

//ex stage forwarding
always @(*) begin
    forwarding_a_sel=2'b00; forwarding_b_sel = 2'b00; forwarding_rdata2=2'b00;

    //더 최신버전인 ex_mem을 우선적으로 사용
    if(uses_rs1) begin
        if(ex_mem_regwrite && ex_mem_rd != 0 && ex_mem_rd == rs1) begin
            
            forwarding_a_sel=2'b01;

        end
        else if(mem_wb_regwrite && mem_wb_rd != 0 && mem_wb_rd == rs1) begin
            forwarding_a_sel=2'b10;
        end
    end


    if(uses_rs2) begin
        if(ex_mem_regwrite && ex_mem_rd != 0 && ex_mem_rd == rs2) begin

            forwarding_b_sel=2'b01;

        end
        else if(mem_wb_regwrite && mem_wb_rd != 0 && mem_wb_rd == rs2) begin
            forwarding_b_sel=2'b10;
        end
    end

//store rdata2 forwawrding
    if (memwrite) begin

        if(ex_mem_regwrite && ex_mem_rd != 0 && ex_mem_rd == rs2) begin
            forwarding_rdata2=2'b01;

        end
    
        else if(mem_wb_regwrite && mem_wb_rd != 0 && mem_wb_rd == rs2) begin
            forwarding_rdata2=2'b10;
        end

    end

end


endmodule