module tb_ZP_single();
parameter W = 32, H = 32, DATA_WIDTH = 8, P=1;

// read sample_r
reg [DATA_WIDTH-1:0]  sample_r[0:W*H-1];
	initial begin
		$readmemh("C:/intelFPGA/project/00000_00000_r.txt",sample_r);
	end



reg [W*H*DATA_WIDTH-1:0] In_map;
wire [(W+2*P)*(H+2*P)*DATA_WIDTH-1:0] Out_map;
reg [DATA_WIDTH-1:0] outmap[0:(W+2*P)*(H+2*P)-1];

// convert smaple_r from 2D to 1D
genvar i;
generate
	for ( i=0; i<W*H; i=i+1) begin  :bit 
	   initial begin
		In_map[DATA_WIDTH*(W*H-i-1) +: DATA_WIDTH] = sample_r[i]; //[a +: b] --> [a+b-1 : a]
	   end
	end
endgenerate

   ZP_single #(W, H, DATA_WIDTH, P) ZP_single1 (In_map, Out_map);



// convert Out_map from 1D to 2D
	integer j;
	initial begin
		#5
		for ( j=0; j<(W+2*P)*(H+2*P); j=j+1 ) begin
			//Out_map[DATA_WIDTH*((W+2*P)*(H+2*P)-j-1) +: DATA_WIDTH] = outmap[j]
			outmap[j] = Out_map[DATA_WIDTH*((W+2*P)*(H+2*P)-j-1) +: DATA_WIDTH];
		end
	end



// file out the outmap 
integer index;
integer f_result;
initial begin
	f_result = $fopen("C:\\intelFPGA\\project\\out_padded.txt", "w");
	#10
	for(index=0; index<(W+2*P)*(H+2*P); index=index+1)
		$fwrite(f_result, "%h ", outmap[index]);
	$fclose(f_result);
end

endmodule


/*module tb_file_io();

reg signed [7:0]  W1_mem[0:32*32-1];
integer f_result;
integer i;

	initial
	begin
		$readmemh("C:/intelFPGA/project/00000_00000_r.txt",W1_mem);
		f_result = $fopen("C:\\intelFPGA\\project\\result.txt", "w");
		#10
		for(i=0; i<32*32; i=i+1)
		begin
			$fwrite(f_result, "%h ", W1_mem[i]);
		end
		$fclose(f_result);
	end

endmodule*/

/*integer i;
integer file_id;

initial
begin
	#10
	file_id= $fopen("C:\\intelFPGA\\project\\file_id.txt","w");
	#10
	for(i=0; i<1023; i=i+1)
	begin
		$fwrite(file_id, "%02h", i);
	end

	#10
	$fclose(file_id);
	#10
	$finish;
end*/