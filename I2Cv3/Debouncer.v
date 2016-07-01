module Debouncer  #(parameter FILTER_WIDTH = 3)
	(
		input 									  				synced_signal,
		input 									  				control_clock,
		output reg 									  				 debounced
	);
	
	reg [FILTER_WIDTH : 0] shifter;
	
	always @ (posedge control_clock) begin
		if(shifter[FILTER_WIDTH : 1] == 3'b000) begin
			debounced <= 0;
		end // if
			else if (shifter[FILTER_WIDTH : 1] == 3'b111) begin
				debounced <= 1;
			end // else
		
		shifter <= {shifter[FILTER_WIDTH - 1 : 0], synced_signal};
	end //always
	
endmodule
