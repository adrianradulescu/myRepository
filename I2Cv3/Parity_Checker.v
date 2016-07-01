module Parity_Checker(
		input [7:0] 									scan_code_for_check,
		input [1:0] 								 		  comm_init_bits,
		input 									   		parity_check_bit,
		output 	  							  		  	  validation_signal
	);
		
	assign validation_signal = ((
					scan_code_for_check[0] ^
					scan_code_for_check[1] ^
					scan_code_for_check[2] ^
					scan_code_for_check[3] ^
					scan_code_for_check[4] ^ 
					scan_code_for_check[5] ^
					scan_code_for_check[6] ^
					scan_code_for_check[7] == 
					parity_check_bit)&& 
					(comm_init_bits	== 2'b00))?(1):(0);

endmodule
