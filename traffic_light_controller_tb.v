module Traffic_Light_Controller_TB;

    reg clk, rst;
    wire [2:0] light_M1;
    wire [2:0] light_S;
    wire [2:0] light_MT;
    wire [2:0] light_M2;

    // Instantiate the Traffic_Light_Controller module
    Traffic_Light_Controller dut (
        .clk(clk),
        .rst(rst),
        .light_M1(light_M1),
        .light_S(light_S),
        .light_MT(light_MT),
        .light_M2(light_M2)
    );

    // Generate the clock signal
    initial begin
        clk = 1'b0;
        forever #(5) clk = ~clk;  // 10 time units clock period
    end

    // Apply the reset and other test stimuli
    initial begin
        rst = 1'b0;
        #10 rst = 1'b1;  // Apply reset
        #20 rst = 1'b0;  // Release reset

        // Run simulation for sufficient time to observe state transitions
        #1000;
        $finish;
    end

    // Monitor the outputs
    initial begin
        $monitor("Time=%0d: clk=%b, rst=%b, light_M1=%b, light_S=%b, light_MT=%b, light_M2=%b",
                 $time, clk, rst, light_M1, light_S, light_MT, light_M2);
    end

    // VCD Dump
    initial begin
        $dumpfile("traffic_light_controller_tb.vcd"); // Specify the VCD file name
        $dumpvars(0, Traffic_Light_Controller_TB);    // Dump all variables
    end

endmodule
