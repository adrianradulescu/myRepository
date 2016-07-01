module Synchronization_and_Debounce_Shift_Register(
	   input 													  	     data,
		input 										 	 		 	raw_clock,
	   input 									  			  control_clock,
	   input 								  			 confirm_send_data,
		output	  								   			synced_clock,
	   output  			  					   		  parity_check_bit,
	   output [1 : 0]								 		 comm_init_bits,
      output [7 : 0]						   	 parallel_data_buffer
	);
	
		wire 										 				  slow_clock;
		wire 										 				  fast_clock;
		wire 								  				 data_for_shifting;
		wire									 					  sync_clock;
	
		assign 						  		  slow_clock = 	raw_clock;
		assign 						 		 fast_clock = control_clock;
		assign								  sync_clock = synced_clock;
		
	Synchronization_and_Debounce Synchronization_and_Debounce_Data(
		.input_data														 (data),
		.control_clock							   			 (fast_clock),
		.output_data									(data_for_shifting)
	);
	
	Synchronization_and_Debounce Synchronization_and_Debounce_Clock(
		.input_data												  (raw_clock),
		.control_clock							   			 (fast_clock),
		.output_data							 			  (synced_clock)
	);
	
	Shift_Register #(11) Shift_Register(
		.control_clock							   		  (synced_clock),
		.confirm_send_data							(confirm_send_data),
		.debounced_data								(data_for_shifting),
		.parallel_data_buffer			  		(parallel_data_buffer),
		.comm_init_bits						   		(comm_init_bits),
		.parity_check_bit					 			 (parity_check_bit)
	);
	
endmodule 