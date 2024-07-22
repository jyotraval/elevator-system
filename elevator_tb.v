`timescale 1ns / 1ps

module elevator_tb();
    reg clk = 0;
    reg reset = 0;
    reg [4:0] r_f; 
    wire [4:0] t_f;
    wire [2:0] state_out; 
    wire door; 
    //elevator dut (clk, reset, r_f, t_f, state_out, door);
    elevator dut (
        .clk(clk),
        .reset(reset),
        .r_f(r_f),
        .t_f(t_f),
        .state_out(state_out),
        .door(door)
    );
  

    always #5 clk = ~clk; // time period 10ns

    initial begin
        reset = 1;
        #20; //20ns break
        reset = 0;

        // single floor request
        r_f = 5'b00001;
        #50;

        //,ltiple req...queue
        r_f = 5'b00010; 
        #50; 

        // continuous req while moving
        r_f = 5'b00001; 
        #30; 
        r_f = 5'b00010; 
        #30; 
        r_f = 5'b00011; 
        #50; 
        $finish;//force quite simlutation / endloop
    end

    //display outputs in tclconsole
    always @(posedge clk) begin
        $display("At time %t, current state = %b, current floor = %d, door = %b", $time, state_out, dut.c_f, door);
    end

endmodule
