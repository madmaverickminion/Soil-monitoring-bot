// FPGA Bot : Task 1 D : PWM Generator
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a module which will scale down the 50Mhz Clock Frequency to 1Mhz and perform Pulse Width Modulation on it.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//PWM Generator
//Inputs : Clk, DUTY_CYCLE
//Output : PWM_OUT

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////

module PWM_Generator(
 
	input clk,             // Clock input
	input [7:0]DUTY_CYCLE, // Input Duty Cycle
	output PWM_OUT         // Output PWM
);
 
////////////////////////WRITE YOUR CODE FROM HERE////////////////////
wire temp;
reg freq_1;
reg[7:0] counter=8'd0;
parameter DIVISOR=50;

reg [7:0]counter_1=0;
always@(posedge clk)
begin
counter<=counter+8'd1;
if(counter>= (DIVISOR -1))
counter<= 8'd0;
freq_1<= (counter<DIVISOR/2)?1:0;

//



end
reg[7:0] counter1=8'd0;
parameter DIVISOR1=0.5;

//reg [7:0]counter_1=0;

assign temp=freq_1;
integer i;
//reg temp_op;
always@(posedge clk)
begin
if(counter1<8'd50)counter1<=counter+1;
else counter1<=0;
end


assign PWM_OUT=(counter1<DUTY_CYCLE/2+1);






////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////