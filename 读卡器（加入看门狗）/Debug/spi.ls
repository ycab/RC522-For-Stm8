   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2575                     ; 21 void  SPI_conf(void)
2575                     ; 22 {
2577                     	switch	.text
2578  0000               _SPI_conf:
2582                     ; 23   SPI_CR1 = (0<<7)|(0<<6)|(0<<3)|(1<<2)|(1<<1)|(1<<0);  /* 先发送MSB 先禁止SPI 波特率设为 fbus/2 设置为主模式 空闲状态时SCK为高电平 数据从第二个时钟边沿开始采样 */
2584  0000 35075200      	mov	_SPI_CR1,#7
2585                     ; 24   SPI_CR2 = (0<<7)|(0<<5)|(0<<4)|(0<<2)|(1<<1)|(1<<0);  /* 设为全双工模式 使能软件从设备管理 内部从设备选择为主模式 */
2587  0004 35035201      	mov	_SPI_CR2,#3
2588                     ; 25   SPI_ICR = (0<<7)|(0<<6)|(0<<5)|(0<<4);                /* 禁止所有中断 */
2590  0008 725f5202      	clr	_SPI_ICR
2591                     ; 26   SPI_CR1 |= (1<<6);                                    /* 开启SPI模块 */
2593  000c 721c5200      	bset	_SPI_CR1,#6
2594                     ; 27 }
2597  0010 81            	ret
2633                     ; 38 unsigned char SPI_SendByte(unsigned char byte)
2633                     ; 39 {
2634                     	switch	.text
2635  0011               _SPI_SendByte:
2637  0011 88            	push	a
2638       00000000      OFST:	set	0
2641  0012               L1761:
2642                     ; 40   while(!(SPI_SR & 0x02));              /* 等待发送寄存器为空 */
2644  0012 c65203        	ld	a,_SPI_SR
2645  0015 a502          	bcp	a,#2
2646  0017 27f9          	jreq	L1761
2647                     ; 41   SPI_DR = byte;                        /* 将发送的数据写到数据寄存器 */
2649  0019 7b01          	ld	a,(OFST+1,sp)
2650  001b c75204        	ld	_SPI_DR,a
2652  001e               L1071:
2653                     ; 43   while(!(SPI_SR & 0x02));
2655  001e c65203        	ld	a,_SPI_SR
2656  0021 a502          	bcp	a,#2
2657  0023 27f9          	jreq	L1071
2659  0025               L7071:
2660                     ; 44   while(!(SPI_SR & 0x01));              /* 等待接受寄存器满 */
2662  0025 c65203        	ld	a,_SPI_SR
2663  0028 a501          	bcp	a,#1
2664  002a 27f9          	jreq	L7071
2665                     ; 45   return SPI_DR;                        /* 读数据寄存器 */
2667  002c c65204        	ld	a,_SPI_DR
2670  002f 5b01          	addw	sp,#1
2671  0031 81            	ret
2684                     	xdef	_SPI_SendByte
2685                     	xdef	_SPI_conf
2704                     	end
