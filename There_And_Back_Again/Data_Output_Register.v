module Data_Output_Register(
		input 															control_clock,
		input 												  output_buffer_enable,
		input 		[7 : 0] 							  scan_code_for_buffering,
		output reg 	[7 : 0] 									 interface_data_out
	);
	
	always@(posedge control_clock)
		if(output_buffer_enable)
			interface_data_out <= scan_code_for_buffering;

endmodule 