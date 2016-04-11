//#include <intrins.h>


#include "mfrc522.h"
#include  "stm8s103k.h"
#include "delay.h"
#define MAXRLEN 64 



//void WR_FIFO(unsigned char Address,unsigned char *Buf,unsigned char nlen);
//void RD_FIFO(unsigned char *Buf,unsigned char Len);
//指示灯
//#define  LED        6//sbit LED = P1^6;  
/////////////////////////////////////////////////////////////////////
//函数原型
/////////////////////////////////////////////////////////////////////

unsigned char    SPI_RW(unsigned char value)
{
   while(!(SPI_SR & 0X02));//判断发射为不为空
   SPI_DR = value;        //写值
   while(!(SPI_SR & 0X02));//判断发射为不为空
   while(!(SPI_SR & 0x01));//判断是否收到数据
   return SPI_DR;         
}
                                  
//#define  ucComMF522Buf	SerBfr
unsigned char fHasRATS = 0;

void RC522_Init(void)
{
	unsigned char Temp;
	delayms(1);
	WriteRawRC(ControlReg,0x10);//18 10
	WriteRawRC(ModeReg,0x3F);//22 3f
	WriteRawRC(RFU23,0x00);//46 00
	WriteRawRC(RFU25,0x80);//4a 80
	WriteRawRC(AutoTestReg,0x40);//6c 40 
	WriteRawRC(TxAutoReg,0x40);//2a 40
	ReadRawRC(TxAutoReg);//aa 40
	SetBitMask(TxControlReg,0x03);//a8 80 28 83
	WriteRawRC(TPrescalerReg,0x3D);//56 3d
	WriteRawRC(TModeReg,0x0D);//54 0d
	WriteRawRC(TReloadRegL,0x0A);//5a 0a
	WriteRawRC(TReloadRegH,0x00);//58 00
	WriteRawRC(ComIrqReg,0x01);//08 01
	SetBitMask(ControlReg,0x40);//98 10 18 50
	do
	{
		Temp = ReadRawRC(ComIrqReg);//88	15
	}while(!(Temp&0x01));
	WriteRawRC(ComIrqReg,0x01);//08 01
	WriteRawRC(CommandReg,0x00);//02 00
}
                       
/////////////////////////////////////////////////////////////////////
//功    能：寻卡
//参数说明: req_code[IN]:寻卡方式
//                0x52 = 寻感应区内所有符合14443A标准的卡
//                0x26 = 寻未进入休眠状态的卡
//          pTagType[OUT]：卡片类型代码
//                0x4400 = Mifare_UltraLight
//                0x0400 = Mifare_One(S50)
//                0x0200 = Mifare_One(S70)
//                0x0800 = Mifare_Pro(X)
//                0x4403 = Mifare_DESFire
//返    回: 成功返回MI_OK
/////////////////////////////////////////////////////////////////////
unsigned char PcdRequest(unsigned char req_code,unsigned char *pTagType)
{
	/*当选卡时，并未进入寻卡和锁卡，因此要更改
	*/
  	char status;
	unsigned int  unLen;
	unsigned char ucComMF522Buf[MAXRLEN];
	char i=0;
	if(fHasRATS != 1)
	{
		do
		{
			status = ReadRawRC(Status2Reg);	//90 00(01,05)
			WriteRawRC(Status2Reg,status&0xf7);	//10 00
			WriteRawRC(CollReg,0x80);		//1c 80
			ClearBitMask(TxModeReg,0x80);	//a4 00 24 00
			ClearBitMask(RxModeReg,0x80);	//a6 00 26 00
			WriteRawRC(BitFramingReg,0x07); //1a 07
			SetBitMask(TxControlReg,0x03);  //a8 83 28 83
			ucComMF522Buf[0] = req_code;
			i++;
			status = PcdComMF522_P(PCD_TRANSCEIVE,ucComMF522Buf,1,ucComMF522Buf,&unLen,0x0002);
			if(i>=2)
				break;
			delayms(1);
		}while(status ==MI_TIMEOUT );
			
		
	}
	else
	{
	 	SetBitMask(TxModeReg,0x80);//a4 80 24 80
		SetBitMask(RxModeReg,0x80);//a6 80 26 80
		ucComMF522Buf[0] = 0xCA;
		ucComMF522Buf[1] = 0x00;
		status = PcdComMF522_P(PCD_TRANSCEIVE,ucComMF522Buf,2,ucComMF522Buf,&unLen,0x00F0);
		//add below 3lines
		status = ReadRawRC(Status2Reg);	//90 00(01,05)
		WriteRawRC(Status2Reg,status&0xf7);	//10 00
		WriteRawRC(CollReg,0x80);		//1c 80

		ClearBitMask(TxModeReg,0x80);	//a4 80 24 00
		ClearBitMask(RxModeReg,0x80);	//a6 00 26 00
		WriteRawRC(BitFramingReg,0x07);	//1a 07
		//add 1 line
		SetBitMask(TxControlReg,0x03);//a8 83 28 83
		          
		ucComMF522Buf[0] = req_code;
		status = PcdComMF522_P(PCD_TRANSCEIVE,ucComMF522Buf,1,ucComMF522Buf,&unLen,0x0002);
		if(status == 0)
			fHasRATS = 0;
	}
	if ((status == MI_OK) && (unLen == 0x10))
   {    
       *pTagType     = ucComMF522Buf[0];
       *(pTagType+1) = ucComMF522Buf[1];
   }
   else
   {   
     status = MI_ERR;  
   }
	return status;
}

