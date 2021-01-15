# FPGA-game
FPGA final

## Authors: 107101060  李冠賢  106213048  李政峯

## Input / Output unit:
### 左 右 reset

![rj](https://github.com/stefantionieren/FPGA-game/blob/main/Screenshot_20210115_150157.jpg)

### 分數

![s](https://github.com/stefantionieren/FPGA-game/blob/main/IMG_20210115_140514.jpg)

### 生命

![life](https://github.com/stefantionieren/FPGA-game/blob/main/IMG_20210115_140519.jpg)

### 8*8 遊戲中

![ing](https://github.com/stefantionieren/FPGA-game/blob/main/IMG_20210115_140509.jpg)

### 通關

![0](https://github.com/stefantionieren/FPGA-game/blob/main/IMG_20210115_141026.jpg)

### 失敗

![x](https://github.com/stefantionieren/FPGA-game/blob/main/IMG_20210115_140936.jpg)

## FPGA 模組說明
```
module test(
  output reg [7:0] D_R, D_G, D_B, //控制顏色
  output reg [3:0] COMM, //控制8*8位置
  output reg [1:0] COMM_CLK, //控制7段位置
  output reg [5:0] life, //生命
  output reg [6:0] d7_1, //7段顯示器
  input CLK, left, right,reset);
  
  segment7 S0(bcd_s, A0,B0,C0,D0,E0,F0,G0); //後2 7段顯示器
  segment7 S1(bcd_m, A1,B1,C1,D1,E1,F1,G1); //前2 7段顯示器
  divfreq F4(CLK,CLK_div); //畫面顯示除頻器
  divmove01 F2(CLK,CLK_move01); //畫面除頻器
  
  reg [3:0] bcd_s,bcd_m; //7段顯示器
  reg [6:0] seg1, seg2;  //7段顯示器
  reg LEFT,RIGHT; //左右控制
  byte pos,count1; //POS:移動物位置 count: count1:進位
  bit[2:0] cnt; //8*8直列
  integer a,touch; //a:掉落物位置 touch:生命
  reg [7:0] plate[7:0]; //盤面
  reg [7:0] people[7:0]; //移動物
  reg [7:0] blueobj[7:0]; //掉落物
  reg [2:0] random01, random02, r, r1;
  
  reg [7:0] win [7:0]; //plate of win
  reg [7:0] over [7:0]; //plate of lose
```

##vedio

[vedio](https://youtu.be/DjpsnfYuguo)
