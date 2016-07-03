module Communication_Detector(
		input 											  communication_initiated,
		input 													communication_ended,
		output reg												 data_accept_enable
		);
		
		always@(*) begin
			if(communication_initiated) begin
				data_accept_enable = 0;
			end // if
			else if(communication_ended) begin
					  data_accept_enable = 0;
				  end //if
		end // always
		
endmodule
