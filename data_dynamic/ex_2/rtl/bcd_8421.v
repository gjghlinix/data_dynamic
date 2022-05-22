module bcd_8421
(
	input	wire		sys_clk,
	input	wire		sys_rst_n,
	input	wire [19:0]	data,
	
	output	reg	 [3:0]	unit,
	output	reg	 [3:0]	ten,
	output	reg	 [3:0]	hun,
	output	reg	 [3:0]	thou,
	output	reg	 [3:0]	t_thou,
	output	reg	 [3:0]	h_thou
);

reg [43:0] 	data_shift;
reg	[4:0]	cnt_shift;
reg			shift_flag;

//cnt_shift移位计数器
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		cnt_shift <= 5'd0;
	else if(cnt_shift == 5'd21 && shift_flag == 1'b1)
		cnt_shift <= 5'd0;
	else if(shift_flag == 1'b1)
		cnt_shift <= cnt_shift + 1'b1;
	else
		cnt_shift <= cnt_shift;
		
//shift_flag移位标志信号
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		shift_flag <= 1'b0;
	else 
		shift_flag <= ~shift_flag;
		
//data_shift移位标志信号(数据移位操作比较困难！！！！！)
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		data_shift <= 44'b0;
	else if(cnt_shift == 4'd0)
		data_shift <= {24'b0,data};
	else if((cnt_shift < 5'd21) && (shift_flag == 1'b0))//低电平判断操作
		begin
			data_shift[23:20] <= (data_shift[23:20] > 3'd4) ? (data_shift[23:20] + 2'd3) : data_shift[23:20];
			data_shift[27:21] <= (data_shift[27:21] > 3'd4) ? (data_shift[27:21] + 2'd3) : data_shift[27:21];
			data_shift[31:28] <= (data_shift[31:28] > 3'd4) ? (data_shift[31:28] + 2'd3) : data_shift[31:28];
			data_shift[35:32] <= (data_shift[35:32] > 3'd4) ? (data_shift[35:32] + 2'd3) : data_shift[35:32];
			data_shift[39:36] <= (data_shift[39:36] > 3'd4) ? (data_shift[39:36] + 2'd3) : data_shift[39:36];
			data_shift[43:40] <= (data_shift[43:40] > 3'd4) ? (data_shift[43:40] + 2'd3) : data_shift[43:40];
		end
	else if((cnt_shift < 5'd21) && (shift_flag == 1'b1))//高电平移位操作
		data_shift <= data_shift << 1'b1;
	else
		data_shift <= data_shift;
		
		
//对各数码管赋值(输出信号赋值)
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		begin
			unit   <= 4'b0;
			ten    <= 4'b0;
			hun    <= 4'b0;
			thou   <= 4'b0;
			t_thou <= 4'b0;
			h_thou <= 4'b0;
			unit   <= 4'b0;
			ten    <= 4'b0;
		end
	else if(cnt_shift == 5'd21)
		begin
			unit   <= data_shift[23:20];
			ten    <= data_shift[27:21];
			hun    <= data_shift[31:28];
			thou   <= data_shift[35:32];
			t_thou <= data_shift[39:36];
			h_thou <= data_shift[43:40];
		end
		
endmodule