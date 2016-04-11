#ifndef __UART_H
#define __UART_H

#include  "stm8s103k.h"
#include "delay.h"

#define HSIClockFreq 16000000
#define BaudRate  115200
#define UART1_FLAG_TXE  (u8)0x80  /*!< Transmit Data Register Empty flag */
#define UART1_FLAG_RXNE (u8)0x20 /*!< Read Data Register Not Empty flag */
#define RxBufferSize 64
extern void uart_conf(void);
extern void UART1_SendByte(u8 data);
extern void UART1_SendString(u8* Data,u16 len);
extern u8 UART1_ReceiveByte(void);

#endif