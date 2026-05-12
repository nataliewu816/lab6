module top (
    input  logic CLK,
    output logic LCD_CLK,
    //Exercise 2 and 3
    input  logic spi_clk,
    input  logic spi_cs,
    input  logic spi_mosi,
    output logic LCD_DEN,
    output logic [4:0] LCD_R,
    output logic [5:0] LCD_G,
    output logic [4:0] LCD_B
);

logic [15:0] pixel;
logic [7:0]  pixel_address;

//Exercise 2
logic we;
logic [7:0]  waddr;
logic [15:0] wdata;


assign LCD_CLK = CLK;

//Exercise 2 and 3
spi_slave spi_inst (
    .clk(CLK),
    .spi_clk(spi_clk),
    .spi_cs(spi_cs),
    .spi_mosi(spi_mosi),
    .we(we),
    .waddr(waddr),
    .wdata(wdata)
);

dp_buffer sprite_buf (
    .clk(CLK),
    .raddr(pixel_address),
    .rdata(pixel),
    //Exercise 2 and 3
    .we(we),
    .waddr(waddr),
    .wdata(wdata)
);


lcd lcd_inst (
    .pclk(CLK),
    .pixel(pixel),
    .pixel_address(pixel_address),
    .LCD_DEN(LCD_DEN),
    .LCD_R(LCD_R),
    .LCD_G(LCD_G),
    .LCD_B(LCD_B)
);

endmodule