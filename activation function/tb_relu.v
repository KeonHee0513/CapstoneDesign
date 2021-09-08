module tb_relu();
   parameter fm_width = 5, fm_height = 5, value_size = 16;

   reg [fm_width*fm_height*value_size-1:0] in;
   wire [fm_width*fm_height*value_size-1:0] out;

   relu #(fm_width, fm_height, value_size) relu1 (in, out);

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