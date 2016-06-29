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
module FullI2CController(
		input 											  DATA,
		input 							 					CLK,
		input 									  		  FCLK,
		output reg				[7 : 0] CIRCUIT_OUT_DATA
    );
	 
		wire [7 : 0]					 DATA_OUTPUT_CHECK;
		wire 								 PARITY_CHECK_WIRE;
		wire [7 : 0]								SCAN_CODE;
		
	AsyncDebounceWithShiftRegister SyncAndParalelizationModule(
			.DATA									 		(DATA),
			.CLK									  		 (CLK),
			.FCLK									 		(FCLK),
			.DATA_OUTPUT_CHECK	  (DATA_OUTPUT_CHECK),
			.PARITY_CHECK_BIT	  	  (PARITY_CHECK_WIRE),
			.SCAN_CODE					  		 (SCAN_CODE)
    );

	 DataValidCheckerWithOutRegFull 	 			  CheckingModule(
			.PARITY_CHECK_BIT	  	  (PARITY_CHECK_WIRE),
			.DATA_INPUT_CHECKER	  (DATA_OUTPUT_CHECK),
			.DATA_VALID							  (DATA_VAL)
      );
	 
	 always@(posedge CLK && SCAN_CODE)
		if(DATA_VAL) CIRCUIT_OUT_DATA <= SCAN_CODE;
			
endmodule
