module Strobe_Generator_When_Full(
		input  										 			control_clock,
		input  							   	  strobe_generator_enable,
		output reg 								 		  validation_strobe
	);
	
	always @ (posedge control_clock)
		if(strobe_generator_enable)
			validation_strobe <= 1;
		else
			validation_strobe <= 0;
	
endmodule 