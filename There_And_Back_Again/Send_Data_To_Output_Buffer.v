module Send_Data_To_Output_Buffer(
		//input  enabling_strobe_signal,
		input  														parity_detection,
		output 										  send_data_to_output_buffer
	);
	
		assign send_data_to_output_buffer = (parity_detection)?(1):(0);
	
endmodule
