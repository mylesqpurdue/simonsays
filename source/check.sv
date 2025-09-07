`default_nettype none
module check (
    input  logic [11:0] idx,     // Expected sequence (3 values)
    input  logic blue,
    input  logic [15:0] in,       // 16 pushbuttons
    output logic verify
);

logic [3:0] val1, val2, val3;
logic [15:0] expected_mask;  // Set of buttons expected (no duplicates)
logic [15:0] actual_mask;    // Set of buttons actually pressed
logic match;
logic any_pressed;
always_comb begin
    verify = 0;
    match = 1;
    any_pressed=0;

    // Extract 3 expected button indices
    val1 = idx[11:8];
    val2 = idx[7:4];
    val3 = idx[3:0];

    // Make a bitmask of the expected buttons (ignore duplicates)
    expected_mask = 16'b0;
    expected_mask[val1] = 1;
    expected_mask[val2] = 1;
    expected_mask[val3] = 1;

    // Make a bitmask of the actual buttons pressed
    actual_mask = in;

    if (blue) begin
        // Match only if pressed buttons == expected set
        if (actual_mask == expected_mask)
            verify = 1;
    end else begin
        // Simon didn't say — any press is wrong
        for (int i = 0; i < 16; i++) begin
            if (in[i]) any_pressed = 1;
        end
        verify = !any_pressed;
    end
end

endmodule
