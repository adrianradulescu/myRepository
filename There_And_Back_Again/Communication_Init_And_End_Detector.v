module Communication_Init_And_End_Detector(
		input 														synced_sda_input,
		input 														synced_scl_input,
		input															is_communicating,
		output reg										  communication_initiated,
		output reg												communication_ended
		);
		
		always@(*) begin
			if(!synced_sda_input && synced_scl_input && ~is_communicating) begin
				communication_initiated <= 1;
				end // if
			else begin
					communication_initiated <= 0;
				  end // else
			if(synced_sda_input && ~synced_scl_input && is_communicating) begin
				communication_ended <= 1;
				end // if
			else begin
					communication_ended <= 0;
				  end // else
		end // always
	
endmodule 