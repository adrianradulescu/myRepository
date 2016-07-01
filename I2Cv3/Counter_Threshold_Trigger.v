module Counter_Threshold_Trigger(
		input	[3 : 0]					   			 input_from_counter,
		output  												 		  is_valid
	);
	
	assign is_valid = (input_from_counter == 4'b1011)?(1):(0);
	
endmodule

