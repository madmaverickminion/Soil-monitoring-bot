// SM : Task 2 A : ADC
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design ADC Controller.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//ADC Controller design
//Inputs  : clk_50 : 50 MHz clock, dout : digital output from ADC128S022 (serial 12-bit)
//Output  : adc_cs_n : Chip Select, din : Ch. address input to ADC128S022, adc_sck : 2.5 MHz ADC clock,
//				d_out_ch5, d_out_ch6, d_out_ch7 : 12-bit output of ch. 5,6 & 7,
//				data_frame : To represent 16-cycle frame (optional)

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////
module line_follower(
	input  clk_50,				//50 MHz clock
	input  dout,				//digital output from ADC128S022 (serial 12-bit)
	output adc_cs_n,			//ADC128S022 Chip Select
	output din,					//Ch. address input to ADC128S022 (serial)
	output adc_sck,			//2.5 MHz ADC clock
	output [11:0]d_out_ch5,	//12-bit output of ch. 5 (parallel)
	output [11:0]d_out_ch6,	//12-bit output of ch. 6 (parallel)
	output [11:0]d_out_ch7,	//12-bit output of ch. 7 (parallel)
	output [1:0]data_frame	//To represent 16-cycle frame (optional)
	
);
	
////////////////////////WRITE YOUR CODE FROM HERE////////////////////
assign adc_cs_n=1'b0;

reg [7:0] counter=8'b0;
parameter DIVISOR=20;
reg freq;

always@(negedge clk_50)
begin
counter<=counter+8'd1;
if(counter>= (DIVISOR -1))
counter<= 8'd0;
freq<= (counter<DIVISOR/2)?0:1;
end
assign adc_sck=freq;
/////////////adc_sck done!!!!////////////
reg [4:0]sclk_count_neg=5'b00000;
reg [1:0]data_frame_temp=2'b00;

always@(negedge adc_sck)begin
if(sclk_count_neg==5'b10000)begin

sclk_count_neg<=1;

end
else 
sclk_count_neg<=sclk_count_neg+1;


end

reg[1:0] addr=2'b01;

always@(negedge adc_sck)begin

if(sclk_count_neg==16)begin
addr<=addr+1'b1;
if(data_frame_temp==2)begin
data_frame_temp<=2'b00;

end
else data_frame_temp<=data_frame_temp+1;
end

end
assign data_frame=data_frame_temp;
////////////////data frame done!!!!!///////////////

reg din_temp;

always@(negedge adc_sck)begin
case(sclk_count_neg)
	5'b00011:din_temp<=addr[1];
	5'b00100:din_temp<=addr[0];
	5'b00010:din_temp<=1'b1;
	default:din_temp<=1'b0;
	endcase
end
assign din=din_temp;
//////////din_done///////////////////////////


reg [11:0]register=12'b0;

reg [4:0]sclk_count_pos=5'b0;
always@(posedge adc_sck)begin
if(sclk_count_pos==15)begin
sclk_count_pos<=5'b00000;

end
else sclk_count_pos<=sclk_count_pos+1;

end

always@(posedge adc_sck)begin

case (sclk_count_pos)

		5'b00100:register <={register[10:0],dout};
      5'b00101:register <= {register[10:0],dout}; 
		5'b00110:register <= {register[10:0],dout};  
		5'b00111:register <= {register[10:0],dout};  
		5'b01000:register <= {register[10:0],dout};  
		5'b01001:register <= {register[10:0],dout};  
		5'b01010:register <= {register[10:0],dout};  
		5'b01011:register <= {register[10:0],dout};  
		5'b01100:register <= {register[10:0],dout};  
		5'b01101:register <= {register[10:0],dout};  
		5'b01110:register <= {register[10:0],dout};  
		5'b01111:register <= {register[10:0],dout};  
		5'b10000:register <= {register[10:0],dout};  
 
    endcase
end	  

reg [11:0] d_out_ch5_temp=12'b0;
reg [11:0] d_out_ch6_temp=12'b0;
reg [11:0] d_out_ch7_temp=12'b0;
always@(negedge adc_sck)begin
if(sclk_count_neg==5'b10000)begin
case(addr)
2'b01:d_out_ch7_temp<=register;
2'b11:d_out_ch6_temp<=register;
2'b10:d_out_ch5_temp<=register;
endcase
end
end
assign d_out_ch7=d_out_ch7_temp;
assign d_out_ch6=d_out_ch6_temp;
assign d_out_ch5=d_out_ch5_temp;

	
////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////