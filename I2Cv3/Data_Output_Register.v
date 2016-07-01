module Data_Output_Register(
		input 													control_clock,
		input 										  		 parity_detected,
		input 										  		 strobe_detected,
		input 	   [7 : 0] 					  scan_code_for_buffering,
		output reg  [7 : 0] 						    interface_data_out
	);
	
	always@(posedge control_clock) begin
		if(parity_detected && strobe_detected)
			interface_data_out <= scan_code_for_buffering;
	end
	
endmodule 