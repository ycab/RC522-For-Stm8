/******************** (C) COPYRIGHT  风驰iCreate嵌入式开发工作室 ********************/
#ifndef __SPI_H
#define __SPI_H

#include  "stm8s103k.h"
#include "delay.h"

        
extern void SPI_conf(void);
unsigned char SPI_SendByte(unsigned char byte);




#define PKGDATA_SIZE	60			// Size of package data



#endif

/******************* (C) COPYRIGHT 风驰iCreate嵌入式开发工作室 *****END OF FILE****/