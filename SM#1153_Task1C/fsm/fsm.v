// SM : Task 1 C : Finite State Machine
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a Finite State Machine.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
			Do not make any changes to Test_Bench_Vector.txt file. Violating will result into Disqualification.
-------------------
*/

//Finite State Machine design
//Inputs  : I (4 bit) and CLK (clock)
//Output  : Y (Y = 1 when 1094 sequence(decimal number sequence) is detected)

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////
module fsm(
	input CLK,			  //Clock
	input [3:0]I,       //INPUT I
	output Y		  //OUTPUT Y
);

////////////////////////WRITE YOUR CODE FROM HERE//////////////////// 
	

// Tip : Write your code such that Quartus Generates a State Machine 
//			(Tools > Netlist Viewers > State Machine Viewer).
// 		For doing so, you will have to properly declare State Variables of the
//       State Machine and also perform State Assignments correctly.
//			Use Verilog case statement to design.
	parameter S0=0,S1=1,S2=2,S3=3,S4=4;
	reg [2:0] NS,PS;
	reg temp;
	
	
	
	always @(posedge CLK)
		PS<=NS;
	always @(PS , I)
	begin
		case (PS)
		S0 : begin
				temp=0;
				if(I[3]==0 && I[2]==0 && I[1]==0 && I[0]==1)
				NS = S1;
				else NS = S0;
				end
		S1 : begin
				temp=0;
				if(I[3]==0 && I[2]==0 && I[1]==0 && I[0]==0)
				NS =S2;
				else 
				NS =S0;
				end
		S2 : begin
				temp=0;
				if(I[3]==1 && I[2]==0 && I[1]==0 && I[0]==1)
				NS = S3;
				else NS =S0;
				end
		S3 : begin
				if(I[3]==0 && I[2]==1 && I[1]==0 && I[0]==0)
				begin
				temp=0;
				NS =S4;
				end
				else begin
				temp=0;
				NS =S0;
				
				end
				end
		S4: begin
				temp=1;
				if(I[3]==0 && I[2]==0 && I[1]==0 && I[0]==1)
				NS=S1;
				else NS=S0;
				end
		default : begin
		NS=S0;
		temp=0;
		end
		endcase
		end


	assign Y=temp;

////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////