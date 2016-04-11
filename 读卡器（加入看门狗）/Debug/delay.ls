   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2592                     ; 3 void delayms(u16 ms)
2592                     ; 4 {
2594                     	switch	.text
2595  0000               _delayms:
2597  0000 89            	pushw	x
2598  0001 88            	push	a
2599       00000001      OFST:	set	1
2602  0002 201b          	jra	L5661
2603  0004               L3661:
2604                     ; 8     for(i=0;i<250;i++)
2606  0004 0f01          	clr	(OFST+0,sp)
2607  0006               L1761:
2610  0006 0c01          	inc	(OFST+0,sp)
2613  0008 7b01          	ld	a,(OFST+0,sp)
2614  000a a1fa          	cp	a,#250
2615  000c 25f8          	jrult	L1761
2616                     ; 11     for(i=0;i<75;i++)
2618  000e 0f01          	clr	(OFST+0,sp)
2619  0010               L7761:
2622  0010 0c01          	inc	(OFST+0,sp)
2625  0012 7b01          	ld	a,(OFST+0,sp)
2626  0014 a14b          	cp	a,#75
2627  0016 25f8          	jrult	L7761
2628                     ; 14     ms--;  
2630  0018 1e02          	ldw	x,(OFST+1,sp)
2631  001a 1d0001        	subw	x,#1
2632  001d 1f02          	ldw	(OFST+1,sp),x
2634  001f               L5661:
2635                     ; 6   while(ms != 0)
2637  001f 1e02          	ldw	x,(OFST+1,sp)
2638  0021 26e1          	jrne	L3661
2639                     ; 17 }
2642  0023 5b03          	addw	sp,#3
2643  0025 81            	ret
2656                     	xdef	_delayms
2675                     	end
