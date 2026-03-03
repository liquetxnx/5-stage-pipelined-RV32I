/*
    IM made by liquetxnx on 2026/1

*/

module IM(
    input wire [31:0] addr,
    output wire [31:0] instr
);

//8KB IM
reg [7:0] mem [0:8191];

initial begin
    $readmemh("prog.hex", mem);
end

//little-endian

assign instr={mem[addr+3], mem[addr+2], mem[addr+1], mem[addr] };
endmodule