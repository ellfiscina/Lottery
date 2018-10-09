module lottery_test;

	reg [4:0] W1, W2, W3, W4, N_in;
	reg reset, scan;
	wire SYSRDY, winner, not_a_win, RD_ERR;
	wire [2:0] Eur100;
	wire [3:0] Eur010, Eur001;
	
	lottery U1 (W1, W2, W3, W4, N_in, reset, scan, SYSRDY, winner, not_a_win, RD_ERR, Eur100, Eur010, Eur001);
	
	initial begin
		W1 = 5'b0;
		W2 = 5'b0;
		W3 = 5'b0;
		W4 = 5'b0;
		N_in = 5'b0;
		reset = 1'b0;
		scan = 1'b0;
	end
	
	initial begin
		#5 reset = 1'b0;
		#5 reset = 1'b1;
		
		#2 W1 = 4; W2 = 21; W3 = 22; W4 = 30;
		
		#10 N_in = 1; 	// number of lines is 1
		#1 scan = 1;	// pulse of scan
		#1 scan=0;	
		#2 N_in=5;	// first number
		#1 scan = 1;
		#1 scan=0;
		#2 N_in=20;	// second number
		#1 scan = 1;
		#1 scan=0;
		#2 N_in=24;	// third number
		#1 scan = 1;
		#1 scan=0;
		#2 N_in=28;	// last number
		#1 scan = 1;
		#1 scan=0;	// show the results

		
		$display("win: %b | notwin: %b | Euro: %d%d%d", winner, not_a_win, Eur100, Eur010, Eur001);
		
		#3 N_in = 1; 	// number of lines is 4
		#1 scan = 1;	// pulse of scan
		#1 scan=0;	
		// first set
		#2 N_in=1;	// first number
		#1 scan = 1;
		#1 scan=0;
		#2 N_in=3;	// second number
		#1 scan = 1;
		#1 scan=0;
		#2 N_in=22;	// third number
		#1 scan = 1;
		#1 scan=0;
		#2 N_in=26;	// last number
		#1 scan = 1;
		#1 scan=0;	
		#1 scan = 1;
		#1 scan = 1;
		$display("win: %b | notwin: %b | Euro: %d%d%d", winner, not_a_win, Eur100, Eur010, Eur001);

		#100 $finish;
	end
	
	always @(posedge scan) begin
		$display("N: %d | err: %b", N_in, RD_ERR);
	end
	
	endmodule 