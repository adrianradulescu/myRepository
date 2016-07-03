module Counter #(parameter COUNTER_SIZE = 4)(
		input 															control_clock,
		input 												 control_counter_reset,
		input 												control_counter_enable,
		output reg										 control_counter_overflow,
		output reg [COUNTER_SIZE - 1: 0] 					  counter_output
		);
		
		reg [COUNTER_SIZE - 1 : 0] 							counter_register;
		
		always@(negedge control_clock) begin
			if(control_counter_reset) begin
				counter_register <= 0;
				end // if
				else if(control_counter_enable) begin
						  counter_register <= counter_register + 1;
					  end // if
					 
			if(counter_register == 4'b1001) begin
				control_counter_overflow <= 1;
			end // if
		end // always
endmodule 