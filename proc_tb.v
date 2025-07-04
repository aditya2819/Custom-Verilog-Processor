`timescale 1ns / 1ps

module proc_tb;

    reg clk;
    reg sys_rst;
    reg [15:0] din;
    wire [15:0] dout;

    // Instantiate the processor
    top uut (
        .clk(clk),
        .sys_rst(sys_rst),
        .din(din),
        .dout(dout)
    );

    // Clock generator
    always #5 clk = ~clk;

    // Simulation memory write helper
    task write_instructions();
        integer fd;
        begin
            fd = $fopen("inst_data.mem", "w");

            // Instruction Format: opcode | rdst | rsrc1 | imm_mode | rsrc2 | imm
            // Binary encoding will vary depending on specific test

            // MOV R1, #5 (imm)
            $fwrite(fd, "00001_00001_00000_1_00000_000000000101\n");

            // MOV R2, #3
            $fwrite(fd, "00001_00010_00000_1_00000_000000000011\n");

            // ADD R3, R1, R2
            $fwrite(fd, "00010_00011_00001_0_00010_000000000000\n");

            // SUB R4, R1, R2
            $fwrite(fd, "00011_00100_00001_0_00010_000000000000\n");

            // MUL R5, R1, R2
            $fwrite(fd, "00100_00101_00001_0_00010_000000000000\n");

            // ROR R6, R1, R2
            $fwrite(fd, "00101_00110_00001_0_00010_000000000000\n");

            // RNOT R7, R1
            $fwrite(fd, "01011_00111_00001_0_00000_000000000000\n");

            // STOREREG: Store R1 → MEM[2]
            $fwrite(fd, "01101_00000_00001_1_00000_000000000010\n");

            // SENDREG: Load R8 ← MEM[2]
            $fwrite(fd, "10001_01000_00000_1_00000_000000000010\n");

            // SENDDOUT: dout ← MEM[2]
            $fwrite(fd, "01111_00000_00000_1_00000_000000000010\n");

            // JUMP → 13
            $fwrite(fd, "10010_00000_00000_1_00000_000000001101\n");

            // Dummy (skipped if jump works)
            $fwrite(fd, "00001_01001_00000_1_00000_000000111111\n");

            // MOV R9 ← #9 (check jump landed here)
            $fwrite(fd, "00001_01001_00000_1_00000_000000001001\n");

            // HALT
            $fwrite(fd, "11011_00000_00000_0_00000_000000000000\n");

            $fclose(fd);
        end
    endtask

    // Stimulus
    initial begin
        $display("Starting Simulation...");
        clk = 0;
        sys_rst = 1;
        din = 16'h0000;

        // Write instructions to file
        write_instructions();

        #20;
        sys_rst = 0;

        // Provide data input if needed later
        din = 16'h00FF;

        // Monitor changes
        $monitor("Time=%0t | dout=%0h", $time, dout);

        // Run long enough for full program
        #500 $finish;
    end

endmodule

//To run use folloeing commands
//iverilog -o proc_tb.vvp top.v proc_tb.v
//vvp proc_tb.vvp
//Ensure inst_data.mem file is in simulation directory
