module	dynamic_combine
(
	input	wire		sys_clk,
	input	wire		sys_rst_n,
	input	wire		sign,
	input	wire		seg_en,
	input	wire [19:0]	data,
	input	wire [5:0]	point,
	
	output	wire			shcp,
	output	wire			stcp,
	output	wire			oe,
	output	wire			ds

);
wire		[5:0]	sel;
wire		[7:0]	seg;

seg_dynamic seg_dynamic_inst
(
	.sys_clk  (sys_clk),
    .sys_rst_n(sys_rst_n),
	.data     (data),
    .point    (point),
    .sign     (sign),
    .seg_en   (seg_en),

	.sel      (sel),	
    .seg      (seg)
); 

hc595 hc595_inst
(
	.sys_clk	(sys_clk),
	.sys_rst_n	(sys_rst_n),
	.sel 		(sel),
	.seg 		(seg),

	.stcp		(stcp),
	.shcp		(shcp),
	.oe  		(oe),
	.ds         (ds)

);

endmodule