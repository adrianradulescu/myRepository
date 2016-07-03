module Communication_Selector(
		input 									 communication_initiated,
		input 										  communication_ended,
		output											  is_communicating
    );

	reg was_communicating = 0;
	reg buffer = 0;
	always@(*) begin
		if(was_communicating && communication_ended) begin
			buffer = 0;
			end
			else if(~was_communicating && communication_initiated) begin
				buffer = 1;
			end
	end
	
	assign is_communicating = buffer;

endmodule
