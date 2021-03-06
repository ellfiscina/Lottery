//module bet is the module where the bets are placed

module bet(
	input [4:0] N_in, 
	input reset, scan, SYSRDY,
	output [4:0] B1, B2, B3, B4, 
	output RD_ERR, V, finish,
	output [1:0] number
);
	//N_in is the number that manages the bets. The first data read defines the number of lines, the next 1 to 6 sets of 4 numbers are the bet
	//reset must be high for normal operation, when low sets the outputs and internal registers to 0
	//when scan is high N_in is read
	//SYSRDY indicates if the system is ready
	
	reg [4:0] b1, b2, b3, b4;
	reg [2:0] line;
	reg err, v, f;
	reg [1:0] n;

	assign B1 = b1; //first number
	assign B2 = b2; //second number
	assign B3 = b3; //third number
	assign B4 = b4; //fourth number
	assign RD_ERR = err; //indicates if a invalid value was read in the N_in input
	assign V = v; //indicates that a valid number was read in the first N_in input
	assign finish = f; //indicates that all numbers were read
	assign number = n; //indicates if it is number 1, 2, 3 or 4
	
	always @ (posedge scan or negedge reset) begin
		
		if(!reset) begin //if reset is low the outputs and internal registers are set to zero
			err = 0;
			b1 = 0;
			b2 = 0;
			b3 = 0;
			b4 = 0;
			line = 0;
			n = 0;
			v = 0;
			f = 0;
		end
		
		else if (reset && SYSRDY) begin //if reset and SYSRDY are high, the system is ready to be used
			if(N_in == 0) //N_in = 0 is not a valid input, so RD_ERR is set high
				err = 1;
			
			else if(line == 0) begin //line == 0 indicates that N_in represents how many bets will be placed
				if(N_in > 6 || N_in == 0) //N_in > 6 is not a valid input if line == 0
					err = 1;
				
				else begin 
					line = N_in; //line is the number of lines (or amount of bets)
					n = 0; //number is the position of the number. 0 is the first one
					err = 0; //RD_ERR is low because the input is valid
					v = 1; //is a control register that indicates that the system is reading the number of lines and the input is valid
					b1 = 0;
					b2 = 0;
					b3 = 0;
					b4 = 0;
				end
			end
			
			else begin
			if(n == 0) begin //if number is 0, N_in is the first number, B1
				b1 = N_in;
				n = 1; //number is now set to the next position
				v = 0; 
				
			end
			
			else if(n == 1) begin //if number is 1, N_in is the second number, B2
				if(N_in == b1) //if N_in is equal to B1, an error occur and RD_ERR is set high
					err = 1;
				
				else begin //else, the value of N_in is assigned to B2 
					b2 = N_in;
					n = 2; //number is set to the next position
					v = 0; 
					err = 0;
				end	
			end
			
			else if(n == 2) begin
				if(N_in == b1 || N_in == b2) //if N_in is equal to B1 or B2 an error occur
					err = 1;
				
				else begin
					b3 = N_in;
					n = 3;
					v = 0; 
					err = 0;
				end
			end 
			
			else if(n == 3) begin //if number is 3, the last number of the set is read
				if(N_in == b1 || N_in == b2 || N_in == b3) //if N_in is equal to any of the other numbers an error occur
					err = 1;
				
				else begin
					b4 = N_in;
					n = 0; //number is set to 0 so another round can start
					line = line - 1; //line is decremented in order to control the amount of cicles
					v = 0; 
					err = 0;

					if(line == 0) //if line is 0, every number was read, so finish is set to high
						f = 1;
				end				
			end

			end
		end
	
	end 
	
	endmodule 