/////////////////////////////////////////////////////////////////////
//功    能：防冲撞
//参数说明: pSnr[OUT]:卡片序列号，4字节
//返    回: 成功返回MI_OK
/////////////////////////////////////////////////////////////////////  
unsigned char PcdAnticoll(unsigned char *pSnr)
{

    unsigned char status;
     unsigned int   unLen;
    unsigned char  ucComMF522Buf[MAXRLEN];
	unsigned char  i;
	unsigned char  snr_check=0;    
   
     
        ClearBitMask(TxModeReg,0x80);//a4 00 24 00
	ClearBitMask(RxModeReg,0x80);//a6 00 26 00
	WriteRawRC(CollReg,0x00);	//1c 00
	delayms(1);
	WriteRawRC(BitFramingReg,0x00);//1a 00
	ucComMF522Buf[0] = PICC_ANTICOLL1;
        ucComMF522Buf[1] = 0x20;
	status = PcdComMF522_P(PCD_TRANSCEIVE,ucComMF522Buf,2,ucComMF522Buf,&unLen,0x0020);
	delayms(1);
	WriteRawRC(BitFramingReg,0x00);//1a 00
	WriteRawRC(CollReg,0x80);//1c 80 
	
	if (status == MI_OK)
    {
		
    	 for (i=0; i<4; i++)
         {   
             *(pSnr+i)  = ucComMF522Buf[i];
             snr_check ^= ucComMF522Buf[i];
         }
         if (snr_check != ucComMF522Buf[i])
         {  
           status = MI_ERR;   
         }
    }
        
	return status;

}

