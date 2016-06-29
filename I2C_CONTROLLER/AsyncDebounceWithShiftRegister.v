`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: N/A
// Engineer: Berbec Marius 
// 
// Create Date:    20:33:46 06/29/2016 
// Design Name:	 I2C paralellization 
// Module Name:    AsyncDebounceWithShiftRegister 
// Project Name: 	 I2C controller
// Target Devices: Nexys 2 Board
// Tool versions:  Xilinx ISE
// Description: 	 Synchronization and serialization module
//
// Dependencies: 	 Needs a parity check circuit
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module AsyncDebounceWithShiftRegister(
			input 								   DATA,
			input 		 						    CLK,
			input							 		   FCLK,
			output 				   PARITY_CHECK_BIT,
			output	[7:0]		  DATA_OUTPUT_CHECK,
			output	[7:0]		  			 SCAN_CODE
    );
	 
			wire						SLOW_CLOCK = CLK;
		// pentru un anume motiv pe care nu il
		// inteleg, nu merge sa folosesc SLOW_CLK
		// in loc de CLK pentru circuitul de debounce
		// si sincronizare
			wire					  FAST_CLOCK = FCLK;
			wire 						  DEBOUNCED_DATA;
			wire				  DEBOUNCED_SLOW_CLOCK;
			wire								  DATA_VAL;
	
			reg [7 : 0] 			CIRCUIT_OUT_DATA;
			
	 SynchronizationAndDebounce mySyncAndDebounceData(
			.INPUT_DATA							 (DATA),
			.FAST_CLOCK					 (FAST_CLOCK),
			.OUTPUT_DATA			(DEBOUNCED_DATA)
		);
		
	 SynchronizationAndDebounce mySyncAndDebounceClock(
			.INPUT_DATA							  (CLK),
			.FAST_CLOCK					 (FAST_CLOCK),
			.OUTPUT_DATA	(DEBOUNCED_SLOW_CLOCK)
		);
		
	 ShiftRegister #(11)					  myShiftRegister(
			.DEBOUNCED_DATA		(DEBOUNCED_DATA),
			.CONTROL_CLOCK				 (SLOW_CLOCK),
			.PARALLEL_DATA_OUTPUT	  (SCAN_CODE),			
			.PARITY_CHECK_BIT	 (PARITY_CHECK_BIT)
		);
		
		assign DATA_OUTPUT_CHECK = SCAN_CODE;
	
endmodule
