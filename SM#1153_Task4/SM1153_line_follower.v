//IDLE , PID, stop , hold

module SM1153_line_follower(
	input clk_50,
	input [11:0]input1,
	input [11:0]input2,
	input [11:0]input3,
	output d_input1,
	output d_input2,
	output d_input3,
	output [7:0]motor_a_t1,
	output [7:0]motor_a_t2,
	output [7:0]motor_b_t1,
	output [7:0]motor_b_t2,
	input [7:0]error_node,
	output node_detected_temp,
	output r_node_detected_temp,
	input [5:0]node
);
//reg signed[4:0] a=30;
//reg signed[4:0] b=40;
reg node_detected=0;
reg signed [7:0] motor_a_t1_temp=76;//left //74

reg signed [7:0]motor_b_t1_temp=76;//right//74

reg signed[7:0] kp=6;//14//16//4.25
reg signed[7:0] kd=1.2;//7.3//7.38
reg signed[7:0] ki=0;
reg signed[7:0] error=0;
reg signed[7:0] previous_error=0;

reg signed[7:0] p=0;
reg signed[7:0] i=0;
reg signed[7:0] d=0;
reg signed[7:0] pid_value;
parameter thres_lower=300;
parameter thres_upper=2500;
reg digital_input1;
reg digital_input2;
reg digital_input3;

always@(posedge clk_50)begin
if(input1 < thres_upper)
digital_input1<=1'b1;
else if (input1>=thres_upper) digital_input1<=1'b0;
if(input2<thres_upper)
digital_input2<=1'b1;
else if(input2>=thres_upper) digital_input2<=1'b0;
if(input3<thres_upper)
digital_input3<=1'b1;
else  if (input3>=thres_upper) digital_input3<=1'b0;

end
assign d_input1=digital_input1;
assign d_input2=digital_input2;
assign d_input3=digital_input3;
reg r_node_detected;
always@(posedge clk_50)begin

if(digital_input1==1 && digital_input2==0 && digital_input3==1)begin
error<=0;
node_detected<=0;
end
else if(digital_input1==0 && digital_input2==1 && digital_input3==1)begin
error<=2;
node_detected<=0;
end
else if(digital_input1==1 && digital_input2==1 && digital_input3==0)begin//when dinput1 and all other 0 error = -2
error<=-2;
node_detected<=0;
end
//////////////////////////////////
else if(digital_input1==0 && digital_input2==0 && digital_input3==0)begin
///node_detected
node_detected<=1;
error<=error_node;//for now
end
else if(digital_input1==0 && digital_input2==0 && digital_input3==1)begin
node_detected<=0;
error<=1;
end
else if(digital_input1==1 && digital_input2==0 && digital_input3==0)begin
node_detected<=0;
error<=-1;
end

//////////////////////////////////
end
reg signed[7:0]motor_a;
reg signed[7:0]motor_b;
reg signed[7:0]motor_a1=0;
reg signed[7:0]motor_b1=0;
reg [1:0]state=IDLE;
parameter IDLE=2'b00;
parameter PID=2'b01;
parameter hold=2'b10;
parameter stop=2'b11;
reg [31:0]count_delay=0;
parameter delay=100000000;
parameter delay_stop=10000000;

always@(posedge clk_50)begin
case(state)
IDLE:
	begin
	if(node==22)begin
	state<=stop;
	end
	r_node_detected<=0;
	 if(node_detected==0)begin
	 state<=PID;
	 end
	 else if(node_detected==1 && error==10 || error==-10)begin
	 state<=stop;
	 end
	 else state<=PID;
	end
PID:
	begin
	if(node==22)begin
	state<=node;
	end
	if(node_detected==1 && error ==10 || error==-10)begin
	count_delay<=0;
	state<=stop;
	end
	else begin
	r_node_detected<=0;
	p<=error;
	i<=i+previous_error;
	d<=error-previous_error;
	previous_error<=error;
	pid_value<=kp*p + ki*i+kd*d;
	motor_a<=motor_a_t1_temp-pid_value;
	motor_b<=motor_b_t1_temp+pid_value;
	state<=PID;
	end
	end
hold:
	begin
	if(count_delay<=delay)
begin
	count_delay<=count_delay+1;
	r_node_detected<=1;
	if(error==10)begin
	motor_a<=0;
	motor_b<=100;
	motor_a1<=100;
	motor_b1<=0;
	end
	else begin
	motor_a<=100;
	motor_b<=0;
	motor_a1<=0;
	motor_b1<=100;
	end
	state<=hold;
end
	else begin
	motor_a<=0;
	motor_b<=0;
	motor_a1<=0;
	motor_b1<=0;
	count_delay<=0;
	r_node_detected<=0;
	state<=IDLE;
	
	end
	end
stop: 
	begin
	if(count_delay<=delay_stop||node==22)begin
	count_delay<=count_delay+1;
	motor_a<=0;
	motor_b<=0;
	r_node_detected<=1;
	
	end
	else begin
	count_delay<=0;
	r_node_detected<=0;
	state<=hold;
	end
	end
endcase
end
assign motor_a_t1=motor_a;
assign motor_b_t1=motor_b;
assign motor_a_t2=motor_a1;
assign motor_b_t2=motor_b1;
assign node_detected_temp=node_detected;
assign r_node_detected_temp=r_node_detected;

endmodule

///////////////////////////////////
