module Debouncer
  #(parameter FILTER_WIDTH = 3)
   (input      FAST_CLOCK,
    input      SYNCED_SIGNAL,
    output reg DEBOUNCED
	 );

	// Circuitul se bazeaza pe un SR cu care compara
	// o fereastra, persistenta inseamna ca semnalul 
	// este stabil


	// Solutie propusa pe Doulos
	
  reg [FILTER_WIDTH : 0] SHIFTER;
  
  always @ (posedge FAST_CLOCK) begin
    if (SHIFTER[FILTER_WIDTH:1] == 3'b000) begin
			DEBOUNCED <= 0;
    end 
		else 
		if (SHIFTER[FILTER_WIDTH:1] == 3'b111) begin
      DEBOUNCED <= 1;
		end 
    SHIFTER <= { SHIFTER[FILTER_WIDTH-1 : 0], SYNCED_SIGNAL};
  end 
  
endmodule 
