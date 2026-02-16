/*
    data memory made by liquetxnx on 2026/1

    Size : 16KB
    Addressing : Word

    Not considerd endians : 1-word addressing
*/

module Memory(
    input clk,
    input wire memwrite,
    input wire [31:0] addr,
    input wire [31:0] wd2,

    output wire [31:0] data

);

//word-addressing
reg [31:0] RAM [0:4095];

/*
    data will be written on Testbench source code.

*/

wire [11:0] DMEM_index = addr[13:2];

//Memory read : combiantion logic
assign data = RAM[DMEM_index];
    
always @(posedge clk) begin
    if(memwrite) begin
        //Memory write : sequence logic
        RAM[DMEM_index] <= wd2;
    end
end



endmodule