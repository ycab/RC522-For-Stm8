/******************** (C) COPYRIGHT  ���iCreateǶ��ʽ���������� ********************
 * �ļ���  ��type_def.h
 * ����    �����iCreate STM8������ר��ͷ�ļ� 
 * ʵ��ƽ̨��iCreate STM8������
 * �Ĵ����汾  ��V1.0.0
 * ����    ��ling_guansheng  QQ��779814207
 * ����    ��
 *�޸�ʱ�� ��2011-12-20
**********************************************************************************/
#ifndef __type_def_h
#define __type_def_h
/*����оƬ��ͷ�ļ�*/
#include "iostm8s207rb.h"
/*bool ����ͷ�ļ�*/
#include "stdbool.h"
/*���ж�ͷ�ļ�*/
#include "intrinsics.h"
/*�����������Ͷ���*/
typedef unsigned char     uint8_t;
typedef unsigned short    uint16_t;
typedef unsigned long     uint32_t;
#define FlagStatus     bool
#define u8  uint8_t
#define u16 uint16_t
#define u32 uint32_t
#define EnableInterrupt  __enable_interrupt() 
#endif


/******************* (C) COPYRIGHT ���iCreateǶ��ʽ���������� *****END OF FILE****/