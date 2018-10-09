module bet_t;
	reg [4:0] N_in;
	reg reset, scan, SYSRDY;
	wire [4:0] B1, B2, B3, B4; 
	wire RD_ERR, Set, V, finish;
	wire [1:0] number;

bet U1 (N_in, reset, scan, SYSRDY, B1, B2, B3, B4, RD_ERR, Set, V, finish, number);

initial begin
	N_in = 0;
	reset = 0;
	scan = 0;
	SYSRDY = 0;
end

initial begin
	#1 reset = 0;
	#1 reset = 1;
	#1 SYSRDY = 1;
	#10 N_in = 2; 	// number of lines is 1
	#2 scan = 1;	// pulse of scan
	#1 scan=0;	
	#2 N_in=5;	// first number
	#2 scan = 1;
$display("%d", B1);
	#1 scan=0;
	#2 N_in=21;	// second number
	#2 scan = 1;
	#1 scan=0;
	#2 N_in=24;	// third number
	#2 scan = 1;
	#1 scan = 0;
	#2 N_in=28;	// last number
	#2 scan = 1;
	#1 scan = 0;	// show the results
	#2 N_in=1;	// first number
		#2 scan = 1;
		#1 scan=0;
		#2 N_in=3;	// second number
		#2 scan = 1;
		#1 scan=0;
		#2 N_in=22;	// third number
		#2 scan = 1;
		#1 scan=0;
		#2 N_in=26;	// last number
		#2 scan = 1;
		#1 scan=0;	
		#2 scan = 1;
		#2 scan = 0;
	#100 $finish;
end

always @ (posedge scan) begin
	$display("N_in: %d | B1: %d | B2: %d | B3: %d | B4: %d | n: %d | err: %b", N_in, B1, B2, B3, B4, number, RD_ERR);
end

endmodule