module FlipFlop(
		input 			  INPUT_DATA,
		input 	  		  FAST_CLOCK,
		output reg		  OUTPUT_DATA
    );
	 
	 always@(posedge FAST_CLOCK)
		OUTPUT_DATA <= INPUT_DATA;

endmodule
