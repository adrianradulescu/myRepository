module Test_Module();

			`include "send_valid_packet.v"
			`include "send_invalid_packet_with_control_error_LSB.v"
			`include "send_invalid_packet_with_control_error_MSB.v"
			`include "send_invalid_packet_with_parity_error_paritybit.v"
			`include "send_invalid_packet_with_parity_error_pseudorandom_bit.v"

			parameter FAST_PERIOD  				  	=  2;
			parameter SLOW_PERIOD 				  	= 20;

			reg		 			 	  				  f_clk;
			reg					 	  					 clk;
			reg 		  							  	   data;
			wire	[7 : 0]		    interface_out_data;
		
		Top_I2C_interface UUT(
			.data(data),
			.clk(clk),
			.f_clk(f_clk),
			.interface_output_data(interface_out_data)
		);

		initial begin
			f_clk = 1'b0;
			#(FAST_PERIOD/2);
			forever
				#(FAST_PERIOD/2) f_clk = ~f_clk;
		end

		initial begin
			#20  send_valid_packet(2'h23);
			#400 send_valid_packet(2'h43);
			#400 send_valid_packet(2'h21);
			#400 send_valid_packet(2'h42);
			#400 send_valid_packet(2'h32);
			#400 send_valid_packet(2'h3C);
			#400 send_valid_packet(2'h2C);
			#400 send_valid_packet(2'h2C);
			#400 send_valid_packet(2'h5A);
			#400 send_invalid_packet_with_parity_error_pseudorandom_bit(2'h42);
			#400 send_invalid_packet_with_parity_error_paritybit(2'h24);
			#400 send_invalid_packet_with_control_error_MSB(2'h42);
			#400 send_invalid_packet_with_control_error_LSB(2'h53);
		end

endmodule 