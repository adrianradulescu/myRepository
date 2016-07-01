		task send_invalid_packet_with_control_error_MSB;
			input [7:0] op_code;
			begin
					clk  = 0;
					data = 1;
			#10	clk  = ~clk;
			#10	clk  = ~clk;
					data = op_code[0];
			#10	clk  = ~clk;
			#10	clk  = ~clk;			
					data = op_code[1];
			#10	clk  = ~clk;
			#10	clk  = ~clk;					
					data = op_code[2];
			#10	clk  = ~clk;
			#10	clk  = ~clk;
					data = op_code[3];
			#10	clk  = ~clk;
			#10	clk  = ~clk;			
					data = op_code[4];
			#10	clk  = ~clk;
			#10	clk  = ~clk;			
					data = op_code[5];
			#10	clk  = ~clk;
			#10	clk  = ~clk;			
					data = op_code[6];
			#10	clk  = ~clk;
			#10	clk  = ~clk;			
					data = op_code[7];
			#10	clk  = ~clk;
			#10	clk  = ~clk;			
					data = (op_code[0] ^
							  op_code[1] ^
						     op_code[2] ^
						     op_code[3] ^
						     op_code[4] ^
						     op_code[5] ^
						     op_code[6] ^
						     op_code[7]);
			#10	clk  = ~clk;
			#10	clk  = ~clk;			
					data = 0;
			end
		endtask 