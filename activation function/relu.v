module relu #(parameter fm_width=5, fm_height=5, value_size=16) // input, output size 5*5 and value size 16bits
   (input [fm_width*fm_height*value_size-1:0] In_map, 
   output reg [fm_width*fm_height*value_size-1:0] Out_map);

   reg [value_size-1:0] map_relu[0:fm_width*fm_height-1]; 

//  In_map to map_relu : linear data to (5*5)*16bit array data
   genvar i;
   generate
	for ( i=0; i<fm_width*fm_height; i=i+1 ) begin :bit 
	   always @(In_map)
		map_relu[i] = In_map[fm_width*fm_height*value_size-i*value_size-1:fm_width*fm_height*value_size-i*value_size-value_size]; 
	end
   endgenerate

// map_relu to Out_map : array data to linear data
   genvar j;
   generate
	for ( j=0; j<fm_width*fm_height; j=j+1) begin 
	   always @(In_map) begin
		if(map_relu[j][value_size-1] == 1'b1) //sign bit == 1 --> Out_map = 0
		   Out_map [fm_width*fm_height*value_size-j*value_size-1:fm_width*fm_height*value_size-j*value_size-value_size] = 0;
		else
		   Out_map [fm_width*fm_height*value_size-j*value_size-1:fm_width*fm_height*value_size-j*value_size-value_size] = map_relu[j];
	   end
	end
   endgenerate
endmodule
