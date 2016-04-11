   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2589                     ; 29 void uart_conf(void)
2589                     ; 30 {
2591                     	switch	.text
2592  0000               _uart_conf:
2594  0000 89            	pushw	x
2595       00000002      OFST:	set	2
2598                     ; 31     unsigned int baud_div=0;
2600                     ; 33     UART1_CR1 = (0<<4)|(0<<3)|(0<<2)|(0<<1)|(0<<0); 
2602  0001 725f5234      	clr	_UART1_CR1
2603                     ; 35     UART1_CR2 = (0<<7)|(0<<6)|(1<<5)|(0<<4)|(1<<3)|(1<<2); 
2605  0005 352c5235      	mov	_UART1_CR2,#44
2606                     ; 37     UART1_CR3 = (0<<6)|(0<<4)|(0<<3); /*设置1位停止位 不使能SCLK*/        
2608  0009 725f5236      	clr	_UART1_CR3
2609                     ; 38     UART1_CR5 = (0<<2)|(0<<1);     
2611  000d 725f5238      	clr	_UART1_CR5
2612                     ; 42     baud_div =HSIClockFreq/BaudRate;  /*求出分频因子*/
2614                     ; 43     UART1_BRR2 = baud_div & 0x0f;
2616  0011 350a5233      	mov	_UART1_BRR2,#10
2617                     ; 44     UART1_BRR2 |= ((baud_div & 0xf000) >> 8);
2619  0015 c65233        	ld	a,_UART1_BRR2
2620                     ; 45     UART1_BRR1 = ((baud_div & 0x0ff0) >> 4);    /*先给BRR2赋值 最后再设置BRR1*/
2622  0018 35085232      	mov	_UART1_BRR1,#8
2623                     ; 47     UART1_CR1 |= (0<<5);         /*使能UART*/
2625  001c c65234        	ld	a,_UART1_CR1
2626                     ; 49 }
2629  001f 85            	popw	x
2630  0020 81            	ret
2666                     ; 60 void UART1_SendByte(u8 data)
2666                     ; 61 {
2667                     	switch	.text
2668  0021               _UART1_SendByte:
2672                     ; 63     UART1_DR=data;
2674  0021 c75231        	ld	_UART1_DR,a
2676  0024               L1071:
2677                     ; 65    while (!(UART1_SR & UART1_FLAG_TXE));
2679  0024 c65230        	ld	a,_UART1_SR
2680  0027 a580          	bcp	a,#128
2681  0029 27f9          	jreq	L1071
2682                     ; 66 }
2685  002b 81            	ret
2739                     ; 78 void UART1_SendString(u8* Data,u16 len)
2739                     ; 79 {
2740                     	switch	.text
2741  002c               _UART1_SendString:
2743  002c 89            	pushw	x
2744  002d 89            	pushw	x
2745       00000002      OFST:	set	2
2748                     ; 80   u16 i=0;
2750  002e 5f            	clrw	x
2751  002f 1f01          	ldw	(OFST-1,sp),x
2753  0031 200f          	jra	L7371
2754  0033               L3371:
2755                     ; 82     UART1_SendByte(Data[i]);
2757  0033 1e03          	ldw	x,(OFST+1,sp)
2758  0035 72fb01        	addw	x,(OFST-1,sp)
2759  0038 f6            	ld	a,(x)
2760  0039 ade6          	call	_UART1_SendByte
2762                     ; 81   for(;i<len;i++)
2764  003b 1e01          	ldw	x,(OFST-1,sp)
2765  003d 1c0001        	addw	x,#1
2766  0040 1f01          	ldw	(OFST-1,sp),x
2767  0042               L7371:
2770  0042 1e01          	ldw	x,(OFST-1,sp)
2771  0044 1307          	cpw	x,(OFST+5,sp)
2772  0046 25eb          	jrult	L3371
2773                     ; 84 }
2776  0048 5b04          	addw	sp,#4
2777  004a 81            	ret
2813                     ; 95 u8 UART1_ReceiveByte(void)
2813                     ; 96 {
2814                     	switch	.text
2815  004b               _UART1_ReceiveByte:
2817  004b 88            	push	a
2818       00000001      OFST:	set	1
2821  004c               L3671:
2822                     ; 98      while (!(UART1_SR & UART1_FLAG_RXNE));
2824  004c c65230        	ld	a,_UART1_SR
2825  004f a520          	bcp	a,#32
2826  0051 27f9          	jreq	L3671
2827                     ; 99      USART1_RX_BUF=(u8)UART1_DR;
2829  0053 c65231        	ld	a,_UART1_DR
2830  0056 6b01          	ld	(OFST+0,sp),a
2831                     ; 100      return  USART1_RX_BUF;
2833  0058 7b01          	ld	a,(OFST+0,sp)
2836  005a 5b01          	addw	sp,#1
2837  005c 81            	ret
2850                     	xdef	_UART1_ReceiveByte
2851                     	xdef	_UART1_SendString
2852                     	xdef	_UART1_SendByte
2853                     	xdef	_uart_conf
2872                     	end
