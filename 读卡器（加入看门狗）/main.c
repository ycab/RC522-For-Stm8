/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "stm8s103k.h"
#include "delay.h"
#include "uart.h"
#include "spi.h"
#include "mfrc522.h"
/*下载程序加入看门狗已经稳定*/
/*2015年12月3日*/

/*加入Beep和KM1的控制
/**2016年3月28日***/


/******************************CRC_CCITT余式表*********************************/
unsigned int crc_tab[16]={
    0x0000,0x1021,0x2042,0x3063,0x4084,0x50a5,0x60c6,0x70e7,
    0x8108,0x9129,0xa14a,0xb16b,0xc18c,0xd1ad,0xe1ce,0xf1ef,
    };

unsigned char card_id[4];
unsigned int crc_get;
u8 state;
unsigned char SBuf[PKGDATA_SIZE];
typedef union tagUULONG
{
	unsigned long lValue;
	unsigned char cBuf[4];
}UULONG;



unsigned int cal_CRC(unsigned char *ptr,unsigned char len);
void IWDG_init(void);
void Beep_init(void);//PC3管脚
void KM1_init(void);
#define Find_0x55_1 0x01
#define Find_0xAA_1 0x02
#define Find_KM1 0x03
#define Find_Beep 0x04
#define Find_0xAA_2 0x05
#define Find_0x55_2 0x06
u8 Find_State;
u8 KM1_State;
u8 Beep_State;
main()
{
	int i;
	UULONG Temp,Temp2;
	//PD_DDR|=(1<<2);//PA3-NSS,推挽输出
 // PD_CR1|=(1<<2);
  //PD_CR2|=(1<<2);
	//PD_ODR&=0xFB;
	
	//for(i=0;i<=30;i++)
	//{
		delayms(1000);
//	}
  PD_ODR|=0x04;//RC522的复位脚
	CLK_CKDIVR&= (u8)(~0x18);/*时钟复位*/
  CLK_CKDIVR|= (u8)0x00;/*设置时钟为内部16M高速时钟*/
	uart_conf();
	UART1_SendByte(0x44);

	PC_DDR|=(1<<4);//配置PC4，SPI_NSS,10M输出
  PC_CR1|=(1<<4);
  PC_CR2|=(1<<4);
	
  SPI_conf();
  RC522_Init();
	Beep_init();
	KM1_init();
	PC_ODR&=0xEF;//将PC置为11101111，即拉下片选SPI_NSS
	_asm("rim");
	 IWDG_init();
	 Find_State=Find_0x55_1 ;
 	while (1)
	{
     // UART1_SendByte(0x55);
		  IWDG_KR = 0xAA; //刷新IDDG，避免产生看门狗复位，同时恢复 PR 及 RLR 的写保护状态 
		  PcdRequest(PICC_REQALL,SBuf);
      state=PcdAnticoll(Temp.cBuf);
			//UART1_SendByte(state);
			if(state==MI_OK)
			{
				
				//UART1_SendString("com@Y",(sizeof("com@Y")-1));
				UART1_SendByte(0x55);
				UART1_SendByte(0xAA);
				for(i=0;i<=3;i++)
				{
					card_id[i]=Temp.cBuf[i];
				}
				for(i=0;i<=3;i++)
				{
					UART1_SendByte(card_id[i]);
				}
				//UART1_SendString("@info@",sizeof("@info@"));
			   	crc_get=cal_CRC(card_id,4);
			  	UART1_SendByte((u8)(crc_get>>8));//高位
					UART1_SendByte((u8)crc_get);     //低位
			  	UART1_SendByte(0xAA);
			  	UART1_SendByte(0x55);
					for(i=1;i<=3;i++)
					{
						delayms(1000);
					}
			}
			else
			{
				UART1_SendByte(0x55);
				UART1_SendByte(0xAA);
				
				UART1_SendByte(0x00);
				UART1_SendByte(0x00);
				UART1_SendByte(0x00);
				UART1_SendByte(0x00);
				UART1_SendByte(0x00);
				UART1_SendByte(0x00);
				
				UART1_SendByte(0xAA);
				UART1_SendByte(0x55);
				for(i=1;i<=3;i++)
				{
						delayms(1000);
				}
			}
  }
}
/**********************************************************
函数：uint16_t cal_CRC(uint8_t *ptr,uint8_t len)
形参：ptr:形参类型:unsigned char*；形参功能：待校验数据的首地址
      len:形参类型:unsigned char;  形参功能：待校验数据的长度
返回：返回类型：unsigned int;
功能：CRC_CCITT数据校验函数
***********************************************************/
unsigned int cal_CRC(unsigned char *ptr,unsigned char len)
{
    unsigned int crc;
    unsigned char  dat;   
    crc = 0x00;
    while(len--!=0)
    {
        dat   = ((unsigned char)((crc/256))/16 & 0x000f);  
        crc   = (unsigned int)((crc<<4)&0xfff0);         
        crc  ^= crc_tab[dat^(*ptr/16)];             
        dat   = ((unsigned char)((crc/256))/16 & 0x000f);  
        crc   = (unsigned int)((crc<<4)&0xfff0);         
        crc  ^= crc_tab[dat^(*ptr&0x0f)];            
        ptr++;
    }
    return(crc);
}
void IWDG_init(void)
{
				IWDG_KR = 0xCC; //启动IWDG
        IWDG_KR = 0x55;        //解除 PR 及 RLR 的写保护
        IWDG_RLR = 0xFF; //看门狗计数器重装载数值        
        IWDG_PR = 0x06; //分频系数为256，最长超时时间为：1.02S
        IWDG_KR = 0xAA; //刷新IDDG，避免产生看门狗复位，同时恢复 PR 及 RLR 的写保护状态 
}
void Beep_init(void)//PC3管脚
{
	PC_DDR|=(1<<3);//配置PC3，输出10MHz
  PC_CR1|=(1<<3);
  PC_CR2|=(1<<3);
}
void KM1_init(void)
{
	PA_DDR|=(1<<3);//配置PA3，输出10MHz
  PA_CR1|=(1<<3);
  PA_CR2|=(1<<3);
}
@far @interrupt void UART1_RX_IRQHandler(void)
{ 
   u8 Res;
    if(UART1_SR & UART1_FLAG_RXNE)  
    {/*接收中断(接收到的数据必须是0x0d 0x0a结尾)*/
				Res =(u8)UART1_DR;
        /*(USART1->DR);读取接收到的数据,当读完数据后自动取消RXNE的中断标志位*/
  		// UART1_SendByte(Res);
			 if(Find_State==Find_0x55_1)
			 {
				 if(Res==0x55)
				 {
					 Find_State=Find_0xAA_1;
				 }
			 }
			 else if(Find_State==Find_0xAA_1)
			 {
				 if(Res==0xAA)
				 {
					 Find_State=Find_KM1;
				 }
				 else
				 {
					 Find_State=Find_0x55_1;
				 }
			 }
			 else if(Find_State==Find_KM1)
			 {
				 KM1_State=Res;
				 Find_State=Find_Beep;
			 }
				else if(Find_State==Find_Beep)
			 {
				 Beep_State=Res;
				 Find_State=Find_0xAA_2;
			 }
				else if(Find_State==Find_0xAA_2)
			 {
					if(Res==0xAA)
				 {
					 Find_State=Find_0x55_2;
				 }
				 else
				 {
					 Find_State=Find_0x55_1;
				 }
			 }
			 else if(Find_State==Find_0x55_2)
			 {
				 if(Res==0x55)
				 {
					 Find_State=Find_0x55_1;
					 if(Beep_State==0x01)
					 {
						 PC_ODR|=(1<<3);
					 }
					 else if(Beep_State==0x00)
					 {
						 PC_ODR&=0xF7;
					 }
					 
						if(KM1_State==0x01)
					 {
						 PA_ODR|=(1<<3);
					 }
					 else if(KM1_State==0x00)
					 {
						 PA_ODR&=0xF7;
					 }
				 }
				 else
				 {
					 Find_State=Find_0x55_1;
				 }
			 }
			 
			 
		}
		return ;
}
#define Find_0x55_1 0x01
#define Find_0xAA_1 0x02
#define Find_KM1 0x03
#define Find_Beep 0x04
#define Find_0xAA_2 0x05
#define Find_0x55_2 0x06
