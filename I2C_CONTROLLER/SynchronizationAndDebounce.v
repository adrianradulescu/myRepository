
module SynchronizationAndDebounce(
		input 						INPUT_DATA,
		input 						FAST_CLOCK,
		output			  	  	  OUTPUT_DATA
    );
	 
		wire 						  SYNCED_DATA;
		
	 FlipFlop 			  myFlipFlop(
		.INPUT_DATA			 	 (INPUT_DATA),
		.FAST_CLOCK			 	 (FAST_CLOCK),
		.OUTPUT_DATA			(SYNCED_DATA)
	 );

	Debouncer #(3) 	 myDebouncer(
		.SYNCED_SIGNAL			(SYNCED_DATA),
		.FAST_CLOCK				 (FAST_CLOCK),
		.DEBOUNCED			 	(OUTPUT_DATA)
	 );
	 
endmodule
