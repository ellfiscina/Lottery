module cash_t;
	reg [9:0] sum;
	reg reset, V, finish;
	wire [2:0] Eur100;
	wire [3:0] Eur010, Eur001;
	wire winner, not_a_win;

cash U1 (sum, reset, V, finish, Eur100, Eur010, Eur001, winner, not_a_win);

initial begin
	sum = 0;
	reset = 0;
	V = 0;
	finish = 0;
end 

initial begin
	#2 reset = 1;
	#2 sum = 0;
	#1 finish = 1;
	#1 finish = 0;
	$display("w: %b | w': %b | Euros: %d%d%d", winner, not_a_win, Eur100, Eur010, Eur001);
	#10 sum = 750;
	#1 finish = 1;
	#1 finish = 0;
	$display("w: %b | w': %b | Euros: %d%d%d", winner, not_a_win, Eur100, Eur010, Eur001);
	#10 sum = 32;
	#1 finish = 1;
	#1 finish = 0;
	$display("w: %b | w': %b | Euros: %d%d%d", winner, not_a_win, Eur100, Eur010, Eur001);
	#10 sum = 5;
	#1 finish = 1;
	#1 finish = 0;
	$display("w: %b | w': %b | Euros: %d%d%d", winner, not_a_win, Eur100, Eur010, Eur001);
	#10 sum = 125;
	#1 finish = 1;
	#1 finish = 0;
	$display("w: %b | w': %b | Euros: %d%d%d", winner, not_a_win, Eur100, Eur010, Eur001);
	#10 $finish;
end 

endmodule 