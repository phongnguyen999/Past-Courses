`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:42:56 12/08/2013 
// Design Name: 
// Module Name:    2_4_decoder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module 2_4_decoder
(
  input wire[1:0] x,
  input wire en,
  output wire[3:0] y
);

  assign y[3] = en & ( ~x[1] & ~x[0] );
  assign y[2] = en & ( ~x[1] & x[0] );
  assign y[1] = en & ( x[1] & ~x[0] );
  assign y[0] = en & ( x[1] & x[0] );

endmodule
