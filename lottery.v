//lottery is the top-level module 

module lottery(
	input [4:0] W1, W2, W3, W4, N_in, 
	input reset, scan,
	output SYSRDY, winner, not_a_win, RD_ERR, 
	output [2:0] Eur100, 
	output [3:0] Eur010, Eur001
);

	wire V, finish;
	wire [1:0] number;
	wire [9:0] sum;
	wire [4:0] B1, B2, B3, B4;
	
	winning_number U1 (W1, W2, W3, W4, SYSRDY);
	bet U2 (N_in, reset, scan, SYSRDY, B1, B2, B3, B4, RD_ERR, V, finish, number);
	check_bet U3 (W1, W2, W3, W4, B1, B2, B3, B4, scan, reset, RD_ERR, number, sum);
	cash U4 (sum, reset, V, finish, Eur100, Eur010, Eur001, winner, not_a_win);
	
	endmodule 