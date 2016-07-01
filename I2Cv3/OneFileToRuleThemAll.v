module Top_I2C_interface(
		input 										 					  data,
		input 										  		 			   clk,
		input 											   			 f_clk,
		output [7 : 0]					   	   interface_output_data
	);
	
		wire 						 			counter_threshold_triggered;
		wire 											 bit_for_parity_check;
		wire [1 : 0]							  			 comm_init_bits;
		wire [7 : 0]								 parallel_data_buffer;
		wire 										  				  slow_clock;
		wire 										  				  fast_clock;
		wire [3 : 0]					 			  slow_counter_output;
		wire 									   			  strobe_enable;
		wire 													   enable_check;
		wire 									 				parity_detected;
		wire 														synced_clock;
		
		assign 								  			fast_clock = f_clk;
		assign 								  			slow_clock =   clk;
	
	Synchronization_and_Debounce_Shift_Register Synchronization_and_Debounce_Shift_Register(
		.data											  					(data),
		.control_clock											(fast_clock),
		.raw_clock												(slow_clock),
		.confirm_send_data		    (counter_threshold_triggered),
		.synced_clock							  			 (synced_clock),
		.parity_check_bit				  		  (bit_for_parity_check),
		.comm_init_bits								  (comm_init_bits),
		.parallel_data_buffer		  		  (parallel_data_buffer)
	);
	
	Counter #(4) Slow_Counter(
		.control_clock							  			 (synced_clock),
		.counter_output					   	(slow_counter_output)
	);
	
	Counter_Threshold_Trigger Counter_Threshold_Trigger(
		.input_from_counter				  		(slow_counter_output),
		.is_valid				  		 (counter_threshold_triggered)
	);
	
	// de verificat daca merge macar cu ceasul incet
	Strobe_Generator_Enable Strobe_Generator_Enable(
		.input_from_counter				  		(slow_counter_output),
		.control_clock							   			(fast_clock),
		.is_valid											(strobe_enable)
	);
	
	Strobe_Generator_When_Full Strobe_Generator_When_Full(
		.control_clock							   			(fast_clock),
		.strobe_generator_enable			    		(strobe_enable),
		.validation_strobe						 		 (enable_check)
	);
	
	Parity_Checker Parity_Checker(
		.scan_code_for_check			 		  (parallel_data_buffer),
		.comm_init_bits						   	  (comm_init_bits),
		.parity_check_bit				 		  (bit_for_parity_check),
		.validation_signal					  		 (parity_detected)
	);
	
	Data_Output_Register Data_Output_Register(
		.control_clock							   			(fast_clock),
		.parity_detected					  			 (parity_detected),
		.strobe_detected						 			 (enable_check),
		.scan_code_for_buffering		 	  (parallel_data_buffer),
		.interface_data_out				    (interface_output_data)
	);
	
endmodule
