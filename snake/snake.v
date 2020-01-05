module snake(
	output [7:0] data_r, data_g, data_b,
	output reg[3:0] comm,
	input [3:0] direction,
	input clk,clear);
	
	reg [7:0] status [7:0];
	reg long = 3;
	
	initial
		begin
			data_r = 8'b11111111;
			data_g = 8'b11111111;
			data_b = 8'b11111111;
			status[0] = 8'b11111111;
			status[1] = 8'b01111111;
			status[2] = 8'b11111111;
			status[3] = 8'b11111111;
			status[4] = 8'b11111111;
			status[5] = 8'b11111111;
			status[6] = 8'b11111111;
			status[7] = 8'b11111111;
		end
			
	bit [2:0] cnt;
	reg count;
	divfreq F0(clk,clk_div);
	divfreq_mv F1(clk, clk_mv);
	
	always@(posedge clk_div)
		begin
			if (cnt >= 7)
				cnt = 0;
			else
				cnt = cnt + 1;
			comm = {1'b1,cnt};
			
			data_g = status[cnt];
			
		end
	
	always@(posedge clk_mv, posedge clear)
		begin
			if(clear)
			begin
				status[0] = 8'b00001111;
				status[1] = 8'b11111111;
				status[2] = 8'b11111111;
				status[3] = 8'b11111111;
				status[4] = 8'b11111111;
				status[5] = 8'b11111111;
				status[6] = 8'b11111111;
				status[7] = 8'b11111111;
			end
			else if(direction[3])
				begin
					if (count >= 7)
						count = 0;
					else
						begin
							count = count + 1;
							status[count-1] = 8'b11111111;
							status[count] = 8'b00001111;
						
						end

				end
			else if(direction[0])
				begin
					if (count <= 0)
						count = 7;
					else
						begin
							count = count - 1;
							status[count] = 8'b00001111;
							status[count+1] = 8'b11111111;
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
			if(count > 35000)
				begin
					count <= 35'b0;
					clk_mv <= ~clk_mv;
				end
			else
				count <= count + 1'b1;
		end
endmodule

