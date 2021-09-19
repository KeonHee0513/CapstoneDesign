module ReluMulti #(parameter W=28, H=28, D=6, DATA_WIDTH=16) 
// W:featuremap width
// H:featuremap height
// D:featuremap depth
// DATA_WIDTH: each pixel has 16bits
   (input [W*H*D*DATA_WIDTH-1:0] In_map, 
   input clk, reset,
   output reg [W*H*D*DATA_WIDTH-1:0] Out_map);

reg [W*H*DATA_WIDTH-1:0] In_map_s;
wire [W*H*DATA_WIDTH-1:0] Out_map_s;
integer counter;

ReluSingle #(W, H, DATA_WIDTH) relu1 (In_map_s, Out_map_s);

always @(posedge clk or posedge reset) begin
   if(reset == 1'b1) begin
	counter=0;
   end
   else if (counter<D) begin
	counter = counter+1;
   end
end


always @ (*) begin
   In_map_s = In_map[counter*H*W*DATA_WIDTH+:H*W*DATA_WIDTH];
   Out_map[counter*H*W*DATA_WIDTH+:H*W*DATA_WIDTH] = Out_map_s;
end

endmodule
