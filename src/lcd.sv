module lcd (
    input  logic pclk,
    input  logic [15:0] pixel,
    output logic [7:0] pixel_address,
    output logic LCD_DEN,
    output logic [4:0] LCD_R,
    output logic [5:0] LCD_G,
    output logic [4:0] LCD_B
);

localparam width = 480;
localparam height = 272;
localparam xBuffer  = 525;
localparam yBuffer  = 285;

logic [9:0] x = 0;
logic [8:0] y = 0;

always_ff @(posedge pclk) begin
    if (x == xBuffer - 1) begin
        x <= 0;
        if (y == yBuffer - 1)
            y <= 0;
        else
            y <= y + 1;
    end else begin
        x <= x + 1;
    end
end

assign LCD_DEN = (x < width) && (y < height);
assign pixel_address = (y[3:0] * 16) + x[3:0];
assign LCD_R = LCD_DEN ? pixel[15:11] : 5'd0;
assign LCD_G = LCD_DEN ? pixel[10:5]  : 6'd0;
assign LCD_B = LCD_DEN ? pixel[4:0]   : 5'd0;

endmodule