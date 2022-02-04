/*minvertex ka declaration glt ho sakta hai 

*/
module test_(
input clk_50,
output [31:0] node1,
output [31:0] node2,
output [31:0] node3,
output [31:0] node4,
output [31:0]node5
);
//00 straight, 01 left , 10 right , 11 backward
//00 west 01 east 10 north 11 south
parameter n=36;
reg [2:0]robo_command[0:n];
reg [1:0]direction=00;//west

reg [31:0]counter1=0;
integer temp;
integer t=0;

integer arena[0:n][0:n];
parameter infinity=100000;
integer path1[0:n];
integer path[0:n];

integer dist;
integer distance[0:n];

integer start_node=1;////////////////////////
integer end_node=16;///////////////////////////

integer visited[0:n];
integer i;
integer minVertex=-1;
integer j;
integer j1;
reg [31:0]counter=0;

integer x_coordinate[0:36];
integer y_coordinate[0:36];

initial begin


for(i=0;i<=n;i=i+1)begin
for(j=0;j<=n;j=j+1)begin
arena[i][j]=0;
end
end
for(i=0;i<=n;i=i+1)begin
robo_command[i]=-1;

end

arena[0][1]=1;arena[0][9]=1;arena[0][8]=1;arena[1][0]=1;arena[9][0]=1;arena[8][0]=1;
arena[1][18]=1;arena[1][2]=1;arena[18][1]=1;arena[2][1]=1;
arena[2][20]=1;arena[2][3]=1;arena[20][2]=1;arena[3][2]=1;
arena[18][15]=1;arena[18][19]=1;arena[15][18]=1;arena[19][18]=1;
arena[15][16]=1;arena[15][13]=1;arena[15][25]=1;arena[16][15]=1;arena[13][15]=1;arena[25][15]=1;
arena[16][17]=1;arena[16][26]=1;arena[17][16]=1;arena[26][16]=1;
arena[17][22]=1;arena[17][4]=1;arena[22][17]=1;arena[4][17]=1;
arena[3][21]=1;arena[3][4]=1;arena[21][3]=1;arena[4][3]=1;
arena[4][5]=1;arena[5][4]=1;
arena[26][5]=1;arena[26][23]=1;arena[5][26]=1;arena[23][26]=1;
arena[5][6]=1;arena[6][5]=1;
arena[14][6]=1;arena[14][24]=1;arena[14][13]=1;
arena[6][14]=1;arena[24][14]=1;arena[13][14]=1;
arena[6][7]=1;arena[7][6]=1;
arena[7][27]=1;arena[27][7]=1;
arena[7][8]=1;arena[8][7]=1;
arena[8][36]=1;arena[36][8]=1;
arena[36][28]=1;arena[36][13]=1;arena[13][12]=1;
arena[28][36]=1;arena[13][36]=1;arena[12][13]=1;
arena[12][35]=1;arena[12][11]=1;arena[35][12]=1;arena[11][12]=1;
arena[11][33]=1;arena[11][34]=1;arena[11][10]=1;arena[33][11]=1;arena[34][11]=1;arena[10][11]=1;
arena[10][31]=1;arena[10][32]=1;arena[10][9]=1;
arena[31][10]=1;arena[32][10]=1;arena[9][10]=1;
arena[9][29]=1;arena[9][30]=1;arena[29][9]=1;arena[30][9]=1;

x_coordinate[0]=55;y_coordinate[0]=130;x_coordinate[1]=55;y_coordinate[1]=145;x_coordinate[2]=55;y_coordinate[2]=155;x_coordinate[3]=35;y_coordinate[3]=170;x_coordinate[4]=20;y_coordinate[4]=170;x_coordinate[5]=0;y_coordinate[5]=150;x_coordinate[6]=0;y_coordinate[6]=130;x_coordinate[7]=0;y_coordinate[7]=120;x_coordinate[8]=20;y_coordinate[8]=115;x_coordinate[9]=45;y_coordinate[9]=130;x_coordinate[10]=40;y_coordinate[10]=130;x_coordinate[11]=30;y_coordinate[11]=130;x_coordinate[12]=25;y_coordinate[12]=130;x_coordinate[13]=20;y_coordinate[13]=130;x_coordinate[14]=10;y_coordinate[14]=130;x_coordinate[15]=20;y_coordinate[15]=145;x_coordinate[16]=20;y_coordinate[16]=150;x_coordinate[17]=20;y_coordinate[17]=160;x_coordinate[18]=35;y_coordinate[18]=145;x_coordinate[19]=35;y_coordinate[19]=150;x_coordinate[20]=50;y_coordinate[20]=155;x_coordinate[21]=35;y_coordinate[21]=165;x_coordinate[22]=15;y_coordinate[22]=160;x_coordinate[23]=10;y_coordinate[23]=155;x_coordinate[24]=10;y_coordinate[24]=135;x_coordinate[25]=15;y_coordinate[25]=145;x_coordinate[26]=10;y_coordinate[26]=150;x_coordinate[27]=5;y_coordinate[27]=120;x_coordinate[28]=15;y_coordinate[28]=125;x_coordinate[29]=45;y_coordinate[29]=125;x_coordinate[30]=45;y_coordinate[30]=135;x_coordinate[31]=40;y_coordinate[31]=125;x_coordinate[32]=40;y_coordinate[32]=135;x_coordinate[33]=30;y_coordinate[33]=125;x_coordinate[34]=30;y_coordinate[34]=135;x_coordinate[35]=25;y_coordinate[35]=135;x_coordinate[36]=20;y_coordinate[36]=125;

