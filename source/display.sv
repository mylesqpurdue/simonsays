module display(
    input logic [3:0] state,
    input logic [11:0] idx,
    input logic [3:0] count,
    input logic lsb,
    //input logic [15:0] led,
    output logic [63:0] ss,
    output logic red, green, blue
);

   logic [7:0] ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0;

logic [7:0] idx1, idx2, idx3;
logic [7:0] count1;

// ssdec2 dec0(.enable(1), .in(), .out(ss7));
// ssdec2 dec1(.enable(1), .in(), .out(ss6));
// ssdec2 dec2(.enable(1), .in(), .out(ss5));
// ssdec2 dec3(.enable(1), .in(), .out(ss4));
ssdec2 dec4(.enable(1), .in({1'b0, count}), .out(count1));
ssdec2 dec5(.enable(1), .in({1'b0, idx[3:0]}), .out(idx1));
ssdec2 dec6(.enable(1), .in({1'b0, idx[7:4]}), .out(idx2));
ssdec2 dec7(.enable(1), .in({1'b0, idx[11:8]}), .out(idx3));


// typedef enum logic [3:0] {
  
//    RESET = 1,
//    READY = 2,
//    GAME = 3,
//    EVALUATE = 4,
//    GOODBOY = 5,
//    FAIL = 6

// } state_t;
// state_t current_state, next_state;


always_comb begin
    if (state == 4'd01) begin
        ss = 64'b0;
        green = 0;
        red = 0;
       blue = 0;
    end else if (state == 4'd2) begin
        ss = {56'b01010000_01111001_01110111_01011110_01101110_01010011_00000000, count1};
        red = 0;
        green = 0;
       blue = 0;
    end else if (state == 4'd3) begin
        ss = {40'b01110110_00111111_00111000_01011110_00000000, idx3, idx2, idx1};
        red = 0;
        green = 0;
        if (lsb) begin //&& (led > 0)
            blue = 1;
        end else begin
            blue = 0;
        end
    end else if (state == 4'd4) begin
        ss = 64'b0;
       blue = 0;
        red = 0;
        green = 0;
    end else if (state == 4'd5) begin
        ss = 64'b01101111_00111111_00111111_01011110_00000000_01111100_00111111_01101110;
       blue = 0;
        red = 0;
        green = 1;
    end else if (state == 4'd6) begin
        ss = 64'b01111000_01010000_01101110_01110111_01101111_01110111_00000110_01010100;
       blue = 0;
        red = 0;
        green = 0;
    end else begin
        green = 0;
        red = 0;
       blue = 0;
        ss = 64'b01;
    end


end

endmodule