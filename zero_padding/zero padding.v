module ZP_single#(parameter W=32, H=32, DATA_WIDTH=8, P=1) 
// W:featuremap width
// H:featuremap height
// DATA_WIDTH: each pixel has 16bits
// P: number of padding
   (input [W*H*DATA_WIDTH-1:0] In_map, 
   output reg [(W+2*P)*(H+2*P)*DATA_WIDTH-1:0] Out_map);

   reg [DATA_WIDTH-1:0] inmap[0:W*H-1]; 
   reg [DATA_WIDTH-1:0] outmap[0:(W+2*P)*(H+2*P)-1];

// outmap reset
   integer index;
   always@(In_map) begin
	for ( index=0; index<(W+2*P)*(H+2*P); index=index+1 ) begin
	   outmap[index] = 0;
	end
   end


//  In_map to map : linear data to (32*32)*8bit array data
   genvar i;
   generate
// input data to register
	for ( i=0; i<W*H; i=i+1 ) begin :bit 
	   always @(In_map)
		//inmap[i] = In_map[W*H*DATA_WIDTH-i*DATA_WIDTH-1:W*H*DATA_WIDTH-i*DATA_WIDTH-DATA_WIDTH]; 
		inmap[i] = In_map[DATA_WIDTH*(W*H-i-1) +: DATA_WIDTH];
	end
   endgenerate


// zero padding
	integer a, b;
	always @(In_map) begin
		for (a=0; a<W; a=a+1) begin
			for (b=0; b<H; b=b+1) begin
				outmap[(W+2*P)*(b+P)+P+a] = inmap[W*b+a];
			end
		end
	end


// 2D array to 1D
	integer j;
	always @(In_map) begin
		for ( j=0; j<(W+2*P)*(H+2*P); j=j+1) begin 
			Out_map[DATA_WIDTH*((W+2*P)*(H+2*P)-j-1) +: DATA_WIDTH] = outmap[j]; //[a +: b] --> [a+b-1 : a]
		//Out_map [W*H*DATA_WIDTH-j*DATA_WIDTH-1:W*H*DATA_WIDTH-j*DATA_WIDTH-DATA_WIDTH] = map_relu[j];
		end
	end
endmodule
