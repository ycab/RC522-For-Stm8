/******************** (C) COPYRIGHT  ���iCreateǶ��ʽ���������� ********************/
#ifndef __SPI_H
#define __SPI_H

#include  "stm8s103k.h"
#include "delay.h"

        
extern void SPI_conf(void);
unsigned char SPI_SendByte(unsigned char byte);




#define PKGDATA_SIZE	60			// Size of package data



#endif

/******************* (C) COPYRIGHT ���iCreateǶ��ʽ���������� *****END OF FILE****/