module Sync_And_Debounce(
		input 																input_data,
		input 															control_clock,
		output 															  output_data
		);
		
			wire synced_signal;
		
		Flip_Flop Flip_Flop(
			.input_data													 (input_data),
			.control_clock											 (control_clock),
			.output_data											 (synced_signal)
		);
		
		Debouncer #(3) Debouncer(
			.synced_signal											 (synced_signal),
			.control_clock											 (control_clock),
			.debounced													(output_data)
		);
		
endmodule 