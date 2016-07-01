module Synchronization_and_Debounce(
		input 										 				input_data,
		input 									  				control_clock,
		output									    			  output_data
	); 

		wire 										  				  synced_data;
	
	Flip_Flop Flip_Flop(
		.input_data								   			 (input_data),
		.control_clock										 (control_clock),
		.output_data							  				(synced_data)
	);
	
	Debouncer #(3) Debouncer(
		.synced_signal										   (synced_data),
		.control_clock										 (control_clock),
		.debounced								  				(output_data)
	);
	
endmodule 
