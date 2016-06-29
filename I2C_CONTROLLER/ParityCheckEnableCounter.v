module ParityCheckEnableCounter(
			input 	  DEBOUNCED_CLK,
			output 	  		 REG_FULL
    );
	 
	 reg [3:0] INTERNAL_REGISTER = 4'b0000;
	 
	 always@(posedge DEBOUNCED_CLK)
		
endmodule
