module fifo (
    input  logic       clk,
    input  logic       reset,
    input  logic       write_en,
    input  logic       read_en,
    input  logic [7:0] write_data,

    output logic [7:0] read_data,
    output logic       full,
    output logic       empty
);

    logic [7:0] memory [0:3];

    logic [1:0] write_ptr;
    logic [1:0] read_ptr;
    logic [2:0] count;

    assign empty = (count == 0);
    assign full  = (count == 4);

    always_ff @(posedge clk) begin
    if (reset) begin
        write_ptr <= 0;
    end
    else if (write_en && !full) begin
        memory[write_ptr] <= write_data;
        write_ptr <= write_ptr + 1;
    end
end

always_ff @(posedge clk) begin
    if (reset) begin
        read_ptr  <= 0;
        read_data <= 0;
    end
    else if (read_en && !empty) begin
        read_data <= memory[read_ptr];
        read_ptr  <= read_ptr + 1;
    end
end

always_ff @(posedge clk) begin
    if (reset) begin
        count <= 0;
    end
    else begin
        case ({write_en && !full, read_en && !empty})

            2'b10: count <= count + 1;

            2'b01: count <= count - 1;

            2'b11: count <= count;

            default: count <= count;

        endcase
    end
end

endmodule