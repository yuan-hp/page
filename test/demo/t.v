module t(input clk , output y);

reg [2:0] cnt;
assign y = (cnt>2);
always @( posedge clk ) 
    cnt <= cnt + 1;
 
endmodule 