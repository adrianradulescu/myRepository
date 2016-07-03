module Synchronization_And_Debouncing(
		input 																 sda_input,
		input 																 scl_input,
		input 															control_clock,
		output 								  synced_and_debounced_data_output,
		output 								 synced_and_debounced_clock_output
		);
		
		Sync_And_Debounce Sync_And_Debounce_SDA(
			.input_data													  (sda_input),
			.control_clock											 (control_clock),
			.output_data					(synced_and_debounced_data_output)
		);
		
		Sync_And_Debounce Sync_And_Debounce_SCL(
			.input_data													  (scl_input),
			.control_clock											 (control_clock),
			.output_data				  (synced_and_debounced_clock_output)
		);
		
endmodule 