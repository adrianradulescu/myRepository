module Strobe_Generator_Enable(
		input 									 	 			control_clock,
		input 		[3
		: 0] 				    		 input_from_counter,
		output reg										 			  is_valid
	);
		
		always @ (posedge control_clock)
			if(input_from_counter == 4'b1011)
				is_valid <= 1;
			else 
				is_valid <= 0;
			
endmodule	
