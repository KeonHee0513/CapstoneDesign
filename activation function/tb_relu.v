module tb_relu();
   parameter W = 5, H = 5, DATA_WIDTH = 16;

   reg [W*H*DATA_WIDTH-1:0] in;
   wire [W*H*DATA_WIDTH-1:0] out;

   ReluSingle #(W, H, DATA_WIDTH) relu1 (in, out);

   initial begin
	in = 400'hffff_0fff_ffff_0fff_ffff_0fff_ffff_0fff_ffff_0fff_ffff_0fff_ffff_0fff_ffff_0fff_ffff_0fff_ffff_0fff_ffff_0fff_ffff_0fff_ffff;
   end
endmodule


/*module tb_parameter_using();
   parameter fm_width = 5, fm_height = 5;

   reg [fm_width*fm_height*8-1:0] fm;
   wire [fm_width*fm_height*8-1:0] am;

   relu#(.fm_width(5), .fm_height(5)) relu1 (fm, am);

   initial begin
	fm = 200'h0000ffff0000abcd0000abcd0000abcd0000ffff0000ffff00;
	#10
	fm = 200'h1500;
   end
endmodule*/