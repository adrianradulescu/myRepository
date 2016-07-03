module Data_Parallelization #(parameter REG_SIZE = 9)(
		input 													  serial_data_input,
		input 												  shift_control_signal,
		input 															  data_accept,
		input 													  confirm_send_data,
		output reg 													parity_check_bit,
		output reg [REG_SIZE - 2 : 0] 								 scan_code
		);
		
		reg [REG_SIZE - 1 : 0] 									  shift_register;
		
	always@(negedge shift_control_signal) begin
		if(data_accept) begin 
			shift_register <= {shift_register				[REG_SIZE - 1: 1], 
									 serial_data_input
									 };
		end // if
	end // always
	
	always@(*) begin
		if(confirm_send_data) begin
			scan_code[0] 	  <= shift_register[8];
			scan_code[1] 	  <= shift_register[7];
			scan_code[2] 	  <= shift_register[6];
			scan_code[3] 	  <= shift_register[5];
			scan_code[4] 	  <= shift_register[4];
			scan_code[5] 	  <= shift_register[3];
			scan_code[6] 	  <= shift_register[2];
			scan_code[7] 	  <= shift_register[1];
			parity_check_bit <= shift_register[0];
		end // if
	end // always
	
endmodule
