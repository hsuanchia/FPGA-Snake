module snake(
	output [7:0] data_r, data_g, data_b,
	output reg[3:0] comm,
	input clk);
	
	
	
	divfreq F0(clk,clk_div);
		
	assign data_r = 8'b01111111;
	assign data_g = 8'b10111111;
	assign data_b = 8'b11011111;
	
	always@(posedge clk_div)
		comm <= comm + 1'b1;
			
	
endmodule


module divfreq(input clk, output reg clk_div);
	reg[24:0] count;
	always@(posedge clk)
		begin
			if(count > 25000000)
				begin
					count <= 25'b0;
					clk_div <= ~clk_div;
				end
			else
				count <= count + 1'b1;
		end
endmodule
