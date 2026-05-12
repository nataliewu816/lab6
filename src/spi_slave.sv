module spi_slave (
    input  logic clk,
    input  logic spi_clk,
    input  logic spi_cs,
    input  logic spi_mosi,
    output logic we,
    output logic [7:0] waddr,
    output logic [15:0] wdata
);

logic [15:0] shift_reg = 0;
logic [4:0] bit_count = 0;
logic spi_cs_prev = 1;

always_ff @(posedge spi_clk) begin
    if (!spi_cs) begin
        shift_reg <= {shift_reg[14:0], spi_mosi};
        bit_count <= bit_count + 1;
    end
end

always_ff @(posedge clk) begin
    spi_cs_prev <= spi_cs;
    if (spi_cs && !spi_cs_prev) begin
        wdata <= shift_reg;
        we <= 1;
        if (waddr == 255)
            waddr <= 0;
        else
            waddr <= waddr + 1;
    end else begin
        we <= 0;
    end
end

endmodule