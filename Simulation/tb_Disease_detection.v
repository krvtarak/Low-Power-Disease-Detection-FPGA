`timescale 1ns / 1ps

module tb_Disease_detection;

    // Inputs
    reg clk_100MHz;
    reg [7:0] heart_rate_0;
    reg [7:0] spo2_0;

    // Output
    wire alert_0;

    // Instantiate DUT (Wrapper)
    Disease_detection_wrapper DUT (
        .clk_100MHz(clk_100MHz),
        .heart_rate_0(heart_rate_0),
        .spo2_0(spo2_0),
        .alert_0(alert_0)
    );

    // Clock generation (100 MHz → 10ns period)
    always #5 clk_100MHz = ~clk_100MHz;

    initial begin
        // Initialize
        clk_100MHz = 0;
        heart_rate_0 = 0;
        spo2_0 = 0;

        // -----------------------------
        // Case 1: Normal condition
        // HR = 80, SpO2 = 95 → alert = 0
        // -----------------------------
        #20;
        heart_rate_0 = 8'd80;
        spo2_0 = 8'd95;

        // -----------------------------
        // Case 2: High heart rate
        // HR = 130 → alert = 1
        // -----------------------------
        #40;
        heart_rate_0 = 8'd130;
        spo2_0 = 8'd95;

        // -----------------------------
        // Case 3: Low SpO2
        // SpO2 = 85 → alert = 1
        // -----------------------------
        #40;
        heart_rate_0 = 8'd85;
        spo2_0 = 8'd85;

        // -----------------------------
        // Case 4: Back to normal
        // HR = 75, SpO2 = 97 → alert = 0
        // -----------------------------
        #40;
        heart_rate_0 = 8'd75;
        spo2_0 = 8'd97;

        // -----------------------------
        // Case 5: Both abnormal
        // HR high & SpO2 low → alert = 1
        // -----------------------------
        #40;
        heart_rate_0 = 8'd140;
        spo2_0 = 8'd80;

        #100;
        $finish;
    end

endmodule
