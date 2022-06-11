`timescale 1ns / 1ps

module tlc(input x,clk,rst,output reg [1:0] hwy,cntry);

parameter RED=2'b00,YELLOW=2'b01,GREEN=2'b10;
parameter TRUE=1'b1,FALSE=1'b0;

//states
parameter s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100;

//delays
parameter dYR=3,dRG=2;

reg[2:0] state,next_state;

//present state logic
always @(posedge clk or posedge rst)
begin 
if(rst)
state<=s0;
else
state<=next_state;
end

//next state logic
always @(state or x)
begin
case(state)
s0:next_state=x?s1:s0;

s1:begin
repeat(dYR) @(posedge clk); 
next_state=s2;
end

s2:begin
repeat(dRG) @(posedge clk);
next_state=s3;
end

s3:next_state=x?s3:s4;

s4:begin
repeat(dYR) @(posedge clk); 
next_state=s0;
end

default: next_state=s0;
endcase
end

//output logic
always @(state)
begin
hwy=GREEN;
cntry=RED;
case(state)
s0: ;

s1:begin
hwy=YELLOW;
end

s2:begin
hwy=RED;
end

s3:begin
hwy=RED;
cntry=GREEN;
end

s4:begin
hwy=RED;
cntry=YELLOW;
end

endcase
end

endmodule
