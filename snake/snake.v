module snake(
	output [7:0] data_r, data_g, data_b,
	output reg[3:0] comm,
	input [3:0] direction,
	input clk,clear);
	reg [7:0] status [7:0];
	reg [5:0] i;
	integer tmpx,tmpy;
	reg [1:0] moveway;	
	bit [5:0] body;
	integer snakex [63:0];
	integer snakey [63:0];
	integer index;
	
	initial
		begin
			body = 3;
			i=0;
			tmpx = 0;
			tmpy = 0;
			index = 0;
			snakex[2] = 2;
			snakex[1] = 1;
			snakex[0] = 0;
			snakey[2] = 0;
			snakey[1] = 0;
			snakey[0] = 0;
			moveway = 2'b11; //left = 00,down = 01,up = 10,right = 11
			data_r = 8'b11111111;
			data_g = 8'b11111111;
			data_b = 8'b11111111;
			status[0] = 8'b00000000;
			status[1] = 8'b00000000;
			status[2] = 8'b00000000;
			status[3] = 8'b00000000;
			status[4] = 8'b00000000;
			status[5] = 8'b00000000;
			status[6] = 8'b00000000;
			status[7] = 8'b00000000;
		end
			
	bit [2:0] cnt;
	reg count;
	divfreq F0(clk,clk_div);
	divfreq_mv F1(clk, clk_mv);
	
	always@(posedge clk_div) // Frame per second refresh
		begin
			if (cnt >= 7)
				cnt = 0;
			else
				cnt = cnt + 1;
			comm = {1'b1,cnt};
 			
			data_g = status[cnt];
			
		end

	always@(posedge clk_mv)
		begin
			if(clear == 1)
				begin
					body = 3;
					i=0;
					tmpx = 0;
					tmpy = 0;
					index = 0;
					snakex[2] = 2;
					snakex[1] = 1;
					snakex[0] = 0;
					snakey[2] = 0;
					snakey[1] = 0;
					snakey[0] = 0;
					moveway = 2'b11; //left = 00,down = 01,up = 10,right = 11
					status[0] = 8'b11111110;
					status[1] = 8'b11111110;
					status[2] = 8'b11111110;
					status[3] = 8'b11111111;
					status[4] = 8'b11111111;
					status[5] = 8'b11111111;
					status[6] = 8'b11111111;
					status[7] = 8'b11111111;
				end
			else
				begin		
					if(direction[3] && moveway != 2'b00)
						moveway = 2'b11;
					else if(direction[0] && moveway != 2'b11)
							moveway = 2'b00;
					else if(direction[1] && moveway != 2'b10)
							moveway = 2'b01;
					else if(direction[2] && moveway != 2'b01)
							moveway = 2'b10;
							
					if(moveway == 2'b11) // right
						begin
							status[snakex[0]][snakey[0]] = 1'b1;
							for(i=0; i+1 < body;i++)
								begin
									snakex[i] = snakex[i+1];
									snakey[i] = snakey[i+1];
								end
							snakex[body-1] = snakex[body-1] + 1;						
						end
					else if(moveway == 2'b00) // left
						begin
							status[snakex[0]][snakey[0]] = 1'b1;
							for(i=0;i+1 < body;i++)
								begin
									snakex[i] = snakex[i+1];
									snakey[i] = snakey[i+1];
								end
							snakex[body-1] = snakex[body-1] - 1;
						end
					else if(moveway == 2'b01) // down
						begin
							status[snakex[0]][snakey[0]] = 1'b1;
							for(i=0;i+1 < body;i++)
								begin
									snakex[i] = snakex[i+1];
									snakey[i] = snakey[i+1];
								end
							snakey[body-1] = snakey[body-1] + 1;	
						end
					else if(moveway == 2'b10) // up
						begin
							status[snakex[0]][snakey[0]] = 1'b1;
							for(i=0;i+1 < body;i++)
								begin
									snakex[i] = snakex[i+1];
									snakey[i] = snakey[i+1];
								end
							snakey[body-1] = snakey[body-1] - 1;		
						end
					status[snakex[body-1]][snakey[body-1]] = 1'b0;
					if(snakex[body-1] < 0 || snakex[body-1] > 7 || snakey[body-1] < 0 || snakey[body-1] > 7)
						begin
							status[0] = 8'b00000000;
							status[1] = 8'b00000000;
							status[2] = 8'b00000000;
							status[3] = 8'b00000000;
							status[4] = 8'b00000000;
							status[5] = 8'b00000000;
							status[6] = 8'b00000000;
							status[7] = 8'b00000000;
						end
				end	
		end
		
endmodule


module divfreq(input clk, output reg clk_div);
	reg[24:0] count;
	always@(posedge clk)
		begin
			if(count > 10000)
				begin
					count <= 25'b0;
					clk_div <= ~clk_div;
				end
			else
				count <= count + 1'b1;
		end
endmodule

module divfreq_mv(input clk, output reg clk_mv);
	reg[35:0] count;
	always@(posedge clk)
		begin
			if(count > 10000000)
				begin
					count <= 35'b0;
					clk_mv <= ~clk_mv;
				end
			else
				count <= count + 1'b1;
		end
endmodule

