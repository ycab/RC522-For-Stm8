//指定PCD接收缓冲值
#define FSDI 5
#define FSD 64              //RC500 FIFO BUFFER SIZE
#define ZLG_522S 1

//////////////////////////////////
//端口定义
/////////////////////////////////////////////////////////////////////
//MFRC500
//sbit     MF522_RST  =    P1^7;                   //RC500片选
/*
#define  MF522_NSS  2//sbit     MF522_NSS  =    P1^3;
#define  MF522_SCK  5//sbit     MF522_SCK  =    P1^0;
#define  MF522_SI   4//sbit     MF522_SI   =    P1^2;
#define  MF522_SO   3//sbit     MF522_SO   =    P1^1;
*/
/////////////////////////////////////////////////////////////////////
//函数原型
/////////////////////////////////////////////////////////////////////
void RC522_Init(void);
unsigned char PcdReset(void);
void PcdAntennaOn(void);
void PcdAntennaOff(void);
unsigned char PcdRequest(unsigned char req_code,unsigned char *pTagType);  
unsigned char PcdAnticoll(unsigned char *pSnr);
unsigned char PcdSelect(unsigned char *pSnr); 
unsigned char PcdHalt(void);
#if 1//def ENABLE_M1_CARD
unsigned char PcdAuthState(unsigned char auth_mode,unsigned char addr,unsigned char *pKey,unsigned char *pSnr);     
unsigned char PcdRead(unsigned char addr,unsigned char *pData);     
unsigned char PcdWrite(unsigned char addr,unsigned char *pData);    
unsigned char PcdValue(unsigned char dd_mode,unsigned char addr,unsigned char *pValue);   
unsigned char PcdBakValue(unsigned char sourceaddr, unsigned char goaladdr);                                 
unsigned char Init_Parchase(unsigned char addr, unsigned char *pData);
unsigned char Opation_MF1Card(unsigned char Command, 
                 unsigned char *pInData, 
                 unsigned char InLenByte,
				 unsigned short TimeOut);
#endif
//                 unsigned int  *pOutLenBit);
//unsigned char PcdComMF522(unsigned char Command, 
  //               unsigned char *pInData, 
    //             unsigned char InLenByte/*,
                // unsigned char *pOutData, 
              //   unsigned int  *pOutLenBit*/);

unsigned char PcdComMF522_P(unsigned char Command, 
                 unsigned char *pInData, 
                 unsigned char InLenByte,
                 unsigned char *pOutData, 
                 unsigned int  *pOutLenBit,unsigned short TimeOut);

//void CalulateCRC(unsigned char *pIndata,unsigned char len,unsigned char *pOutData);
void WriteRawRC(unsigned char Address,unsigned char value);
unsigned char ReadRawRC(unsigned char Address); 
void SetBitMask(unsigned char reg,unsigned char mask); 
void ClearBitMask(unsigned char reg,unsigned char mask); 
//unsigned char M500PcdConfigISOType(unsigned char type);
void delay_10ms(unsigned int _10ms);
void Delay1us(unsigned char us);
//void iccardcode();
//unsigned char PcdBakValue(unsigned char sourceaddr, unsigned char goaladdr);
//unsigned char PcdValue(unsigned char dd_mode,unsigned char addr,unsigned char *pValue);
//#ifndef  ZLG_522S
//char MifareProRst(unsigned char parameter,unsigned char *pLen,unsigned char *pData);
//char MifareProCom(unsigned char CID_NAD,unsigned char timeout,unsigned char *pLen,unsigned char *pCommand);
//#endif


/////////////////////////////////////////////////////////////////////
//MF522命令字
/////////////////////////////////////////////////////////////////////
#define PCD_IDLE              0x00               //取消当前命令
#define PCD_AUTHENT           0x0E               //验证密钥
#define PCD_RECEIVE           0x08               //接收数据
#define PCD_TRANSMIT          0x04               //发送数据
#define PCD_TRANSCEIVE        0x0C               //发送并接收数据
#define PCD_RESETPHASE        0x0F               //复位
#define PCD_CALCCRC           0x03               //CRC计算

