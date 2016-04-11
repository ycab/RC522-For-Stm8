/**
  ******************************************************************************
  * @file project\stm8s_conf.h
  * @brief This file is used to configure the Library.
  * @author STMicroelectronics - MCD Application Team
  * @version V1.1.0
  * @date 02/27/2009
  ******************************************************************************
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2009 STMicroelectronics</center></h2>
  * @image html logo.bmp
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM8S_CONF_H
#define __STM8S_CONF_H

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/


/* Uncomment the line below will expanse the "assert_param" macro in the 
   firmware library code (see "Exported macro" section below) */
/* #define FULL_ASSERT (1) */ 

/* In the following line adjust the value of External High Speed oscillator (HSE)
   used in your application */
#if defined (STM8S208) || defined (STM8S207)
 #define HSE_VALUE ((u32)24000000) /* Value of the External oscillator in Hz*/
#else
 #define HSE_VALUE ((u32)16000000) /* Value of the External oscillator in Hz*/
#endif

/* Uncomment the line below to enable peripheral header file inclusion */

/************************************* ADC ************************************/
#if defined(STM8S105) || defined(STM8S103) || defined(STM8S903)
/* #define _ADC1 (1) */  
#endif /* (STM8S105) ||(STM8S103) || (STM8S903) */

#if defined(STM8S208) || defined(STM8S207)
/* #define _ADC2 (1) */ 
#endif /* (STM8S208) ||(STM8S207)  */

/************************************* AWU ************************************/
/* #define _AWU (1) */

/************************************* BEEP ***********************************/
/* #define _BEEP (1) */ 

/************************************* CLK ************************************/
#ifdef STM8S208
 /* #define _CAN (1) */ 
#endif /* (STM8S208) */

/************************************* CLK ************************************/
/* #define _CLK (1) */ 

/************************************* EXTI ***********************************/
/* #define _EXTI (1) */

/******************************* FLASH/DATA EEPROM ****************************/
/* #define _FLASH (1) */

/********************************* OPTION BYTES *******************************/
/* #define _OPT (1) */

/************************************* GPIO ***********************************/
/* #define _GPIO (1) */

/************************************* I2C ************************************/
/* #define _I2C  (1) */

/************************************* ITC ************************************/
/* #define _ITC (1) */

/************************************* IWDG ***********************************/
/* #define _IWDG (1) */

/************************************* RST ************************************/
/* #define _RST (1) */

/************************************* SPI ************************************/
/* #define _SPI (1) */

/************************************* TIM1 ***********************************/
/* #define _TIM1 (1) */

/************************************* TIM2 ***********************************/
#if defined(STM8S208) ||defined(STM8S207) ||defined(STM8S103) ||defined(STM8S105)
/* #define _TIM2 (1) */
#endif /* (STM8S208) ||(STM8S207)  || (STM8S103) || (STM8S105)  */

/************************************* TIM3 ***********************************/
#if defined(STM8S208) ||defined(STM8S207) ||defined(STM8S105)
/* #define _TIM3 (1) */
#endif /* (STM8S208) ||(STM8S207)  || (STM8S105) */

/************************************* TIM4 ***********************************/
#if defined(STM8S208) ||defined(STM8S207) ||defined(STM8S103) ||defined(STM8S105)
/* #define _TIM4 (1) */
#endif /* (STM8S208) ||(STM8S207)  || (STM8S103) || (STM8S105)  */

/************************************* TIM5 & TIM6 ****************************/
#ifdef STM8S903
/* #define _TIM5 (1) */
/* #define _TIM6 (1) */
#endif /* STM8S903 */ 

/************************************* UARTx **********************************/
#if defined(STM8S208) ||defined(STM8S207) ||defined(STM8S103) ||defined(STM8S903)
/* #define _UART1 (1) */
#endif /* (STM8S208) ||(STM8S207)  || (STM8S103) || (STM8S903)  */

#ifdef STM8S105
/* #define _UART2 (1) */
#endif /* STM8S105 */

#if defined(STM8S208) ||defined(STM8S207)
/* #define _UART3 (1) */
#endif /* (STM8S208) ||(STM8S207) */

/************************************* WWDG ***********************************/
/* #define _WWDG (1) */

/* Exported macro ------------------------------------------------------------*/

/**
  * @brief The assert macro is used for function's parameters check.
  * There is a normal mode and a full mode when the FULL_ASSERT constant is
  * defined.
  * @par Parameters:
  * expr : If expr is false, it calls the assert_failed call-back function.
  * This call-back function must be defined in your application.
  * @retval void None
  * @par Required preconditions:
  * None
  */
#ifndef FULL_ASSERT /* FULL_ASSERT not defined */
 void assert_failed(void);
 #define assert_param(expr) ((expr) ? (void)(0) : assert_failed())
#else /* FULL_ASSERT defined */
 void assert_failed(u8 *file, u16 line);
 #define assert_param(expr) ((expr) ? (void)(0) : assert_failed(__FILE__, __LINE__))
#endif


/* Peripheral header file inclusion ******************************************/
#ifdef _ADC1
 #include "stm8s_adc1.h"
#endif /* _ADC1 */

#ifdef _ADC2
 #include "stm8s_adc2.h"
#endif /* _ADC2 */

#ifdef _AWU
 #include "stm8s_awu.h"
#endif /* _AWU */

#ifdef _BEEP
 #include "stm8s_beep.h"
#endif /* _BEEP */

#ifdef _CLK
 #include "stm8s_clk.h"
#endif /* _CLK */

#ifdef _EXTI
 #include "stm8s_exti.h"
#endif /* _EXTI */

#if defined(_FLASH) || defined(_OPT)
 #include "stm8s_flash.h"
#endif /* _FLASH/OPT */

#ifdef _GPIO
 #include "stm8s_gpio.h"
#endif /* _GPIOx */

#ifdef _I2C
 #include "stm8s_i2c.h"
#endif /* _I2C */

#ifdef _ITC
 #include "stm8s_itc.h"
#endif /* _ITC */

#ifdef _IWDG
 #include "stm8s_iwdg.h"
#endif /* _IWDG */

#ifdef _RST
 #include "stm8s_rst.h"
#endif /* _RST */

#ifdef _SPI
 #include "stm8s_spi.h"
#endif /* _SPI */

#ifdef _TIM1
 #include "stm8s_tim1.h"
#endif /* _TIM1 */

#ifdef _TIM2
 #include "stm8s_tim2.h"
#endif /* _TIM2 */

#ifdef _TIM3
 #include "stm8s_tim3.h"
#endif /* _TIM3 */

#ifdef _TIM4
 #include "stm8s_tim4.h"
#endif /* _TIM4 */

#ifdef _TIM5
 #include "stm8s_tim5.h"
#endif /* _TIM5 */

#ifdef _TIM6
 #include "stm8s_tim6.h"
#endif /* _TIM6 */

#ifdef _UART1
 #include "stm8s_uart1.h"
#endif /* _UART1 */

#ifdef _UART2
 #include "stm8s_uart2.h"
#endif /* _UART2 */

#ifdef _UART3
 #include "stm8s_uart3.h"
#endif /* _UART3 */

#ifdef _WWDG
 #include "stm8s_wwdg.h"
#endif /* _WWDG */

#ifdef _CAN
 #include "stm8s_can.h"
#endif /* _CAN */

#endif /* __STM8S_CONF_H */

/******************* (C) COPYRIGHT 2009 STMicroelectronics *****END OF FILE****/
