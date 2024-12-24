// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// Generated by Quartus Prime Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition
// Created on Tue Dec 24 03:03:15 2024

// synthesis message_off 10175

`timescale 1ns/1ns

module piezo_sm (
    reset,clock,beep,door_beep,door_melody,stat_melody,
    out_beep,out_door,out_stat);

    input reset;
    input clock;
    input beep;
    input door_beep;
    input door_melody;
    input stat_melody;
    tri0 reset;
    tri0 beep;
    tri0 door_beep;
    tri0 door_melody;
    tri0 stat_melody;
    output out_beep;
    output out_door;
    output out_stat;
    reg out_beep;
    reg out_door;
    reg out_stat;
    reg [3:0] fstate;
    reg [3:0] reg_fstate;
    localparam stable=0,s_beep=1,s_door=2,s_stat=3;

    always @(posedge clock)
    begin
        if (clock) begin
            fstate <= reg_fstate;
        end
    end

    always @(fstate or reset or beep or door_beep or door_melody or stat_melody)
    begin
        if (reset) begin
            reg_fstate <= stable;
            out_beep <= 1'b0;
            out_door <= 1'b0;
            out_stat <= 1'b0;
        end
        else begin
            out_beep <= 1'b0;
            out_door <= 1'b0;
            out_stat <= 1'b0;
            case (fstate)
                stable: begin
                    if (((((beep == 1'b1) | (door_beep == 1'b1)) & (door_melody == 1'b0)) & (stat_melody == 1'b0)))
                        reg_fstate <= s_beep;
                    else if (((((beep == 1'b0) | (door_beep == 1'b0)) & (door_melody == 1'b1)) & (stat_melody == 1'b0)))
                        reg_fstate <= s_door;
                    else if (((((beep == 1'b0) | (door_beep == 1'b0)) & (door_melody == 1'b0)) & (stat_melody == 1'b1)))
                        reg_fstate <= s_stat;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= stable;

                    out_stat <= 1'b1;

                    out_beep <= 1'b1;

                    out_door <= 1'b1;
                end
                s_beep: begin
                    if (((((beep == 1'b0) | (door_beep == 1'b0)) & (door_melody == 1'b1)) & (stat_melody == 1'b0)))
                        reg_fstate <= s_door;
                    else if (((((beep == 1'b0) | (door_beep == 1'b0)) & (door_melody == 1'b0)) & (stat_melody == 1'b1)))
                        reg_fstate <= s_stat;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= s_beep;

                    out_stat <= 1'b1;

                    out_beep <= 1'b0;

                    out_door <= 1'b1;
                end
                s_door: begin
                    if (((((beep == 1'b1) | (door_beep == 1'b1)) & (door_melody == 1'b0)) & (stat_melody == 1'b0)))
                        reg_fstate <= s_beep;
                    else if (((((beep == 1'b0) | (door_beep == 1'b0)) & (door_melody == 1'b0)) & (stat_melody == 1'b1)))
                        reg_fstate <= s_stat;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= s_door;

                    out_stat <= 1'b1;

                    out_beep <= 1'b1;

                    out_door <= 1'b0;
                end
                s_stat: begin
                    if (((((beep == 1'b1) | (door_beep == 1'b1)) & (door_melody == 1'b0)) & (stat_melody == 1'b0)))
                        reg_fstate <= s_beep;
                    else if (((((beep == 1'b0) | (door_beep == 1'b0)) & (door_melody == 1'b1)) & (stat_melody == 1'b0)))
                        reg_fstate <= s_door;
                    // Inserting 'else' block to prevent latch inference
                    else
                        reg_fstate <= s_stat;

                    out_stat <= 1'b0;

                    out_beep <= 1'b1;

                    out_door <= 1'b1;
                end
                default: begin
                    out_beep <= 1'bx;
                    out_door <= 1'bx;
                    out_stat <= 1'bx;
                    $display ("Reach undefined state");
                end
            endcase
        end
    end
endmodule // piezo_sm