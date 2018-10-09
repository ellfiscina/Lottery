// module winning_number provides the 4 winning numbers

module winning_number(
	input [4:0] W1, W2, W3, W4, //hard-wired winning numbers
	output SYSRDY //the output signals if the system is ready
);

	reg rdy;
	assign SYSRDY = rdy;
	
	always @ (W1 or W2 or W3 or W4) begin 
		if(W1 == 0 || W2 == 0 || W3 == 0 || W4 == 0 || W1 == W2 || W1 == W3 || W1 == W4 || W2 == W3 || W2 == W4 || W3 == W4)
			//if any of the numbers is zero or if there are repeated numbers, the SYSRDY output will go low
			rdy = 0;
		else
			rdy = 1;
	end 
	
endmodule 