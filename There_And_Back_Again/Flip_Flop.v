module Flip_Flop(
	input 											 						input_data,
	input 										  						control_clock,
	output reg 															  output_data
	);

	always@(posedge control_clock) begin
		output_data <= input_data;
	end
	
endmodule 