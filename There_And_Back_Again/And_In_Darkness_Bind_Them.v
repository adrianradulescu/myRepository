module Top_I2C_interface(
		input 										 								sda,
		input 											   						scl,
		input 									     				 	  fpga_clock,
		output [7 : 0]					  				  	interface_output_data
	);
	
		wire 									 synced_and_debounced_data_output;
		wire 								   synced_and_debounced_clock_output;
		wire 										 			 shift_control_signal;
		wire 												   	 confirm_send_data;
		wire 														  parity_check_bit;
		wire 	 [7 : 0]										 parallel_data_buffer;
		wire 											 	 communication_initiated;
		wire 											  	  control_counter_enable;
		wire 	 [3 : 0]								  	  control_counter_output;
		wire 											   	control_counter_reset;
		wire 												 	  communication_ended;
		wire 														 		 aknowledged;
		wire 												control_counter_overflow;
		wire 															  strobe_enable;
		wire 													  enable_parity_check;
		wire is_communicating;
		assign shift_control_signal = synced_and_debounced_clock_output;
		
	Synchronization_And_Debouncing Synchronization_And_Debouncing(
		.sda_input													 		    (sda),
		.scl_input														   	 (scl),
		.control_clock													(fpga_clock),
		.synced_and_debounced_data_output	 (synced_and_debounced_sda),
		.synced_and_debounced_clock_output	 (synced_and_debounced_scl)
		);
		
	Data_Parallelization #(9) Data_Parallelization(
		.serial_data_input						 (synced_and_debounced_sda),
		.shift_control_signal					 (synced_and_debounced_scl),
		.data_accept										 (data_accept_enable),
		.confirm_send_data								(communication_ended),
		.parity_check_bit									   (parity_check_bit),
		.scan_code										  (parallel_data_buffer)
		);
		
	Communication_Init_And_End_Detector Communication_Init_And_End_Detector(
		.synced_sda_input							 (synced_and_debounced_sda),
		.synced_scl_input							 (synced_and_debounced_scl),
		.is_communicating										(is_communicating),
		.communication_initiated				  (communication_initiated),
		.communication_ended							   (communication_ended)
		);
		
	Communication_Detector Communication_Detector(
		.communication_initiated				  (communication_initiated),
		.communication_ended							   (communication_ended),
		.data_accept_enable								 (data_accept_enable)
		);
	
	Counter_Threshold_Trigger Counter_Threshold_Trigger(
		.overflow_signal				 			 (control_counter_overflow),
		.is_overflowed			    				  	 (control_counter_reset)
		);
		
	Counter #(4) Control_Counter(
		.control_clock					 (synced_and_debounced_clock_output),
		.control_counter_reset						   (communication_ended),
		.control_counter_enable					  (communication_initiated),
		.control_counter_overflow				 (control_counter_overflow),
		.counter_output								(control_counter_output)
		);
		
	Communication_Selector Communication_selector(
		.communication_initiated				  (communication_initiated),
		.communication_ended								(communication_ended),
		.is_communicating										(is_communicating)
		);

/*	Identific initierea si finalizarea communicatiei in alt mod
	Strobe_Generator_Enable Strobe_Generator_Enable(
		.data_ready_to_send								  (confirm_send_data),
		.control_clock													(fpga_clock),
		.is_valid													(strobe_enable)
		);
		
	Strobe_Generator_When_Full Strobe_Generator_When_Full(
		.control_clock							   					(fast_clock),
		.strobe_generator_enable			    				(strobe_enable),
		.validation_strobe				  				(enable_parity_check)
	);
*/
	
	Parity_Checker Parity_Checker(
		.scan_code_for_check			 				  (parallel_data_buffer),
		.parity_check_bit				 	 					(parity_check_bit),
		.validation_signal					  				 (parity_detected)
	);
	
	Send_Data_To_Output_Buffer	Confirm_Send_Data_To_Output_Buffer(
		//.enabling_strobe_signal						(enable_parity_check),
		.parity_detection										 (parity_detected),
		.send_data_to_output_buffer				  (output_buffer_enable)
	);
	
	Data_Output_Register Data_Output_Register(
		.control_clock							   					(fast_clock),
		.output_buffer_enable						  (output_buffer_enable),
		.scan_code_for_buffering		 			  (parallel_data_buffer),
		.interface_data_out				   		 (interface_output_data)
	);
	
endmodule 