/////////////////////////////////////////////////////////////////////
//功    能：选定卡片
//参数说明: pSnr[IN]:卡片序列号，4字节
//返    回: 成功返回MI_OK
/////////////////////////////////////////////////////////////////////
unsigned char PcdSelect(unsigned char *pSnr)
{
    char status;
    unsigned char ucComMF522Buf[MAXRLEN];
	unsigned char i;
	unsigned int  unLen;
	
	/*
	status= PcdRequest(PICC_REQALL,ucComMF522Buf);
	if(status!=0)
	{
		status= PcdRequest(PICC_REQALL,ucComMF522Buf);
		if(status!=0)				
		{
			status = MI_ERR;
		}
	 }
	status = PcdAnticoll(pSnr);

	if(status!=0)				
	{
		return MI_ERR;
	}	
	 */	
	SetBitMask(TxModeReg,0x80);//a4 80 24 80
	SetBitMask(RxModeReg,0x80);//a6 00 26 80
	ucComMF522Buf[0] = PICC_ANTICOLL1;
    ucComMF522Buf[1] = 0x70;
	ucComMF522Buf[6] = 0;
	for (i=0; i<4; i++)
    {
    	ucComMF522Buf[i+2] = *(pSnr+i);
		ucComMF522Buf[6]  ^= *(pSnr+i);
    }
	status = PcdComMF522_P(PCD_TRANSCEIVE,ucComMF522Buf,7,ucComMF522Buf,&unLen,0x0010);
	if ((status == MI_OK))//&& (unLen == 0x18))
    {  
      pSnr[0] = ucComMF522Buf[0];
    }
    else
    {   
      status = MI_ERR;    
    }  
	return status; 
}


/////////////////////////////////////////////////////////////////////
//功    能：读RC632寄存器
//参数说明：Address[IN]:寄存器地址
//返    回：读出的值
/////////////////////////////////////////////////////////////////////
unsigned char ReadRawRC(unsigned char Address)//Kevin modify
{

	unsigned char ucResult;
   unsigned char  ucAddr;
   ucAddr = ((Address<<1)&0x7E)|0x80;
  PC_ODR&=0xEF;
 delayms(1);  
  
  while(SPI_flag);         //wait send complete
  SPI_RW(ucAddr);             //write reg
  ucResult = SPI_RW(0);       //read  reg
  
  PC_ODR|=(1<<4);
 
  return ucResult;

}

/////////////////////////////////////////////////////////////////////
//功    能：写RC632寄存器
//参数说明：Address[IN]:寄存器地址
//          value[IN]:写入的值
/////////////////////////////////////////////////////////////////////
void WriteRawRC(unsigned char Address, unsigned char value)//Kevin modify
{

    unsigned char ucAddr;
   ucAddr = ((Address<<1)&0x7E);
   PC_ODR&=0xEF;                          // drive NSS low 
   delayms(1);
   while (SPI_flag );   //wait send complete 
   SPI_RW(ucAddr);             // write reg address
     
   SPI_RW(value);                    // write value     
    PC_ODR|=(1<<4);                          // drive NSS high
}



//功    能：置RC522寄存器位
//参数说明：reg[IN]:寄存器地址
//          mask[IN]:置位值
/////////////////////////////////////////////////////////////////////
void SetBitMask(unsigned char reg,unsigned char mask)  
{
    unsigned char  tmp = 0x0;
    tmp = ReadRawRC(reg);
    WriteRawRC(reg,tmp | mask);  // set bit mask
}

/////////////////////////////////////////////////////////////////////
//功    能：清RC522寄存器位
//参数说明：reg[IN]:寄存器地址
//          mask[IN]:清位值
/////////////////////////////////////////////////////////////////////
void ClearBitMask(unsigned char reg,unsigned char mask)  
{
    unsigned char  tmp = 0x0;
    tmp = ReadRawRC(reg);
    WriteRawRC(reg, tmp & ~mask);  // clear bit mask
} 


