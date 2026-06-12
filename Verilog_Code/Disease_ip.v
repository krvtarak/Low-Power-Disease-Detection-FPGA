module Disease_ip(
    input clk,
    input [7:0] heart_rate,
    input [7:0] spo2,
    output reg alert
);
always @(posedge clk) begin
    if (heart_rate > 8'd120 || spo2 < 8'd90)
        alert <= 1'b1;
    else
        alert <= 1'b0;
end
endmodule
