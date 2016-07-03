module Test_Module();

			`include "send_valid_packet.v"
			`include "send_invalid_packet_with_control_error_LSB.v"
			`include "send_invalid_packet_with_control_error_MSB.v"
			`include "send_invalid_packet_with_parity_error_paritybit.v"
			`include "send_invalid_packet_with_parity_error_pseudorandom_bit.v"
// Varianta noua - cand primeste date, porneste si counterul intern


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
			#20  send_valid_packet(8'b00011000, 1'b0);
			#400 send_valid_packet(8'b00110100, 1'b1);
			#400 send_valid_packet(8'b00110100, 1'b1);
			#400 send_valid_packet(8'b10010100, 1'b1);
			#400 send_valid_packet(8'b00110111, 1'b0);
			#400 send_valid_packet(8'b00111101, 1'b1);
			#400 send_valid_packet(8'b00100100, 1'b0);
			#400 send_valid_packet(8'b00110100, 1'b1);
		end

endmodule 