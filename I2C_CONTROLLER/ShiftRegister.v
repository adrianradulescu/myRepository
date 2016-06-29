`timescale 1ns / 1ps
module ShiftRegister	
  #(parameter REGISTER_SIZE = 11)
	(	input 							 CONTROL_CLOCK,
		input 							DEBOUNCED_DATA,
		output reg [7 : 0]	PARALLEL_DATA_OUTPUT,
		output reg					 PARITY_CHECK_BIT
    );

		reg [REGISTER_SIZE - 1 : 0] SHIFT_REGISTER;
		
		always@(posedge CONTROL_CLOCK) 
			SHIFT_REGISTER <= {SHIFT_REGISTER[REGISTER_SIZE - 1 : 0], 
									 DEBOUNCED_DATA};
		
		reg [3:0] COUNTER_REGISTER = 4'b000;
		
		always@(posedge CONTROL_CLOCK)
			if(COUNTER_REGISTER == 4'b1011) begin 
				PARALLEL_DATA_OUTPUT <= SHIFT_REGISTER[9:2];
				PARITY_CHECK_BIT		<= SHIFT_REGISTER[1]	 ;
				COUNTER_REGISTER 		<= 4'b0000				 ;	
				end
				
		always@(posedge CONTROL_CLOCK)
				COUNTER_REGISTER 		<= COUNTER_REGISTER + 1;
endmodule
