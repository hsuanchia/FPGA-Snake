module snake(
	output [7:0] data_r, data_g, data_b,
	output reg[3:0] comm,
	input [3:0] direction,
	input clk,clear);
	
	reg [7:0] status [7:0];
	reg long = 3;
	reg [1:0] moveway;
	
	initial
		begin
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
			status[7] = 8'b11111111;
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
//	
	always@(posedge clk_mv,posedge clear)
		begin
		bit [7:0] tmp;
		integer index = 0;
			if(clear)
				begin
					status[0] = 8'b01111111;
					status[1] = 8'b01111111;
					status[2] = 8'b11111111;
					status[3] = 8'b11111111;
					status[4] = 8'b11111111;
					status[5] = 8'b11111111;
					status[6] = 8'b11111111;
					status[7] = 8'b11111111;
				end
			else
			begin
				if(direction[3])
					begin
						tmp = status[7];
						for(index = 7;index >= 1;index--)
								status[index] = status[index-1];
						status[0] = tmp;
					end
				else if(direction[0])
					begin
						tmp = status[0];
						for(index = 1;index <= 7;index++)
								status[index-1] = status[index];
						status[7] = tmp;
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
			if(count > 3500000)
				begin
					count <= 35'b0;
					clk_mv <= ~clk_mv;
				end
			else
				count <= count + 1'b1;
		end
endmodule

