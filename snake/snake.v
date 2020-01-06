module snake(
	output [7:0] data_r, data_g, data_b,
	output reg[3:0] comm,
	input [3:0] direction,
	output a, b, c, d, e, f, g, COM3, COM4,
	input clk,clear);
	reg [7:0] status [7:0];
	reg [5:0] i;
	reg [7:0] apple [7:0];
	integer tmpx,tmpy;
	reg [1:0] moveway;	
	bit [5:0] body;
	integer snakex [63:0];
	integer snakey [63:0];
	integer index;
	integer applex,appley;
	integer randomseedx = 1;
	integer randomseedy = 1;
	reg [3:0] A_count;
	
	initial
		begin
			body = 4;
			i=0;
			tmpx = 0;
			tmpy = 0;
			index = 0;
			snakex[3] = 3;
			snakex[2] = 2;
			snakex[1] = 1;
			snakex[0] = 0;
			snakey[3] = 0;
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
			COM3 = 1'b0;
			COM4 = 1'b0;
		end
			
	bit [2:0] cnt;
	reg count;
	divfreq F0(clk,clk_div);
	divfreq_mv F1(clk, clk_mv);
	BCD2Seg bcd(A_count[3], A_count[2], A_count[1], A_count[0], clk_mv, a, b, c, d, e, f, g, COM3, COM4);
	
	always@(posedge clk_mv)
		if(A_count >= 4'b1111) 
			A_count <= 4'b0000;
		else 
			A_count <= A_count + 1'b1;
	
	always@(posedge clk_div) // Frame per second refresh
		begin
			if (cnt >= 7)
				cnt = 0;
			else
				cnt = cnt + 1;
			comm = {1'b1,cnt};
 			
			data_g = status[cnt];
			data_r = apple[cnt];
			
		end

	always@(posedge clk_mv)
		begin
			
			if(clear == 1)
				begin
					body = 4;
					i=0;
					tmpx = 0;
					tmpy = 0;
					index = 0;
					snakex[3] = 3;
					snakex[2] = 2;
					snakex[1] = 1;
					snakex[0] = 0;
					snakey[3] = 0;
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
					apple[0] = 8'b11111111;
					apple[1] = 8'b11111111;
					apple[2] = 8'b11111111;
					apple[3] = 8'b11111111;
					apple[4] = 8'b11111111;
					apple[5] = 8'b11111111;
					apple[6] = 8'b11111111;
					apple[7] = 8'b11111111;
					// spawn random apple positions 
					apple[applex][appley] = 1'b1;	
					randomseedx = (randomseedx * 900123701) + 107321009;
					randomseedy = (randomseedy * 300123701) + 107321003;
					applex = randomseedx % 8;
					appley = randomseedy % 8;
					apple[applex][appley] = 1'b0;
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
					for(i=0;i<2;i++)
						begin
							if (snake[1] == snake[i-1])
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

module BCD2Seg(
	input A, B, C, D,
	input CLK_div,
	output reg a, b, c, d, e, f, g,
	output reg COM3, COM4
	);
	
	reg cnt;

	always @({A, B, C, D})
	case ({A, B, C, D})
		4'b0000: {a, b, c, d, e, f, g}= 7'b0000001;
		4'b0001: {a, b, c, d, e, f, g}= 7'b1001111;
		4'b0010: {a, b, c, d, e, f, g}= 7'b0010010;
		4'b0011: {a, b, c, d, e, f, g}= 7'b0000110;
		4'b0100: {a, b, c, d, e, f, g}= 7'b1001100;
		4'b0101: {a, b, c, d, e, f, g}= 7'b0100100;
		4'b0110: {a, b, c, d, e, f, g}= 7'b0100000;
		4'b0111: {a, b, c, d, e, f, g}= 7'b0001111;
		4'b1000: {a, b, c, d, e, f, g}= 7'b0000000;
		4'b1001: {a, b, c, d, e, f, g}= 7'b0000100;
		default: {a, b, c, d, e, f, g}= 7'b0000001;
	endcase
	
	always @(CLK_div)
		begin
			cnt = ~cnt;
			if (cnt == 1'b1)
				begin
					COM3 = 1'b0;
					COM4 = 1'b0;

				end
			else
				begin
					COM3 = 1'b0;
					COM4 = 1'b0;

				end
				

		end
		
		
endmodule