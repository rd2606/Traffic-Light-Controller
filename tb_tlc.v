`timescale 1ns / 1ps

module tb_tlc();

reg x,clk,rst;
wire [1:0] hwy,cntry;

tlc TLC(.x(x),.clk(clk),.rst(rst),.hwy(hwy),.cntry(cntry));

initial
begin
rst=1'b1;
#2 rst=1'b0;
end

initial
begin
clk=1'b0;
forever #1 clk=~clk;
end

initial
begin
x=1'b0;
forever #20 x=~x;
end

initial
$monitor($time,"x=%b,clk=%b,rst=%b,hwy=%b,cntry=%b",x,clk,rst,hwy,cntry);

initial
#100 $finish;

endmodule
