module TEST_BENCH;

	// Inputs
	reg clk;
	reg [7:0] x_in;

	// Outputs
	wire [19:0] y_out;

	// Instantiate the Unit Under Test (UUT)
	DIGITAL_FIR_ uut (
		.clk(clk), 
		.x_in(x_in), 
		.y_out(y_out)
	);
	// Clock generation: 100MHz -> 10ns period
    always #5 clk = ~clk;
	 // Input stimulus
    integer i;
    reg signed [7:0] test_input[0:15]; // 16 input samples

	initial begin
	    $display("---- FIR Filter Simulation Start ----");
       $dumpfile("fir_filter_tb.vcd");   // Optional: waveform output for GTKWave
       $dumpvars(0, fir_filter_tb);
		// Initialize Inputs
		clk = 0;
		x_in = 0;
		
        // Test input sequence: impulse, step, ramp
        test_input[0]  = 8'd50;  // Impulse
        test_input[1]  = 8'd0;
        test_input[2]  = 8'd0;
        test_input[3]  = 8'd0;
        test_input[4]  = 8'd50;  // Step input starts
        test_input[5]  = 8'd50;
        test_input[6]  = 8'd50;
        test_input[7]  = 8'd50;
        test_input[8]  = 8'd20;  // Ramp input starts
        test_input[9]  = 8'd30;
        test_input[10] = 8'd40;
        test_input[11] = 8'd50;
        test_input[12] = 8'd60;
        test_input[13] = 8'd70;
        test_input[14] = 8'd80;
        test_input[15] = 8'd90;
		  
		  // Feed input values to filter one per clock cycle
        for (i = 0; i < 16; i = i + 1) begin
            x_in = test_input[i];
            @(posedge clk);
            #1; // Slight delay after clock edge for stable output
            $display("Time=%0t ns | x_in=%d | y_out=%d", $time, x_in, y_out);
        end
		  

		// Wait 100 ns for global reset to finish
		#50;
		$display("---- FIR Filter Simulation End ----");
      $finish;
    
        
		

	end
      
endmodule