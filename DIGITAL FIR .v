module DIGITAL_FIR_(
    input wire clk,
    input wire signed [7:0] x_in,        // Input sample
    output reg signed [19:0] y_out       // Filtered output
);
    localparam signed [7:0] h0 = 8'd2;
    localparam signed [7:0] h1 = 8'd4;
    localparam signed [7:0] h2 = 8'd6;
    localparam signed [7:0] h3 = 8'd8;
    localparam signed [7:0] h4 = 8'd6;
    localparam signed [7:0] h5 = 8'd4;
    localparam signed [7:0] h6 = 8'd2;
    localparam signed [7:0] h7 = 8'd1;

    // Shift register for past input samples
    reg signed [7:0] x [0:7];

    // Temporary products
    wire signed [15:0] mult [0:7];
    integer i;

    // Shift the input samples on every clock
    always @(posedge clk) begin
        x[0] <= x_in;
        for (i = 1; i < 8; i = i + 1) begin
            x[i] <= x[i-1];
        end
    end
	 
    assign mult[0] = x[0] * h0;
    assign mult[1] = x[1] * h1;
    assign mult[2] = x[2] * h2;
    assign mult[3] = x[3] * h3;
    assign mult[4] = x[4] * h4;
    assign mult[5] = x[5] * h5;
    assign mult[6] = x[6] * h6;
    assign mult[7] = x[7] * h7;
	 
    // Add all products to produce output
    always @(posedge clk) begin
        y_out <= mult[0] + mult[1] + mult[2] + mult[3] +
                 mult[4] + mult[5] + mult[6] + mult[7];
    end
	 


endmodule