module hc595
(
	input	wire		sys_clk,
	input	wire		sys_rst_n,
	input	wire [5:0]	sel,
	input	wire [7:0]	seg,
	
	output	reg		stcp,
	output	reg		shcp,
	output	wire	oe,
	output	reg		ds
);
reg [1:0]	cnt;
reg	[3:0]	cnt_bit;
wire [13:0]	data;

//数码管信号寄存
assign  data = {seg,sel};
//使能信号赋值
assign  oe = ~sys_rst_n;


//计数器 cnt
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		cnt <= 2'b0;
	else if(cnt == 2'd3)
		cnt <= 2'd0;
	else
		cnt <= cnt +1'b1;
		
//位计数器 cnt_bit
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		cnt_bit <= 4'b0;
	else if(cnt_bit == 4'd13 && cnt == 2'd3)
		cnt_bit <= 4'd0;
	else if(cnt == 2'd3)
		cnt_bit <= cnt_bit + 1'b1;
	else
		cnt_bit <= cnt_bit;
		
//stcp存储寄存器时钟 四分频
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		stcp <= 1'b0;
	else if(cnt == 2'd2)
		stcp <= 1'b1;
	else if(cnt == 4'd0)
		stcp <= 1'b1;
	else 
		stcp <= stcp;
		
//shcp 十四位一个高电平
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		shcp <= 1'b0;
	else if(cnt_bit == 4'd13 && cnt == 2'd3)
		shcp <= 1'b1;
	else
		shcp <= 1'b0;
		
//ds hc595芯片的输入信号
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
		ds <= 1'b0;
	else if(cnt == 2'd0)
		ds <= data[cnt_bit];
	else
		ds <= ds;

endmodule