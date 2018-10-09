//the module check_bet compares the bet with the winning number

module check_bet(
	input [4:0] W1, W2, W3, W4, B1, B2, B3, B4, 
	input scan, reset, RD_ERR, 
	input [1:0] number, 
	output [9:0]sum //total of cash won in one bet
);

reg [2:0]h;
reg [9:0]s; //h calculates the amount of hits in one bet
assign sum = s;
always @ (posedge scan or negedge reset) begin //the statements above must happen when reset is set to low or when a set of 4 numbers is read
	if(!reset) begin
		h = 0;
		s = 0;
	end
	
	else if(!RD_ERR)begin //if there is no error in the system
		if(number == 0) begin
		 if(B1 == W1 || B1 == W2 || B1 == W3 || B1 == W4) //if it is the first number and it is equal to any of the winning numbers, there is a hit
			h = 1;
		 else
			h = 0;
		end
		else if(number == 1) begin
		 if(B2 == W1 || B2 == W2 || B2 == W3 || B2 == W4) //if it is the second number and it is equal to any of the winning numbers, there is a hit
			h = h + 1;
		 else
			h = h + 0;
		end
		else if(number == 2) begin
		 if(B3 == W1 || B3 == W2 || B3 == W3 || B3 == W4) //if it is the third number and it is equal to any of the winning numbers, there is a hit
			h = h + 1;
		 else
			h = h + 0;
		end
		else if(number == 3) begin
		 if(B4 == W1 || B4 == W2 || B4 == W3 || B4 == W4) //if it is the fourth number and it is equal to any of the winning numbers, there is a hit
			h = h + 1;
		 else
			h = h + 0;
			
			case(h)
				0: s = s + 0; ////if there was no hits, the player wins + 0 euro		
				1: s = s + 1; //if there was only 1 hit, the player wins + 1 euro
				2: s = s + 5; //if there were 2 hits, the player wins + 5 euro
				3: s = s + 25; //if there were 3 hits, the player wins + 25 euro
				4: s = s + 125; //if there were 4 hits, the player wins + 125 euro
				
			endcase
		end
	end

end

endmodule 