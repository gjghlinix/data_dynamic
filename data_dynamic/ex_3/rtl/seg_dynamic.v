module seg_dynamic
(
	input	wire		sys_clk,
	input	wire		sys_rst_n,
	input	wire [19:0]	data,
	input	wire [5:0]	point,
	input	wire		sign,
	input	wire		seg_en,
	
	output	reg	[5:0]	sel,
	output	reg [7:0]	seg
);
//参数定义
parameter CNT_MAX = 16'd49_999;
//wire中间变量定义
wire [3:0]	unit;
wire [3:0]	ten;
wire [3:0]	hun;
wire [3:0]	thou;
wire [3:0]	t_thou;
wire [3:0]	h_thou;

//reg中间变量定义
reg [15:0]	cnt_1ms;
reg 		flag_1ms;
reg [23:0]	data_reg;
reg [2:0]	cnt_sel;
reg [5:0]	sel_reg;
reg [3:0]	data_display;
reg			data_dot;

