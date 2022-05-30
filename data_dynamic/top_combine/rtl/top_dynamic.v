module	top_dynamic
(
	input	wire	sys_clk,
	input	wire	sys_rst_n,
	
	output	wire		stcp,
	output	wire		shcp,
	output	wire		ds,
	output	wire		oe
);

wire [19:0]	data;
wire [5:0]	point;
wire		sign;
wire		seg_en;

data_gen data_gen_inst
(
	.sys_clk	(sys_clk),
	.sys_rst_n	(sys_rst_n),

	.data		(data),
	.point		(point),
	.sign		(sign),
	.seg_en     (seg_en)

);

dynamic_combine dynamic_combine_inst
(
	.sys_clk	(sys_clk),
	.sys_rst_n	(sys_rst_n),
	.sign		(sign),
	.seg_en		(seg_en),
	.data		(data),
	.point		(point),

	.shcp		(shcp),
	.stcp		(stcp),
	.oe			(oe),
	.ds         (ds)

);

endmodule