end

always @(posedge clk_50) begin
if(counter<=0)begin


for(i=0;i<=n;i=i+1)begin
path1[i]=-1;
end

counter=counter+1;
for(i=0; i<=n;i=i+1)begin
distance[i]=infinity;
visited[i]=0;
end
distance[start_node]=0;
minVertex=-1;
for(i=0;i<=n;i=i+1)begin
	minVertex=-1;
	for(j=0;j<n+1;j=j+1)begin

	if(visited[j]==0)begin
	if(minVertex==-1)begin
	minVertex=j;
	end
	else if(distance[j]<distance[minVertex]) begin
	minVertex=j;
	end
	end
	end
visited[minVertex]=1;

	for(j1=0;j1<n+1;j1=j1+1)begin
		
		
		if(arena[minVertex][j1]!=0 && visited[j1]==0)begin
			dist=distance[minVertex]+arena[minVertex][j1];

		if(dist<distance[j1])begin
				distance[j1]=dist;
				counter1=1;
				path[j1]=minVertex;
				
			end
		end
	end

end
t=end_node;
i=0;
while(t!=start_node && i<=n)begin
path1[i]=t;
i=i+1;
t=path[t];

end
path1[i]=t;

t=0;
for(j=36;j>=1;j=j-1)begin
if(path1[j]!=-1)begin
if(x_coordinate[path1[j]]>x_coordinate[path1[j-1]]&&y_coordinate[path1[j]]==y_coordinate[path1[j-1]])begin
//final direction of bot should be north
	if(direction==00)begin
	robo_command[t]=2;//right;
	end
	else if(direction==01)begin
	robo_command[t]=1;//left
	end
	else if(direction==2)begin
	robo_command[t]=0;
	end
	else if(direction==3)begin
	robo_command[t]=3;
	end
	direction=2;
end
else if(x_coordinate[path1[j]]<x_coordinate[path1[j-1]]&&y_coordinate[path1[j]]==y_coordinate[path1[j-1]])begin
//final direction of bot should be south
	if(direction==00)begin
	robo_command[t]=1;
	end
	else if(direction==01)begin
	robo_command[t]=2;
	end
	else if(direction==2)begin
	robo_command[t]=3;
	end
	else if(direction==3)begin
	robo_command[t]=0;
	end
	direction=3;
end
else if(y_coordinate[path1[j]]<y_coordinate[path1[j-1]]&&x_coordinate[path1[j]]==x_coordinate[path1[j-1]])begin
//final direction of bot should be west
if(direction==0)begin
	robo_command[t]=0;//backward
	end
	else if(direction==1)begin
	robo_command[t]=3;//
	end
	else if(direction==2)begin
	robo_command[t]=1;
	end
	else if(direction==3)begin
	robo_command[t]=2;
	end
	direction=0;
end
else if(y_coordinate[path1[j]]>y_coordinate[path1[j-1]]&&x_coordinate[path1[j]]==x_coordinate[path1[j-1]])begin
//final direction of bot should be east
	if(direction==00)begin
	robo_command[t]=3;//right;
	end
	else if(direction==01)begin
	robo_command[t]=0;//straight
	end
	else if(direction==2)begin
	robo_command[t]=2;
	end
	else if(direction==3)begin
	robo_command[t]=1;
	end
	direction=1;
end
else begin
if(x_coordinate[path1[j]]==55 && y_coordinate[path1[j]]==130 &&x_coordinate[path1[j-1]]==20&&y_coordinate[path1[j-1]]==115)begin
robo_command[t]=0;
direction=2;//north
end
else if(x_coordinate[path1[j-1]]==55 && y_coordinate[path1[j-1]]==130 &&x_coordinate[path1[j]]==20&&y_coordinate[path1[j]]==115)begin
robo_command[t]=0;
direction=3;
end
else if(x_coordinate[path1[j]]==55 && y_coordinate[path1[j]]==155 &&x_coordinate[path1[j-1]]==35&&y_coordinate[path1[j-1]]==170)begin
robo_command[t]=0;
direction=2;
end
else if(x_coordinate[path1[j-1]]==55 && y_coordinate[path1[j-1]]==155 &&x_coordinate[path1[j]]==35&&y_coordinate[path1[j]]==170)begin
robo_command[t]=0;
direction=3;
end
else if(x_coordinate[path1[j]]==20 && y_coordinate[path1[j]]==170 &&x_coordinate[path1[j-1]]==0&&y_coordinate[path1[j-1]]==150)begin
robo_command[t]=0;
direction=1;
end
else if(x_coordinate[path1[j-1]]==20 && y_coordinate[path1[j-1]]==170 &&x_coordinate[path1[j]]==0&&y_coordinate[path1[j]]==150)begin
robo_command[t]=0;
direction=3;
end
else if(x_coordinate[path1[j]]==0 && y_coordinate[path1[j]]==120 &&x_coordinate[path1[j-1]]==20&&y_coordinate[path1[j-1]]==115)begin
robo_command[t]=0;
direction=3;
end
else if(x_coordinate[path1[j-1]]==0 && y_coordinate[path1[j-1]]==120 &&x_coordinate[path1[j]]==20&&y_coordinate[path1[j]]==115)begin
robo_command[t]=0;
direction=0;
end

end
t=t+1;
end
end

end

end


assign node5=robo_command[5];
assign node4=robo_command[3];
assign node3=robo_command[2];
assign node2=robo_command[1];
assign node1=robo_command[0];
endmodule