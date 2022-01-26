// SM : Task 2 B : UART
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design UART Transmitter.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//UART Transmitter design
//Input   : clk_50M : 50 MHz clock
//Output  : tx : UART transmit output

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////
module uart(
	input clk_50M,	//50 MHz clock
	output tx		//UART transmit output
);
////////////////////////WRITE YOUR CODE FROM HERE////////////////////
parameter IDLE=3'b000;
parameter tx_start_bit=3'b001;
parameter tx_data_bit=3'b011;
parameter tx_stop_bit=3'b100;
parameter cleanup=3'b101;
parameter clks_per_bit=434;

reg counter=0;
reg[2:0]r_state=IDLE;
reg[9:0]r_clock_count=0;
reg[9:0]r_clock_count1=0;
reg[2:0]r_bit_index=0;
reg[7:0]r_data_bits=0;
reg[2:0]next=3'b000;

reg tx_serial;

always@(posedge clk_50M)
begin
case(r_state)
IDLE:
	begin
		r_clock_count=0;
		if(r_clock_count1<clks_per_bit-1)
		begin
		r_clock_count1<=r_clock_count1+1'b1;
		r_state<=IDLE;
		
		r_bit_index=0;
		tx_serial<=1'b1;
		end
		else if(next<=3)
		begin
		r_state<=tx_start_bit;
		end
		else 
		r_state<=IDLE;
		end

tx_start_bit:
	begin 
		tx_serial<=0;
		if(r_clock_count<clks_per_bit-1)
		begin
			r_clock_count<=r_clock_count+1'b1;
			r_state<=tx_start_bit;
			end
			else
			begin
			r_clock_count<=0;
			r_state<=tx_data_bit;
			if(next==0)r_data_bits=8'b01010011;
			else if(next==1)r_data_bits=8'b01001101;
			else if(next==2)r_data_bits=8'b00110101	;
			else if(next==3)r_data_bits=8'b00110011;
			else r_data_bits=0;
			end
			end
			
tx_data_bit:
	begin
		tx_serial<=r_data_bits[r_bit_index];
		if(r_clock_count<clks_per_bit-1)
		begin
			r_clock_count<=r_clock_count+1'b1;
			r_state<=tx_data_bit;
		end
		else 
		begin
			if(r_bit_index==7)
			begin
				r_clock_count<=0;
				r_state<=tx_stop_bit;
			end
			else
			begin
				r_clock_count<=0;
				r_state<=tx_data_bit;
				r_bit_index<=r_bit_index+1'b1;
			end
			end
			end
tx_stop_bit:
	begin
	tx_serial<=1;
	if(r_clock_count<2*(clks_per_bit)-3)
	begin
		r_clock_count<=r_clock_count+1'b1;
		r_state<=tx_stop_bit;
	end
	else 
	begin
	r_state<=cleanup;
	end
	end

cleanup:
	begin
		r_clock_count<=0;
		r_bit_index<=0;
		r_state<=IDLE;
		next=next+1'b1;
	end
default:
	begin
		r_state<=IDLE;
		end
endcase


end
		assign tx=tx_serial;
		



////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////