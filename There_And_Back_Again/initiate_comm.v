task initiate_comm;
	begin
			scl = 1;
			sda = 1;
	#10	sda = 0;	
	end
endtask
