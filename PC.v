/*
    pc resisger made by liquetxnx 2025/10

    
*/

module PC(
    input wire clk,
    input wire rst,
    input wire[31:0] pc_in,

    input wire [4:0] stall,

    output reg [31:0] pc_out

);

//reg [2:0] ff;

always @(posedge clk) begin 
    if (rst ) begin
        pc_out <= 0;
        //ff <=0;
    end
    
    else if(stall[4]) begin
        pc_out <= pc_out;
    end
    else begin
        //ff<=0;
        pc_out <= pc_in;
    end
end


endmodule