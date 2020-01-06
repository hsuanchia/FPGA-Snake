module snake(
	output [7:0] data_r, data_g, data_b,
	output reg[3:0] comm,
	input [3:0] direction,
	input clk,clear);
	
	reg [7:0] status [7:0];
	integer tmp,i,j,start;
	integer tmpx,tmpy;
	integer tailx,taily,cut;
	reg [1:0] moveway;	
	byte body;
	int snakex [64:0];
	int snakey [64:0];
	integer index;
	
	initial
		begin
			body = 3;
			i=0;
			j=0;
			tmpx = 0;
			tmpy = 0;
			index = 0;
			snakex[3] = 2;
			snakex[2] = 1;
			snakex[1] = 0;
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
		
//		if(appely == cnt)
//		{
//				int applex = 5;
//				reg tmp = 8'b00000000;
//				rightshift
//				{
//					
//				}
//				
//		}


	always@(posedge clk_mv)
		begin
			if(clear == 1)
				begin
					body = 3;
					i=0;
					j=0;
					tmpx = 0;
					tmpy = 0;
					index = 0;
					snakex[3] = 2;
					snakex[2] = 1;
					snakex[1] = 0;
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
				end
			else
			begin		
				if(direction[3])
					moveway = 2'b11;
				else if(direction[0])
						moveway = 2'b00;
				else if(direction[1])
						moveway = 2'b01;
				else if(direction[2])
						moveway = 2'b10;
						
				if(i <= body) //refresh snake status
						begin
							if(i == 0)
								status[snakex[0]][snakex[0]] = 1'b1;
							else
								status[snakex[i]][snakey[i]] = 1'b0;
							i++;
						end
						
				if(moveway == 2'b11 && i >= body +1)
					begin
						tmpx = snakex[body];
						tmpy = snakey[body];
						if(index < body)
							begin
								snakex[index] = snakex[index+1];
								snakey[index] = snakey[index+1];
								index++;
							end
						snakex[body] = tmpx + 1;
						snakey[body] = tmpy;
						if(index == body)
							i=0;						
					end

				else if(moveway == 2'b00 && i >= body+1)
					begin
						tmpx = snakex[body];
						tmpy = snakey[body];
						if(index < body)
							begin
								snakex[index] = snakex[index+1];
								snakey[index] = snakey[index+1];
								index++;
							end
						snakex[body] = tmpx - 1;
						snakey[body] = tmpy;
						if(index == body)
							i=0;	
						
					end
				else if(moveway == 2'b01 && i >= body+1)
					begin
						tmpx = snakex[body];
						tmpy = snakey[body];
						if(index < body)
							begin
								snakex[index] = snakex[index+1];
								snakey[index] = snakey[index+1];
								index++;
							end
						snakex[body] = tmpx;
						snakey[body] = tmpy + 1;
						if(index == body)
							i=0;	
					end
				else if(moveway == 2'b10 && i >= body+1)
					begin
						tmpx = snakex[body];
						tmpy = snakey[body];
						if(index < body)
							begin
								snakex[index] = snakex[index+1];
								snakey[index] = snakey[index+1];
								index++;
							end
						snakex[body] = tmpx;
						snakey[body] = tmpy - 1;
						if(index == body)
							i=0;	
					end
//					
//					begin
//						tmp = status[0][7];
//						for(index = 7;index >= 1;index--)
//								status[0][index] = status[0][index-1];
//						status[0][0] = tmp;
//					end
					
//begin
//						tmp = status[0][0];
//						for(index = 1;index <= 7;index++)
//								status[0][index-1] = status[0][index];
//						status[0][7] = tmp;
//					end
//					begin			
//						tmp = status[7][0];
//						for(index = 7;index >= 1;index--)
//								status[index] = status[index-1];
//						status[0][0] = tmp;	
//					end
					
//					
//						tmp = status[0][0];
//						for(index = 1;index <= 7;index++)
//								status[index-1] = status[index];
//						status[7][0] = tmp;
					
//				if(direction[3])
//				begin
//					status[5][5] = 1;
////						headx = headx + 1;
////						status[headx][heady] = 1'b1;
////						status[tailx][taily] = 1'b0;		
			end		
			
			
					
				
		
		end
//		

		
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
			if(count > 3500000)
				begin
					count <= 35'b0;
					clk_mv <= ~clk_mv;
				end
			else
				count <= count + 1'b1;
		end
endmodule

