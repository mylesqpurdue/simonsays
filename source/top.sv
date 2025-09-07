// `default_nettype none
// Empty top module

module top (
  // I/O ports
  input  logic hz100, reset,
  input  logic [20:0] pb,
  output logic [7:0] left, right,
         ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0,
  output logic red, green, blue,

  // UART ports
  output logic [7:0] txdata,
  input  logic [7:0] rxdata,
  output logic txclk, rxclk,
  input  logic txready, rxready
);

  logic newclk;
  logic lsb;
  logic [2:0] num;
  logic [11:0] idx;
  logic check;
  logic [3:0] state;
  logic [3:0] count;


// read read (.clk(hz100), .en(1), .rst(reset), .lsb(lsb), .idx(idx));

// // check check (.idx(idx),.in(pb[15:0]), .verify(verify), .out());

// // ssdec2 dec0(.enable(1), .in({1'b0, idx[3:0]}), .out(ss7));
// // ssdec2 dec1(.enable(1), .in({1'b0, idx[7:4]}), .out(ss6));
// // ssdec2 dec2(.enable(1), .in({1'b0, idx[11:8]}), .out(ss5));



// ledclkdiv clkdiv(.clk(hz100), .rst(reset), .newclk(newclk));
// // ledshift shift (.clk(newclk), .rst(reset), .led({left, right}), .blue(blue), .lsb(lsb));

// // simonstate simon(.clk(hz100), .rst(reset), .check(verify), .in(pb[19]), .ss({ss0,ss1,ss2,ss3,ss4,ss5,ss6,ss7}), .led({left, right}));

simonstate simonstate(.red(red), .clk(hz100), .rst(reset), 
.led({left, right}), .state(state), .count(count), .lsb(lsb), 
.idx(idx), .in(pb[19]), .pb(pb[15:0]), .blue(blue));

display display (.state(state), .count(count), .idx(idx), 
.ss({ss7,ss6,ss5,ss4,ss3,ss2,ss1,ss0}), .lsb(lsb), 
.red(red), .blue(blue) ,.green(green));


endmodule
