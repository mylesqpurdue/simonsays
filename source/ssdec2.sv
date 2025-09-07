`default_nettype none

module ssdec2(
    input logic [4:0] in, 
    input logic enable,
    output logic [7:0] out
);

always_comb begin

    if (enable) begin

    case (in)
    5'b0: out = 8'b0111111; //0 
    5'b01: out = 8'b0000110; //1
    5'b10: out = 8'b1011011; //2
    5'b11: out = 8'b1001111; //3
    5'b100: out = 8'b1100110; //4
    5'b101: out = 8'b1101101; //5
    5'b110: out = 8'b1111101;//6
    5'b111: out = 8'b0000111;//7
    5'b1000: out = 8'b1111111;//8
    5'b1001: out = 8'b1100111;//9
    5'b1010: out = 8'b1110111;//A
    5'b1011: out = 8'b1111100;//b
    5'b1100: out = 8'b0111001;//C
    5'b1101: out = 8'b1011110;//d
    5'b1110: out = 8'b1111001;//E
    5'b1111: out = 8'b1110001;//F
    5'b10000: out = 8'b1101111; //g
    5'b10001: out = 8'b1110110; //H
    5'b10010: out = 8'b0011110; //j
    5'b10011: out = 8'b0111000; // L
    5'b10100: out = 8'b1010000; //r
    5'b10101: out = 8'b1111000; //t
    5'b10110: out = 8'b1101110; //y
    5'b10111: out = 8'b1010011; //?


    default: out = 8'b00000000;

    endcase

    end else begin
    out = 8'b00000000;
    end
end



endmodule