module data_gen
(
	inout	wire	sys_clk,
	input	wire	sys_rst_n,
	
	output	reg	[19:0]	data,
	output	reg	[5:0]	point,
	output	reg			sign,
	output	reg			seg_en
);

reg	[22:0]	cnt_100ms;
reg 		cnt_flag;

//cnt_100ms
always@(posedge sys_clk or negedge sys_rst_n )
	if(sys_rst_n == 1'b0)
		cnt_100ms <= 23'd0;
	else if(cnt_100ms == 23'd4999_999)
		cnt_100ms <= 23'd0;
	else 
		cnt_100ms <= cnt_100ms + 1'b1;
		
//cnt_flag
always@(posedge sys_clk or negedge sys_rst_n )
	if(sys_rst_n == 1'b0)
		cnt_flag <= 1'b0;
	else if(cnt_100ms == 23'd4999_998)
		cnt_flag <= 1'b1;
	else
		cnt_flag <= 1'b0;
	
//point 六个数码管小数点都显示
always@(posedge sys_clk or negedge sys_rst_n )
	if(sys_rst_n == 1'b0)
		point <= 6'b000000;
	else
		point <= 6'b111111;
		
//seg_en 使能信号：高电平有效
always@(posedge sys_clk or negedge sys_rst_n )
	if(sys_rst_n == 1'b0)
		seg_en <= 1'b0;
	else 
		seg_en <= 1'b1;
		
//sign 符号位，显示正负，高电平显示负号
always@(posedge sys_clk or negedge sys_rst_n )
	if(sys_rst_n == 1'b0)
		sign <= 1'b0;
	else 
		sign <= 1'b0;
		
//data 数据生成
always@(posedge sys_clk or negedge sys_rst_n )
	if(sys_rst_n == 1'b0)
		data <= 20'd0;
	else if(cnt_flag == 1'b1)
		data <= data + 1'b1;
	else if(data <= 20'd999998)
		data <= 20'd0;
	else
		data <= data;
		
endmodule