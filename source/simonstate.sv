`default_nettype none

module simonstate(
   input logic clk, rst, in, blue,
   input logic [15:0] pb,
   output logic lsb, red,
   output logic [15:0] led,
   output logic [3:0] count, state,
   output logic [11:0] idx

);

//logic [15:0] ledoutcheck, ledoutshift;
logic s_en;
logic r_en;
logic newclk;
logic check_n;

ledclkdiv div (.clk(clk), .rst(rst), .newclk(newclk));
ledshift shift(.clk(newclk), .rst(rst), .s_en(s_en), .readin_en(), .led(led));
check check (.idx(idx), .in(pb[15:0]), .verify(check_n), .blue(lsb));

//  input_check check (.en(lsb), .in(pb), .seq0(idx[3:0]), .seq1(idx[3:0]), .seq2(idx[3:0]), .pass(check_n));
 read read (.clk(clk), .rst(rst), .r_en(r_en), .lsb(lsb), .idx(idx));

typedef enum logic [3:0] {
   RESET = 1,
   READY = 2,
   GAME = 3,
   EVALUATE = 4,
   GOODBOY = 5,
   FAIL = 6 
} state_t;
 
state_t current_state, next_state;

assign state = current_state;
assign count = current_count;

logic [3:0] current_count, next_count;

always_ff @(posedge clk, posedge rst) begin
    if (rst) begin
        current_count <= '0;
        current_state <= RESET;
    end else begin
        current_count <= next_count;
        current_state <= next_state;
    end
end

always_comb begin
    r_en = 0;
    s_en = 0;
    red = 0;
    next_state = current_state;
    next_count =  current_count;

   case (current_state)
   RESET: begin
    next_state = READY;
    next_count = 'b0;
   end

   READY:begin
       if (in) begin
           next_state = GAME;
           next_count = current_count;
           r_en = 'd1; 
       end else begin
        next_state = READY;
        next_count = current_count;
       end
   end

    GAME: begin
        if (led == '0) begin
            next_state = EVALUATE;
            next_count = current_count;
        end else begin
            next_state = current_state;
            next_count = current_count;
            s_en = 1;
        end
    end

    EVALUATE: begin
        if (check_n) begin
            next_count = current_count + 'b1;
            next_state = READY;
        end else if (current_count > 4'd9) begin
            next_state = GOODBOY;
            next_count = current_count;
        end else begin
            next_count = 'b0;
            next_state = FAIL;
        end

        if (current_count > 4'd9) begin
            next_state = GOODBOY;
            next_count = current_count;
        end

    end
    
    GOODBOY: begin
        next_state = current_state;
        next_count = 'b0;
    end 

    FAIL: begin
        next_state = current_state;
        next_count = 'b0;
    end
    default:   begin  next_state = current_state;
    next_count =  current_count; end

   endcase
end
endmodule
