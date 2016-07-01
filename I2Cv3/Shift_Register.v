
module Shift_Register #(parameter REGISTER_SIZE = 11)(
		input 													control_clock,
		input 											  confirm_send_data,
		input 									   		  debounced_data,
		output reg [7 : 0]	 					  parallel_data_buffer,
		output reg [1 : 0] 						  		  comm_init_bits,
		output reg		 						 			parity_check_bit
	);
	
		reg [REGISTER_SIZE - 1 : 0] 			   	  shift_register;
		
		always @ (negedge control_clock) begin
			if(confirm_send_data) begin
				parallel_data_buffer <= 	  		shift_register[8:1];
				parity_check_bit 	 	<= 			shift_register[9]  ;
				comm_init_bits 		<= 	   	{shift_register[0] ,
															 shift_register[10]};
			end // if
		end // always
		
		always @ (negedge control_clock)
			shift_register <= {shift_register[REGISTER_SIZE - 1 : 0],
									 debounced_data};

endmodule 