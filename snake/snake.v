module snake(
	output [7:0] data_r, data_g, data_b,
	output reg[3:0] comm,
	input [3:0] direction,
	input clk,clear);
	
	reg [7:0] status [7:0];
	int tmp;
	reg [1:0] moveway;	
	reg body;
	integer snakex [63:0];
	integer snakey [63:0];
	initial
		begin
			body = 3;
			for(tmp = 0;tmp<body;tmp++)
				begin
					snakex[tmp] = tmp;
					snakey[tmp] = 0;
				end
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
		integer index;
		integer tmpx;
		integer tmpy;
			if(clear == 1)
				begin
					body = 3;
					for(tmp = body-1;tmp>=0;tmp--)
						begin
							snakex[tmp] = tmp;
							snakey[tmp] = 0;
						end
					moveway = 2'b11; //left = 00,down = 01,up = 10,right = 11
					status[0] = 8'b01111111;
					status[1] = 8'b01111111;
					status[2] = 8'b01111111;
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
				else if(moveway == 2'b11)
					begin
							for(index = 0;index<=7;index++)
								status[index] = 8'b11111111;
							for(index = 0;index < body;index++)
								status[snakex[index]][snakey[index]] = 1'b0;
//							tmpx = snakex[body-1];
//							tmpy = snakey[body-1];
//							for(index = 0;index < body-1;index++)
//								begin
//									snakex[index] = snakex[index+1];
//									snakey[index] = snakey[index+1];
//								end
//							snakex[body-1] = tmpx + 1;
//							snakey[body-1] = tmpy;
									
					end
				else if(moveway == 2'b00)
					begin
							for(index = 0;index<=7;index++)
								status[index] = 8'b11111111;
							for(index = 0;index < body;index++)
								status[snakex[index]][snakey[index]] = 1'b0;
							tmpx = snakex[body-1];
							tmpy = snakey[body-1];
							for(index = 0;index < body;index++)
								begin
									snakex[index] = snakex[index+1];
									snakey[index] = snakey[index+1];
								end
							snakex[body-1] = tmpx - 1;
							snakey[body-1] = tmpy;
					end
				else if(moveway == 2'b01)
					begin
							for(index = 0;index<=7;index++)
								status[index] = 8'b11111111;
							for(index = 0;index < body;index++)
								status[snakex[index]][snakey[index]] = 1'b0;
							tmpx = snakex[body-1];
							tmpy = snakey[body-1];
							for(index = 0;index < body;index++)
								begin
									snakex[index] = snakex[index+1];
									snakey[index] = snakey[index+1];
								end
							snakex[body-1] = tmpx;
							snakey[body-1] = tmpy-1;
					end
				else if(moveway == 2'b10)
					begin
							for(index = 0;index<=7;index++)
								status[index] = 8'b11111111;
							for(index = 0;index < body;index++)
								status[snakex[index]][snakey[index]] = 1'b0;
							tmpx = snakex[body-1];
							tmpy = snakey[body-1];
							for(index = 0;index < body;index++)
								begin
									snakex[index] = snakex[index+1];
									snakey[index] = snakey[index+1];
								end
							snakex[body-1] = tmpx;
							snakey[body-1] = tmpy + 1;
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
//				end
//				if(direction[0])
//					moveway <= 2'b00;
//				if(direction[1])
//					moveway <= 2'b01;
//				if(direction[2])
//					moveway <= 2'b10;
//					
//				if(moveway == 2'b11)
//					begin
//						headx = headx + 1;
//						status[headx][heady] = 1'b1;
//						status[tailx][taily] = 1'b0;
//					end
//				else
//					begin
//						headx = headx - 1;
//						status[headx][heady] = 1'b1;
//						status[tailx][taily] = 1'b0;
//					end			
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
			if(count > 10000000)
				begin
					count <= 35'b0;
					clk_mv <= ~clk_mv;
				end
			else
				count <= count + 1'b1;
		end
endmodule
