task send_package_scan_code;
	input [7 : 0] scan_code;
	begin
				initiate_comm();
		#30	scl  = 0;
				sda = scan_code[0];
		#10	scl  = 1;
		#10		scl  = 0;
				sda = scan_code[1];
		#10		scl  = 1;
		#10		scl  = 0;
				sda = scan_code[2];
		#10		scl  = 1;
		#10		scl  = 0;
				sda = scan_code[3];
		#10		scl  = 1;
		#10		scl  = 0;
				sda = scan_code[4];
		#10		scl  = 1;
		#10		scl  = 0;
				sda = scan_code[5];
		#10		scl  = 1;
		#10		scl  = 0;
				sda = scan_code[6];
		#10		scl  = 1;
		#10		scl  = 0;
				sda = scan_code[7];
		#10		scl  = 1;
		#10		scl  = 0;
				sda = scan_code[0]^
						 scan_code[1]^
						 scan_code[2]^
						 scan_code[3]^
						 scan_code[4]^
						 scan_code[5]^
						 scan_code[6]^
						 scan_code[7];
		#10		scl  = 1;
		#10		scl  = 0;
				end_comm();
		end
endtask		
			