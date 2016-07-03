module Counter_Threshold_Trigger(
		input 														 overflow_signal,
		input 														   is_overflowed
		);
		
		assign is_overflowed = (overflow_signal)?(1):(0);
		
endmodule
