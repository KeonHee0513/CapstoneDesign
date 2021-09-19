module ReluSingle #(parameter W=28, H=28, DATA_WIDTH=16) 
// W:featuremap width
// H:featuremap height
// DATA_WIDTH: each pixel has 16bits
   (input [W*H*DATA_WIDTH-1:0] In_map, 
   output reg [W*H*DATA_WIDTH-1:0] Out_map);

   reg [DATA_WIDTH-1:0] map_relu[0:W*H-1]; 

//  In_map to map_relu : linear data to (5*5)*16bit array data
   genvar i;
   generate
	for ( i=0; i<W*H; i=i+1 ) begin :bit 
	   always @(In_map)
		//map_relu[i] = In_map[W*H*DATA_WIDTH-i*DATA_WIDTH-1:W*H*DATA_WIDTH-i*DATA_WIDTH-DATA_WIDTH]; 
		map_relu[i] = In_map[DATA_WIDTH*(W*H-i-1) +: DATA_WIDTH];
	end
   endgenerate

// map_relu to Out_map : array data to linear data
   genvar j;
   generate
	for ( j=0; j<W*H; j=j+1) begin 
	   always @(In_map) begin
		if(map_relu[j][DATA_WIDTH-1] == 1'b1) //sign bit == 1 --> Out_map = 0
		   Out_map[DATA_WIDTH*(W*H-j-1) +: DATA_WIDTH] = 0;
		   //Out_map [W*H*DATA_WIDTH-j*DATA_WIDTH-1:W*H*DATA_WIDTH-j*DATA_WIDTH-DATA_WIDTH] = 0;
		else
		   Out_map[DATA_WIDTH*(W*H-j-1) +: DATA_WIDTH] = map_relu[j];
		   //Out_map [W*H*DATA_WIDTH-j*DATA_WIDTH-1:W*H*DATA_WIDTH-j*DATA_WIDTH-DATA_WIDTH] = map_relu[j];
	   end
	end
   endgenerate
endmodule
