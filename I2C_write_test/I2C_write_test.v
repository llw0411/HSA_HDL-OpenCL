`timescale 1ns/1ns

module I2C_write_test;
	reg CLK;
	reg GO;
	reg reset;
	reg [26:0] regdata;
	wire SCLK;
	wire SDIN;
	wire ACK, ACK1, ACK2, ACK3, ldnACK1, ldnACK2, ldnACK3;
	wire rstACK;

//I2C(主控端)寫入控制器
I2C_write i2c1(CLK,SCLK,SDIN,regdata,GO,ACK,reset,rstACK,ACK1,ACK2,ACK3,ldnACK1,ldnACK2,ldnACK3);

//設定I2C資料值
initial
begin
	regdata=27'b101010101101010101101010101;
end

//產生10 MHZ的輸入時脈
initial
begin
	CLK=0;
end
always #20 CLK=~CLK;

//設定非同步重置,過了100ns之後結束
initial
begin
	reset=1;
	while(1)
	#100 reset=0;
end

//開始模擬的100ns之後觸發的I2C動作
initial
begin
	GO=0;
	#100 GO=1;
	#100 GO=0;
end

endmodule