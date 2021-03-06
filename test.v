module test(
  output reg [7:0] D_R, D_G, D_B,
  output reg [3:0] COMM,
  output reg [1:0] COMM_CLK,
  output reg [5:0] life,
  output reg [6:0] d7_1,
  input CLK, left, right,reset);
  
  segment7 S0(bcd_s, A0,B0,C0,D0,E0,F0,G0);
  segment7 S1(bcd_m, A1,B1,C1,D1,E1,F1,G1);
  divfreq F4(CLK,CLK_div);
  divfreq1 div1(CLK, CLK_time);
  divmove F6(CLK,CLK_move);
  divmove01 F2(CLK,CLK_move01);
  divmove02 F3(CLK,CLK_move02);
  
  
  reg [3:0] bcd_s,bcd_m;
  reg [6:0] seg1, seg2;  
  reg LEFT,RIGHT;
  byte pos,count,count1;
  bit[2:0] cnt;
  integer a,b,touch;
  reg [7:0] plate[7:0];
  reg [7:0] people[7:0];
  reg [7:0] blueobj[7:0];
  reg [2:0] random01, random02, r, r1;
  
  reg [7:0] win [7:0]; 
  reg [7:0] over [7:0];
  
  initial
  begin
		bcd_m = 0;
		bcd_s = 0;
		cnt=0;
		touch=6;
		life=6'b111111;
		D_R=8'b11111111;
		D_G=8'b11111111;
		D_B=8'b11111111;
		COMM=4'b1000;
		random01 = (5*random01 + 3)%16;
		r = random01 % 8;
		random02 = (5*(random02+1) + 3)%16;
		r1 = random02 % 8;
		a=0;
		b=0;
		count1=1;
		over[0]= 8'b00111100;
		over[1]= 8'b00011000;
		over[2]= 8'b10000001;
		over[3]= 8'b11000011;
		over[4]= 8'b11000011;
		over[5]= 8'b10000001;
		over[6]= 8'b00011000;
		over[7]= 8'b00111100;
		win[0]= 8'b11000011;
		win[1]= 8'b10000001;
		win[2]= 8'b00111100;
		win[3]= 8'b00111100;
		win[4]= 8'b00111100;
		win[5]= 8'b00111100;
		win[6]= 8'b10000001;
		win[7]= 8'b11000011;
		pos=3;	//init position people	
		plate[0]= 8'b11111111;
		plate[1]= 8'b11111111;
		plate[2]= 8'b11111111;
		plate[3]= 8'b11111111;
		plate[4]= 8'b11111111;
		plate[5]= 8'b11111111;
		plate[6]= 8'b11111111;
		plate[7]= 8'b11111111;
		blueobj[0]= 8'b11111111;
		blueobj[1]= 8'b11111111;
		blueobj[2]= 8'b11111111;
		blueobj[3]= 8'b11111111;
		blueobj[4]= 8'b11111111;
		blueobj[5]= 8'b11111111;
		blueobj[6]= 8'b11111111;
		blueobj[7]= 8'b11111111;
		people[0]= 8'b11111111;
		people[1]= 8'b11111111;
		people[2]= 8'b01111111;
		people[3]= 8'b01111111;
		people[4]= 8'b01111111;
		people[5]= 8'b11111111;
		people[6]= 8'b11111111;
		people[7]= 8'b11111111;
  end
  //7段顯示器的視覺暫留
	always@(posedge CLK_div)
	begin
		seg1[0] = A0;
		seg1[1] = B0;
		seg1[2] = C0;
		seg1[3] = D0;
		seg1[4] = E0;
		seg1[5] = F0;
		seg1[6] = G0;
		
		seg2[0] = A1;
		seg2[1] = B1;
		seg2[2] = C1;
		seg2[3] = D1;
		seg2[4] = E1;
		seg2[5] = F1;
		seg2[6] = G1;
		
		if(count1 == 0)
			begin
				d7_1 <= seg1;
				COMM_CLK[1] <= 1'b1;
				COMM_CLK[0] <= 1'b0;
				count1 <= 1'b1;
			end
		else if(count1 == 1)
			begin
				d7_1 <= seg2;
				COMM_CLK[1] <= 1'b0;
				COMM_CLK[0] <= 1'b1;
				count1 <= 1'b0;
			end
	end
	//計時&進位	
	always@(posedge CLK_move01, posedge reset)
	begin
		if(reset)
			begin
				touch=6;
				bcd_m = 3'b0;
				bcd_s = 4'b0;
			end
		else
			begin
				//touch
				if(touch>0)
					begin
						if( people[r][7]==1'b1 && blueobj[r][7]==1'b0)
							begin
								touch=touch-1;
							end
						if(people[r][7]==1'b0 && blueobj[r][7]==1'b0)
							begin
								bcd_s <= bcd_s + 1;
								if(bcd_s >= 9)
									begin
										bcd_s <= 0;
										bcd_m <= bcd_m + 1;
									end		
							end
					end
							
					if(bcd_m >= 9) bcd_m <= 0;
			end
	end

	always@(posedge CLK_move01)
		begin
			if(reset==1)
				begin
					a=0;
					blueobj[0]= 8'b11111111;
					blueobj[1]= 8'b11111111;
					blueobj[2]= 8'b11111111;
					blueobj[3]= 8'b11111111;
					blueobj[4]= 8'b11111111;
					blueobj[5]= 8'b11111111;
					blueobj[6]= 8'b11111111;
					blueobj[7]= 8'b11111111;
				end
			// fall obj01
			if(touch>0 && bcd_m < 2)
				begin
					if(a == 0)
						begin
							random01 = (5*random01 + 3)%16;
							r = random01 % 8;
							blueobj[r][a] = 1'b0;	
							a = a+1;
						end
					else if (a > 0 && a <= 7)
						begin
							blueobj[r][a-1] = 1'b1;
							blueobj[r][a] = 1'b0;
							a = a+1;
						end
					else if(a == 8) 
						begin
							blueobj[r][a-1] = 1'b1;
							a = 0;
						end
				end
		end
	/*
	always@(posedge CLK_move02)
		begin
			if(reset==1)
				begin
					b = 0;
					plate[0] = 8'b11111111;
					plate[1] = 8'b11111111;
					plate[2] = 8'b11111111;
					plate[3] = 8'b11111111;
					plate[4] = 8'b11111111;
					plate[5] = 8'b11111111;
					plate[6] = 8'b11111111;
					plate[7] = 8'b11111111;
				end
			//fall obj02
			if(b == 0)
				begin
					random02 = (5*(random01+1) + 3)%16;
					r1 = random02 % 8;
					plate[r1][b] = 1'b0;
					b = b+1;
				end
			else if (b > 0 && b <= 7)
				begin
					plate[r1][b-1] = 1'b1;
					plate[r1][b] = 1'b0;
					b = b+1;
				end
			else if(b == 8) 
				begin
					plate[r1][b-1] = 1'b1;
					b = 0;
				end
		end*/
	always@(posedge CLK_move)
		begin
			RIGHT = right;
			LEFT = left;
			if(reset==1)
				begin
					pos=2;
					people[0] = 8'b11111111;
					people[1] = 8'b11111111;
					people[2] = 8'b01111111;
					people[3] = 8'b01111111;
					people[4] = 8'b01111111;
					people[5] = 8'b11111111;
					people[6] = 8'b11111111;
					people[7] = 8'b11111111;
				end
				//----------------------------------------------
				//move people
				if(LEFT==1 && pos!=0)
					begin
						pos=pos-1;
						people[pos][7]=1'b0;
						people[pos+1][7]=1'b0;
						people[pos+2][7]=1'b0;
						people[pos+3][7]=1'b1;
					end
				if(RIGHT==1 && pos!=5)
					begin
						pos=pos+1;				
						people[pos-1][7]=1'b1;
						people[pos][7]=1'b0;
						people[pos+1][7]=1'b0;
						people[pos+2][7]=1'b0;
					end
		end
	
	
	always @(posedge CLK_div)
		begin 
			if(cnt>=7)
				cnt=0;
			else
				cnt = cnt +1;
			COMM={1'b1,cnt};
			if(touch>0)
				if(bcd_m < 2)
					begin
						D_G<=plate[cnt];
						D_R<=people[cnt];
						D_B<=blueobj[cnt];
						if(touch==6)
							begin
								life=6'b111111;
							end
						else if(touch==5)
							begin
								life=6'b111110;
							end
						else if(touch==4)
							begin
								life=6'b111100;
							end
						else if(touch==3)
							begin
								life=6'b111000;
							end
						else if(touch==2)
							begin
								life=6'b110000;
							end
						else if(touch==1)
							begin
								life=6'b100000;
							end
					end
				else
						begin
							D_R<=win[cnt];
							D_B<=8'b11111111;
						end
			else if(touch==0)
				begin
					life=6'b000000;
					D_R<=over[cnt];
					D_B<=8'b11111111;
				end
		end
endmodule 


module divfreq(input CLK, output reg CLK_div); 
reg [24:0] Count; 
always @(posedge CLK) 
	begin 
		if(Count > 50000) 
		begin 
			Count <= 25'b0; 
			CLK_div <= ~CLK_div; 
		end 
		else 
			Count <= Count + 1'b1; 
	end 
endmodule

module divmove(input CLK, output reg CLK_div); 
reg [24:0] Count; 
always @(posedge CLK) 
	begin 
		if(Count > 3500000) 
		begin 
			Count <= 25'b0; 
			CLK_div <= ~CLK_div; 
		end 
		else 
			Count <= Count + 1'b1; 
	end 
endmodule

module divmove01(input CLK, output reg CLK_div); 
reg [24:0] Count; 
always @(posedge CLK) 
	begin 
		if(Count > 3500000) 
		begin 
			Count <= 25'b0; 
			CLK_div <= ~CLK_div; 
		end 
		else 
			Count <= Count + 1'b1; 
	end 
endmodule

module divmove02(input CLK, output reg CLK_div); 
reg [24:0] Count; 
always @(posedge CLK) 
	begin 
		if(Count > 3500000) 
		begin 
			Count <= 25'b0; 
			CLK_div <= ~CLK_div; 
		end 
		else 
			Count <= Count + 1'b1; 
	end 
endmodule

//計時除頻器
module divfreq1(input CLK, output reg CLK_time);
  reg [25:0] Count;
  initial
    begin
      CLK_time = 0;
	 end	
		
  always @(posedge CLK)
    begin
      if(Count > 25000000)
        begin
          Count <= 25'b0;
          CLK_time <= ~CLK_time;
        end
      else
        Count <= Count + 1'b1;
    end
endmodule

//秒數轉7段顯示器
module segment7(input [0:3] a, output A,B,C,D,E,F,G);
	assign A = ~(a[0]&~a[1]&~a[2] | ~a[0]&a[2] | ~a[1]&~a[2]&~a[3] | ~a[0]&a[1]&a[3]),
	       B = ~(~a[0]&~a[1] | ~a[1]&~a[2] | ~a[0]&~a[2]&~a[3] | ~a[0]&a[2]&a[3]),
			 C = ~(~a[0]&a[1] | ~a[1]&~a[2] | ~a[0]&a[3]),
			 D = ~(a[0]&~a[1]&~a[2] | ~a[0]&~a[1]&a[2] | ~a[0]&a[2]&~a[3] | ~a[0]&a[1]&~a[2]&a[3] | ~a[1]&~a[2]&~a[3]),
			 E = ~(~a[1]&~a[2]&~a[3] | ~a[0]&a[2]&~a[3]),
			 F = ~(~a[0]&a[1]&~a[2] | ~a[0]&a[1]&~a[3] | a[0]&~a[1]&~a[2] | ~a[1]&~a[2]&~a[3]),
			 G = ~(a[0]&~a[1]&~a[2] | ~a[0]&~a[1]&a[2] | ~a[0]&a[1]&~a[2] | ~a[0]&a[2]&~a[3]);
			 
endmodule