/////////////////////////////////////////////////////////////////////
//Mifare_One卡片命令字
/////////////////////////////////////////////////////////////////////
#define PICC_REQIDL           0x26               //寻天线区内未进入休眠状态
#define PICC_REQALL           0x52               //寻天线区内全部卡
#define PICC_ANTICOLL1        0x93               //防冲撞
#define PICC_ANTICOLL2        0x95               //防冲撞
#define PICC_AUTHENT1A        0x60               //验证A密钥
#define PICC_AUTHENT1B        0x61               //验证B密钥
#define PICC_READ             0x30               //读块
#define PICC_WRITE            0xA0               //写块
#define PICC_DECREMENT        0xC0               //扣款
#define PICC_INCREMENT        0xC1               //充值
#define PICC_RESTORE          0xC2               //调块数据到缓冲区
#define PICC_TRANSFER         0xB0               //保存缓冲区中数据
#define PICC_HALT             0x50               //休眠
#define PICC_RESET            0xE0               //复位
/////////////////////////////////////////////////////////////////////
//MF522 FIFO长度定义
/////////////////////////////////////////////////////////////////////
#define FIFO_LENGTH       64                 //FIFO size=64byte

/////////////////////////////////////////////////////////////////////
//MF522寄存器定义
/////////////////////////////////////////////////////////////////////
// PAGE 0
#define     RFU00                 0x00    
#define     CommandReg            0x01    
#define     ComIEnReg             0x02    
#define     DivlEnReg             0x03    
#define     ComIrqReg             0x04    
#define     DivIrqReg             0x05
#define     ErrorReg              0x06    
#define     Status1Reg            0x07    
#define     Status2Reg            0x08    
#define     FIFODataReg           0x09
#define     FIFOLevelReg          0x0A
#define     WaterLevelReg         0x0B
#define     ControlReg            0x0C
#define     BitFramingReg         0x0D
#define     CollReg               0x0E
#define     RFU0F                 0x0F
// PAGE 1     
#define     RFU10                 0x10
#define     ModeReg               0x11
#define     TxModeReg             0x12
#define     RxModeReg             0x13
#define     TxControlReg          0x14
#define     TxAutoReg             0x15
#define     TxSelReg              0x16
#define     RxSelReg              0x17
#define     RxThresholdReg        0x18
#define     DemodReg              0x19
#define     RFU1A                 0x1A
#define     RFU1B                 0x1B
#define     MifareReg             0x1C
#define     RFU1D                 0x1D
#define     RFU1E                 0x1E
#define     SerialSpeedReg        0x1F
// PAGE 2    
#define     RFU20                 0x20  
#define     CRCResultRegM         0x21
#define     CRCResultRegL         0x22
#define     RFU23                 0x23
#define     ModWidthReg           0x24
#define     RFU25                 0x25
#define     RFCfgReg              0x26
#define     GsNReg                0x27
#define     CWGsCfgReg            0x28
#define     ModGsCfgReg           0x29
#define     TModeReg              0x2A
#define     TPrescalerReg         0x2B
#define     TReloadRegH           0x2C
#define     TReloadRegL           0x2D
#define     TCounterValueRegH     0x2E
#define     TCounterValueRegL     0x2F
// PAGE 3      
#define     RFU30                 0x30
#define     TestSel1Reg           0x31
#define     TestSel2Reg           0x32
#define     TestPinEnReg          0x33
#define     TestPinValueReg       0x34
#define     TestBusReg            0x35
#define     AutoTestReg           0x36
#define     VersionReg            0x37
#define     AnalogTestReg         0x38
#define     TestDAC1Reg           0x39  
#define     TestDAC2Reg           0x3A   
#define     TestADCReg            0x3B   
#define     RFU3C                 0x3C   
#define     RFU3D                 0x3D   
#define     RFU3E                 0x3E   
#define     RFU3F		  0x3F

/////////////////////////////////////////////////////////////////////
//和MF522通讯时返回的错误代码
/////////////////////////////////////////////////////////////////////
#define MI_OK                          0
#define MI_NOTAGERR                    1//(-1)
#define MI_ERR                         2//(-2)
#define MI_COM_ERR                     3
#define MI_TIMEOUT		       4








#define     SPI_flag    (SPI_SR&0x80)   //SPI判忙标志位
