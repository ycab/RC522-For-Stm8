/******************** (C) COPYRIGHT  风驰iCreate嵌入式开发工作室 ********************
 * 文件名  ：spi.c
 * 描述    ：SPI总线配置读写函数库  
 * 实验平台：iCreate STM8开发板
 * 寄存器版本  ：V1.0.0
 * 作者    ：ling_guansheng  QQ：779814207
 * 修改时间 ：2012-4-10
***********************************************************************************/

#include "spi.h"

/**************************************************************************
 * 函数名：SPI_conf
 * 描述  ：SPI模块配置函数
 * 输入  ：无
 *
 * 输出  ：无
 * 返回  ：无 
 * 调用  ：外部调用 
 *************************************************************************/
void  SPI_conf(void)
{
  SPI_CR1 = (0<<7)|(0<<6)|(0<<3)|(1<<2)|(1<<1)|(1<<0);  /* 先发送MSB 先禁止SPI 波特率设为 fbus/2 设置为主模式 空闲状态时SCK为高电平 数据从第二个时钟边沿开始采样 */
  SPI_CR2 = (0<<7)|(0<<5)|(0<<4)|(0<<2)|(1<<1)|(1<<0);  /* 设为全双工模式 使能软件从设备管理 内部从设备选择为主模式 */
  SPI_ICR = (0<<7)|(0<<6)|(0<<5)|(0<<4);                /* 禁止所有中断 */
  SPI_CR1 |= (1<<6);                                    /* 开启SPI模块 */
}

/**************************************************************************
 * 函数名：SPI_SendByte
 * 描述  ：SPI模块发送函数
 * 输入  ：无
 *
 * 输出  ：无
 * 返回  ：无 
 * 调用  ：外部调用 
 *************************************************************************/
unsigned char SPI_SendByte(unsigned char byte)
{
  while(!(SPI_SR & 0x02));              /* 等待发送寄存器为空 */
  SPI_DR = byte;                        /* 将发送的数据写到数据寄存器 */
 
  while(!(SPI_SR & 0x02));
  while(!(SPI_SR & 0x01));              /* 等待接受寄存器满 */
  return SPI_DR;                        /* 读数据寄存器 */
}



/******************* (C) COPYRIGHT 风驰iCreate嵌入式开发工作室 *****END OF FILE****/