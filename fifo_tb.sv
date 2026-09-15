`timescale 1ns/1ps

module fifo_tb;

    logic clk;
    logic reset;
    logic write_en;
    logic read_en;
    logic [7:0] write_data;

    logic [7:0] read_data;
    logic full;
    logic empty;

    // Create our FIFO inside the testbench
    fifo dut (
        .clk(clk),
        .reset(reset),
        .write_en(write_en),
        .read_en(read_en),
        .write_data(write_data),
        .read_data(read_data),
        .full(full),
        .empty(empty)
    );

    // Generate clock
    always #5 clk = ~clk;

    initial begin

        $dumpfile("fifo.vcd");
        $dumpvars(0, fifo_tb);

        // Starting values
        clk        = 0;
        reset      = 1;
        write_en   = 0;
        read_en    = 0;
        write_data = 0;

        // Reset the FIFO
        #10;
        reset = 0;

        // Write 10
        write_data = 8'd10;
        write_en = 1;
        #10;

        // Write 20
        write_data = 8'd20;
        #10;

        // Write 30
        write_data = 8'd30;
        #10;

        // Stop writing
        write_en = 0;

        // Read first value
        read_en = 1;
        #10;

        // Read second value
        #10;

        // Read third value
        #10;

        // Stop reading
        read_en = 0;

        #10;
        $finish;

    end

endmodule