module cash(
	input [9:0] sum, 
	input reset, V, finish,
	output [2:0] Eur100, 
	output [3:0] Eur010, Eur001,
	output winner, not_a_win
);

	//sum is count_c amount of cash won by the player
	//V is used to indicate that the first N_in data read was a valid input
	//finish indicates that all bets were placed
	
	reg [9:0] count, count_c, count_d;
	reg w, w_;
	reg [2:0] c;
	reg [3:0] d, u;
	
	assign Eur100 = c; //Eur100 is the winning value in multiples of 100 euro
	assign Eur010 = d; //Eur010 is the winning value in multiples of 10 euro
	assign Eur001 = u; //Eur001 is the winning value in multiples of 1 euro
	assign winner = w; //if winner is high, the player won
	assign not_a_win = w_; //if not_a_win is high, the player lost
	
	always @ (posedge finish or negedge reset) begin //the statements above happens when finish is set high or reset is set to low 
		if(!reset) begin
			c = 3'b0;
			d = 4'b0;
			u = 4'b0;
			w = 0;
			w_ = 0;
		end
		
		else begin
			if(V) begin //if a valid N_in input was read, winner and not_a_win must be set to low
				w = 0;
				w_ = 0;
			end
			
			else if(sum == 0) begin //if sum is 0, the player lost
				w = 0;	
				w_ = 1;
				c = 3'b0;
				d = 4'b0;
				u = 4'b0;
			end
			
			else begin //if sum is not 0, the player won 
				w = 1;
				w_ = 0;
				count = sum; 
				
				//separating the digits of the total amount into 3 numbers
				if(count >= 700) begin
					count_c = count - 700;
					c = 7;
				end
				
				else if(count >= 600) begin
					count_c = count - 600;
					c = 6;
				end
				
				else if(count >= 500) begin
					count_c = count - 500;
					c = 5;
				end
				else if(count >= 400) begin
					count_c = count - 400;
					c = 4;
				end
				else if(count >= 300) begin
					count_c = count - 300;
					c = 3;
				end
				else if(count >= 200) begin
					count_c = count - 200;
					c = 2;
				end
				else if(count >= 100) begin
					count_c = count - 100;
					c = 1;
				end
				else if(count < 100) begin
					c = 0;
					count_c = count;
				end

				if(count_c >= 90) begin
					count_d = count_c - 90;
					d = 9;
				end
				else if(count_c >= 80) begin
					count_d = count_c - 80;
					d = 8;
				end
				else if(count_c >= 70) begin
					count_d = count_c - 70;
					d = 7;
				end
				else if(count_c >= 60) begin
					count_d = count_c - 60;
					d = 6;
				end
				else if(count_c >= 50) begin
					count_d = count_c - 50;
					d = 5;
				end
				else if(count_c >= 40) begin
					count_d = count_c - 40;
					d = 4;
				end
				else if(count_c >= 30) begin
					count_d = count_c - 30;
					d = 3;
				end
				else if(count_c >= 20) begin
					count_d = count_c - 20;
					d = 2;
				end
				else if(count_c >= 10) begin
					count_d = count_c - 10;
					d = 1;
				end
				else if(count_c < 10) begin
					count_d = count_c;
					d = 0;
				end

				if(count_d < 10)
					u = count_d;
			end
		end
	end
	
	
endmodule 