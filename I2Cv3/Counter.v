module Counter #(parameter COUNTER_SIZE = 4)(
		input 								control_clock,
		output [3 : 0]					  counter_output
    );
	 
	 reg [3 : 0] internal_register = 4'b0000;

	always @ (posedge control_clock)
		internal_register <= internal_register + 1;
		
	assign counter_output = internal_register;
	
endmodule