unsigned char PcdComMF522_P(unsigned char Command, 
                 unsigned char *pInData, 
                 unsigned char InLenByte,
                 unsigned char *pOutData, 
                 unsigned int  *pOutLenBit,unsigned short TimeOut)
{
#if 1//test
	unsigned char n,status;
	unsigned char lastBits;
        unsigned int i;
	delayms(1);
	WriteRawRC(TPrescalerReg,0xFF);//56 ff
	WriteRawRC(TModeReg,0x87);		//54 87
	WriteRawRC(TReloadRegL,(unsigned char)TimeOut); //5a 02
	WriteRawRC(TReloadRegH,(unsigned char)(TimeOut>>8));//58 00

	delayms(1);

	WriteRawRC(ComIrqReg,0x7F);//08 7f
	WriteRawRC(DivIrqReg,0x7F);//0a 7f
	WriteRawRC(FIFOLevelReg,0x80);//14 80

	SetBitMask(CommandReg,Command);//82 0c 02 0c
	delayms(1);
	SetBitMask(ComIEnReg,0xA1);		//84 80 04 a1
	SetBitMask(DivlEnReg,0x00);		//86 00 06 00
	//-------------------------------
	for(n=0;n<InLenByte;n++)		//12 52
		WriteRawRC(FIFODataReg,pInData[n]);
	//-------------------------------
//	WR_FIFO(FIFODataReg,&pInData[0],InLenByte);//(12 52)(12 93 20)
	//[BitFramingReg]bit 7.the transmisson of daata starts,this bit is only valid of
	//the combination of tranceive command
	SetBitMask(BitFramingReg,0x80);//9a 07 1a 87
//when the mfauthent command is active ,any fifo access is blocked.
/*
    do 
    {
         n = ReadRawRC(ComIrqReg);//88 04(44,45(超时),64(正常))
		 status = ReadRawRC(DivIrqReg);//8a 00
    }
    while (!(n&0x20) && !(n&0x01));
*/
	while(1)
	{
		
		n = ReadRawRC(ComIrqReg);//88 04(44,45(超时),64(正常))
		status = ReadRawRC(DivIrqReg);//8a 00
		if(n & 0x20)
			break;
		if(n & 0x01)
			break;
	}
	if(!(n&0x01))
	{
		SetBitMask(ControlReg,0x90);//98 10 18 90
		ClearBitMask(ComIEnReg,0x7F);//84 a1 04 80
		ClearBitMask(DivlEnReg,0xFF);//86 00 06 00
		n = ReadRawRC(FIFOLevelReg);//94 02 
		lastBits = ReadRawRC(ControlReg) ;//98 10
	    /*if (lastBits)
	    {   *pOutLenBit = (n-1)*8 + lastBits;}
	    else
	    {   *pOutLenBit = n*8;   }*/
		status = ReadRawRC(ErrorReg);//8c 00
//		RD_FIFO(pOutData,n);//92 04 92 00
                for (i=0; i<n; i++)
                {   pOutData[i] = ReadRawRC(FIFODataReg);    }
		*pOutLenBit = n*8;

		WriteRawRC(ComIrqReg,0x20);//08 20
	}
	else
	{
		ClearBitMask(ComIEnReg,0x7F);//84 a1 04 80
		ClearBitMask(DivlEnReg,0xFF);//86 00 06 00
		if(pInData[0] == PICC_HALT)
		{
			ClearBitMask(ComIrqReg,0xFF);//86 00 06 00
			return 0;	
		}
		WriteRawRC(ComIrqReg,0x01);//08 01
		status = MI_TIMEOUT;
			
	}
	WriteRawRC(DivIrqReg,0x00);//0a 00
	WriteRawRC(FIFOLevelReg,0x80);//14 80
	WriteRawRC(ComIrqReg,0x01);//08 01
	WriteRawRC(BitFramingReg,0x00);//1a 00
	return status;
#endif
}

/////////////////////////////////////////////////////////////////////
//开启天线  
//每次启动或关闭天险发射之间应至少有1ms的间隔
/////////////////////////////////////////////////////////////////////
void PcdAntennaOn()
{

//    unsigned char xdata i;
    //i = ReadRawRC(TxControlReg);
    //if (!(i & 0x03))
    {
        SetBitMask(TxControlReg, 0x03);
        delayms(1);
    }

}


/////////////////////////////////////////////////////////////////////
//关闭天线
/////////////////////////////////////////////////////////////////////
void PcdAntennaOff()
{
    ClearBitMask(TxControlReg, 0x03);
    delayms(1);
}



///////////////////////////////////////////////////////////////////////
// Delay 10ms
///////////////////////////////////////////////////////////////////////









