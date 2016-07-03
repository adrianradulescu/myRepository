module Test_Module_Top();

			`include "Keyboard_Keys_Codes.v"
			`include "initiate_comm.v"
			`include "end_comm.v"
			`include "send_package_scan_code.v"
			
			parameter FAST_PERIOD = 2;
	

			reg		 			 	  									  fpga_clock;
			reg					 	  					 							scl;
			reg 		  							  	   						   sda;
			wire	[7 : 0]		    						interface_output_data;
		
		
		Top_I2C_interface DUT(
		.sda																		  (sda),
		.scl																		  (scl),
		.fpga_clock														 (fpga_clock),
		.interface_output_data						  (interface_output_data)
	);

		initial begin
			fpga_clock = 1'b0;
			#(FAST_PERIOD/2);
			forever
				#(FAST_PERIOD/2) fpga_clock = ~fpga_clock;
		end
		
		initial begin
				sda = 1;
				scl = 1;
		#100
				send_package_scan_code(D);
		#100
				send_package_scan_code(I);
		#100
				send_package_scan_code(C);
		#100
				send_package_scan_code(K);
		#100
				send_package_scan_code(B);
		#100
				send_package_scan_code(U);
		#100
				send_package_scan_code(T);
		#100
				send_package_scan_code(T);
		end	

endmodule
