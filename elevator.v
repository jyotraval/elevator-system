`timescale 1ns / 1ps

module elevator (
    input clk, reset,
    input [4:0] r_f, // request
    output reg [4:0] t_f, // targeted floor
    output reg [2:0] state_out, // output state
    output reg door // door control signal 1 open, 0 close
);

    reg [2:0] state = 3'b000; // 0 idle 1 moving 2=10 stop
    reg [4:0] c_f = 5'b00000; // current floor
    reg [4:0] q_f = 5'b00000; // queue
    reg [4:0] prev_r_f = 5'b00000; // previous request
    //when positive of clock the loop will run
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            c_f <= 5'b00000;
            t_f <= 5'b00000;
            q_f <= 5'b00000;
            door <= 1'b0;
            prev_r_f <= 5'b00000;
        end else begin
            prev_r_f <= r_f;

            case (state)
                3'b000: //idle state
                begin 
                    door <= 1'b0;
                    if (r_f != prev_r_f) begin //if there is new request
                        t_f <= r_f;
                        state <= 3'b001; // idle --> moving 
                    end
                end

                3'b001: //moving 
                begin
                    door <= 1'b0;
                    if (c_f < t_f) begin
                        c_f <= c_f + 1;
                    end else if (c_f > t_f) begin
                        c_f <= c_f - 1;
                    end else begin
                        state <= 3'b010; // transition to stop
                    end

                    //check for new requests while moving/movement.
                    if (r_f != prev_r_f && !q_f) begin
                        q_f <= r_f;
                    end
                end

                3'b010: //stop
                begin
                    door <= 1'b1; // door open
                    if (q_f != 5'b00000) begin
                        t_f <= q_f;
                        q_f <= 5'b00000;
                        state <= 3'b001; //back to moving 
                    end else begin
                        door <= 1'b0; // door close
                        state <= 3'b000; // back to isle
                    end
                end

                default:
                begin
                    state <= 3'b000; // defult-- idle of any other conditions
                    door <= 1'b0;
                end
            endcase
        end
    end

    always @(state) begin
        state_out <= state;
    end

endmodule
