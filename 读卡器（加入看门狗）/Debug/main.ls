   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2545                     	bsct
2546  0000               _crc_tab:
2547  0000 0000          	dc.w	0
2548  0002 1021          	dc.w	4129
2549  0004 2042          	dc.w	8258
2550  0006 3063          	dc.w	12387
2551  0008 4084          	dc.w	16516
2552  000a 50a5          	dc.w	20645
2553  000c 60c6          	dc.w	24774
2554  000e 70e7          	dc.w	28903
2555  0010 8108          	dc.w	-32504
2556  0012 9129          	dc.w	-28375
2557  0014 a14a          	dc.w	-24246
2558  0016 b16b          	dc.w	-20117
2559  0018 c18c          	dc.w	-15988
2560  001a d1ad          	dc.w	-11859
2561  001c e1ce          	dc.w	-7730
2562  001e f1ef          	dc.w	-3601
2660                     ; 44 main()
2660                     ; 45 {
2662                     	switch	.text
2663  0000               _main:
2665  0000 5208          	subw	sp,#8
2666       00000008      OFST:	set	8
2669                     ; 55 		delayms(1000);
2671  0002 ae03e8        	ldw	x,#1000
2672  0005 cd0000        	call	_delayms
2674                     ; 57   PD_ODR|=0x04;//RC522的复位脚
2676  0008 7214500f      	bset	_PD_ODR,#2
2677                     ; 58 	CLK_CKDIVR&= (u8)(~0x18);/*时钟复位*/
2679  000c c650c6        	ld	a,_CLK_CKDIVR
2680  000f a4e7          	and	a,#231
2681  0011 c750c6        	ld	_CLK_CKDIVR,a
2682                     ; 59   CLK_CKDIVR|= (u8)0x00;/*设置时钟为内部16M高速时钟*/
2684  0014 c650c6        	ld	a,_CLK_CKDIVR
2685                     ; 60 	uart_conf();
2687  0017 cd0000        	call	_uart_conf
2689                     ; 61 	UART1_SendByte(0x44);
2691  001a a644          	ld	a,#68
2692  001c cd0000        	call	_UART1_SendByte
2694                     ; 63 	PC_DDR|=(1<<4);//配置PC4，SPI_NSS,10M输出
2696  001f 7218500c      	bset	_PC_DDR,#4
2697                     ; 64   PC_CR1|=(1<<4);
2699  0023 7218500d      	bset	_PC_CR1,#4
2700                     ; 65   PC_CR2|=(1<<4);
2702  0027 7218500e      	bset	_PC_CR2,#4
2703                     ; 67   SPI_conf();
2705  002b cd0000        	call	_SPI_conf
2707                     ; 68   RC522_Init();
2709  002e cd0000        	call	_RC522_Init
2711                     ; 69 	Beep_init();
2713  0031 cd01b7        	call	_Beep_init
2715                     ; 70 	KM1_init();
2717  0034 cd01c4        	call	_KM1_init
2719                     ; 71 	PC_ODR&=0xEF;//将PC置为11101111，即拉下片选SPI_NSS
2721  0037 7219500a      	bres	_PC_ODR,#4
2722                     ; 72 	_asm("rim");
2725  003b 9a            rim
2727                     ; 73 	 IWDG_init();
2729  003c cd01a2        	call	_IWDG_init
2731                     ; 74 	 Find_State=Find_0x55_1 ;
2733  003f 35010002      	mov	_Find_State,#1
2734  0043               L5761:
2735                     ; 78 		  IWDG_KR = 0xAA; //刷新IDDG，避免产生看门狗复位，同时恢复 PR 及 RLR 的写保护状态 
2737  0043 35aa50e0      	mov	_IWDG_KR,#170
2738                     ; 79 		  PcdRequest(PICC_REQALL,SBuf);
2740  0047 ae0003        	ldw	x,#_SBuf
2741  004a 89            	pushw	x
2742  004b a652          	ld	a,#82
2743  004d cd0000        	call	_PcdRequest
2745  0050 85            	popw	x
2746                     ; 80       state=PcdAnticoll(Temp.cBuf);
2748  0051 96            	ldw	x,sp
2749  0052 1c0003        	addw	x,#OFST-5
2750  0055 cd0000        	call	_PcdAnticoll
2752  0058 b73f          	ld	_state,a
2753                     ; 82 			if(state==MI_OK)
2755  005a 3d3f          	tnz	_state
2756  005c 2703cc00e6    	jrne	L1071
2757                     ; 86 				UART1_SendByte(0x55);
2759  0061 a655          	ld	a,#85
2760  0063 cd0000        	call	_UART1_SendByte
2762                     ; 87 				UART1_SendByte(0xAA);
2764  0066 a6aa          	ld	a,#170
2765  0068 cd0000        	call	_UART1_SendByte
2767                     ; 88 				for(i=0;i<=3;i++)
2769  006b 5f            	clrw	x
2770  006c 1f07          	ldw	(OFST-1,sp),x
2771  006e               L3071:
2772                     ; 90 					card_id[i]=Temp.cBuf[i];
2774  006e 1e07          	ldw	x,(OFST-1,sp)
2775  0070 9096          	ldw	y,sp
2776  0072 72a90003      	addw	y,#OFST-5
2777  0076 1701          	ldw	(OFST-7,sp),y
2778  0078 1607          	ldw	y,(OFST-1,sp)
2779  007a 72f901        	addw	y,(OFST-7,sp)
2780  007d 90f6          	ld	a,(y)
2781  007f e742          	ld	(_card_id,x),a
2782                     ; 88 				for(i=0;i<=3;i++)
2784  0081 1e07          	ldw	x,(OFST-1,sp)
2785  0083 1c0001        	addw	x,#1
2786  0086 1f07          	ldw	(OFST-1,sp),x
2789  0088 9c            	rvf
2790  0089 1e07          	ldw	x,(OFST-1,sp)
2791  008b a30004        	cpw	x,#4
2792  008e 2fde          	jrslt	L3071
2793                     ; 92 				for(i=0;i<=3;i++)
2795  0090 5f            	clrw	x
2796  0091 1f07          	ldw	(OFST-1,sp),x
2797  0093               L1171:
2798                     ; 94 					UART1_SendByte(card_id[i]);
2800  0093 1e07          	ldw	x,(OFST-1,sp)
2801  0095 e642          	ld	a,(_card_id,x)
2802  0097 cd0000        	call	_UART1_SendByte
2804                     ; 92 				for(i=0;i<=3;i++)
2806  009a 1e07          	ldw	x,(OFST-1,sp)
2807  009c 1c0001        	addw	x,#1
2808  009f 1f07          	ldw	(OFST-1,sp),x
2811  00a1 9c            	rvf
2812  00a2 1e07          	ldw	x,(OFST-1,sp)
2813  00a4 a30004        	cpw	x,#4
2814  00a7 2fea          	jrslt	L1171
2815                     ; 97 			   	crc_get=cal_CRC(card_id,4);
2817  00a9 4b04          	push	#4
2818  00ab ae0042        	ldw	x,#_card_id
2819  00ae cd0130        	call	_cal_CRC
2821  00b1 84            	pop	a
2822  00b2 bf40          	ldw	_crc_get,x
2823                     ; 98 			  	UART1_SendByte((u8)(crc_get>>8));//高位
2825  00b4 b640          	ld	a,_crc_get
2826  00b6 cd0000        	call	_UART1_SendByte
2828                     ; 99 					UART1_SendByte((u8)crc_get);     //低位
2830  00b9 b641          	ld	a,_crc_get+1
2831  00bb cd0000        	call	_UART1_SendByte
2833                     ; 100 			  	UART1_SendByte(0xAA);
2835  00be a6aa          	ld	a,#170
2836  00c0 cd0000        	call	_UART1_SendByte
2838                     ; 101 			  	UART1_SendByte(0x55);
2840  00c3 a655          	ld	a,#85
2841  00c5 cd0000        	call	_UART1_SendByte
2843                     ; 102 					for(i=1;i<=3;i++)
2845  00c8 ae0001        	ldw	x,#1
2846  00cb 1f07          	ldw	(OFST-1,sp),x
2847  00cd               L7171:
2848                     ; 104 						delayms(1000);
2850  00cd ae03e8        	ldw	x,#1000
2851  00d0 cd0000        	call	_delayms
2853                     ; 102 					for(i=1;i<=3;i++)
2855  00d3 1e07          	ldw	x,(OFST-1,sp)
2856  00d5 1c0001        	addw	x,#1
2857  00d8 1f07          	ldw	(OFST-1,sp),x
2860  00da 9c            	rvf
2861  00db 1e07          	ldw	x,(OFST-1,sp)
2862  00dd a30004        	cpw	x,#4
2863  00e0 2feb          	jrslt	L7171
2865  00e2 ac430043      	jpf	L5761
2866  00e6               L1071:
2867                     ; 109 				UART1_SendByte(0x55);
2869  00e6 a655          	ld	a,#85
2870  00e8 cd0000        	call	_UART1_SendByte
2872                     ; 110 				UART1_SendByte(0xAA);
2874  00eb a6aa          	ld	a,#170
2875  00ed cd0000        	call	_UART1_SendByte
2877                     ; 112 				UART1_SendByte(0x00);
2879  00f0 4f            	clr	a
2880  00f1 cd0000        	call	_UART1_SendByte
2882                     ; 113 				UART1_SendByte(0x00);
2884  00f4 4f            	clr	a
2885  00f5 cd0000        	call	_UART1_SendByte
2887                     ; 114 				UART1_SendByte(0x00);
2889  00f8 4f            	clr	a
2890  00f9 cd0000        	call	_UART1_SendByte
2892                     ; 115 				UART1_SendByte(0x00);
2894  00fc 4f            	clr	a
2895  00fd cd0000        	call	_UART1_SendByte
2897                     ; 116 				UART1_SendByte(0x00);
2899  0100 4f            	clr	a
2900  0101 cd0000        	call	_UART1_SendByte
2902                     ; 117 				UART1_SendByte(0x00);
2904  0104 4f            	clr	a
2905  0105 cd0000        	call	_UART1_SendByte
2907                     ; 119 				UART1_SendByte(0xAA);
2909  0108 a6aa          	ld	a,#170
2910  010a cd0000        	call	_UART1_SendByte
2912                     ; 120 				UART1_SendByte(0x55);
2914  010d a655          	ld	a,#85
2915  010f cd0000        	call	_UART1_SendByte
2917                     ; 121 				for(i=1;i<=3;i++)
2919  0112 ae0001        	ldw	x,#1
2920  0115 1f07          	ldw	(OFST-1,sp),x
2921  0117               L7271:
2922                     ; 123 						delayms(1000);
2924  0117 ae03e8        	ldw	x,#1000
2925  011a cd0000        	call	_delayms
2927                     ; 121 				for(i=1;i<=3;i++)
2929  011d 1e07          	ldw	x,(OFST-1,sp)
2930  011f 1c0001        	addw	x,#1
2931  0122 1f07          	ldw	(OFST-1,sp),x
2934  0124 9c            	rvf
2935  0125 1e07          	ldw	x,(OFST-1,sp)
2936  0127 a30004        	cpw	x,#4
2937  012a 2feb          	jrslt	L7271
2938  012c ac430043      	jpf	L5761
3001                     ; 135 unsigned int cal_CRC(unsigned char *ptr,unsigned char len)
3001                     ; 136 {
3002                     	switch	.text
3003  0130               _cal_CRC:
3005  0130 89            	pushw	x
3006  0131 5203          	subw	sp,#3
3007       00000003      OFST:	set	3
3010                     ; 139     crc = 0x00;
3012  0133 5f            	clrw	x
3013  0134 1f02          	ldw	(OFST-1,sp),x
3015  0136 205e          	jra	L3771
3016  0138               L7671:
3017                     ; 142         dat   = ((unsigned char)((crc/256))/16 & 0x000f);  
3019  0138 7b02          	ld	a,(OFST-1,sp)
3020  013a 4e            	swap	a
3021  013b a40f          	and	a,#15
3022  013d 6b01          	ld	(OFST-2,sp),a
3023                     ; 143         crc   = (unsigned int)((crc<<4)&0xfff0);         
3025  013f 1e02          	ldw	x,(OFST-1,sp)
3026  0141 58            	sllw	x
3027  0142 58            	sllw	x
3028  0143 58            	sllw	x
3029  0144 58            	sllw	x
3030  0145 01            	rrwa	x,a
3031  0146 a4f0          	and	a,#240
3032  0148 01            	rrwa	x,a
3033  0149 a4ff          	and	a,#255
3034  014b 01            	rrwa	x,a
3035  014c 1f02          	ldw	(OFST-1,sp),x
3036                     ; 144         crc  ^= crc_tab[dat^(*ptr/16)];             
3038  014e 1e04          	ldw	x,(OFST+1,sp)
3039  0150 f6            	ld	a,(x)
3040  0151 4e            	swap	a
3041  0152 a40f          	and	a,#15
3042  0154 5f            	clrw	x
3043  0155 1801          	xor	a,(OFST-2,sp)
3044  0157 02            	rlwa	x,a
3045  0158 58            	sllw	x
3046  0159 ee00          	ldw	x,(_crc_tab,x)
3047  015b 01            	rrwa	x,a
3048  015c 1803          	xor	a,(OFST+0,sp)
3049  015e 01            	rrwa	x,a
3050  015f 1802          	xor	a,(OFST-1,sp)
3051  0161 01            	rrwa	x,a
3052  0162 1f02          	ldw	(OFST-1,sp),x
3053                     ; 145         dat   = ((unsigned char)((crc/256))/16 & 0x000f);  
3055  0164 7b02          	ld	a,(OFST-1,sp)
3056  0166 4e            	swap	a
3057  0167 a40f          	and	a,#15
3058  0169 6b01          	ld	(OFST-2,sp),a
3059                     ; 146         crc   = (unsigned int)((crc<<4)&0xfff0);         
3061  016b 1e02          	ldw	x,(OFST-1,sp)
3062  016d 58            	sllw	x
3063  016e 58            	sllw	x
3064  016f 58            	sllw	x
3065  0170 58            	sllw	x
3066  0171 01            	rrwa	x,a
3067  0172 a4f0          	and	a,#240
3068  0174 01            	rrwa	x,a
3069  0175 a4ff          	and	a,#255
3070  0177 01            	rrwa	x,a
3071  0178 1f02          	ldw	(OFST-1,sp),x
3072                     ; 147         crc  ^= crc_tab[dat^(*ptr&0x0f)];            
3074  017a 1e04          	ldw	x,(OFST+1,sp)
3075  017c f6            	ld	a,(x)
3076  017d a40f          	and	a,#15
3077  017f 1801          	xor	a,(OFST-2,sp)
3078  0181 5f            	clrw	x
3079  0182 97            	ld	xl,a
3080  0183 58            	sllw	x
3081  0184 ee00          	ldw	x,(_crc_tab,x)
3082  0186 01            	rrwa	x,a
3083  0187 1803          	xor	a,(OFST+0,sp)
3084  0189 01            	rrwa	x,a
3085  018a 1802          	xor	a,(OFST-1,sp)
3086  018c 01            	rrwa	x,a
3087  018d 1f02          	ldw	(OFST-1,sp),x
3088                     ; 148         ptr++;
3090  018f 1e04          	ldw	x,(OFST+1,sp)
3091  0191 1c0001        	addw	x,#1
3092  0194 1f04          	ldw	(OFST+1,sp),x
3093  0196               L3771:
3094                     ; 140     while(len--!=0)
3096  0196 7b08          	ld	a,(OFST+5,sp)
3097  0198 0a08          	dec	(OFST+5,sp)
3098  019a 4d            	tnz	a
3099  019b 269b          	jrne	L7671
3100                     ; 150     return(crc);
3102  019d 1e02          	ldw	x,(OFST-1,sp)
3105  019f 5b05          	addw	sp,#5
3106  01a1 81            	ret
3132                     ; 152 void IWDG_init(void)
3132                     ; 153 {
3133                     	switch	.text
3134  01a2               _IWDG_init:
3138                     ; 154 				IWDG_KR = 0xCC; //启动IWDG
3140  01a2 35cc50e0      	mov	_IWDG_KR,#204
3141                     ; 155         IWDG_KR = 0x55;        //解除 PR 及 RLR 的写保护
3143  01a6 355550e0      	mov	_IWDG_KR,#85
3144                     ; 156         IWDG_RLR = 0xFF; //看门狗计数器重装载数值        
3146  01aa 35ff50e2      	mov	_IWDG_RLR,#255
3147                     ; 157         IWDG_PR = 0x06; //分频系数为256，最长超时时间为：1.02S
3149  01ae 350650e1      	mov	_IWDG_PR,#6
3150                     ; 158         IWDG_KR = 0xAA; //刷新IDDG，避免产生看门狗复位，同时恢复 PR 及 RLR 的写保护状态 
3152  01b2 35aa50e0      	mov	_IWDG_KR,#170
3153                     ; 159 }
3156  01b6 81            	ret
3182                     ; 160 void Beep_init(void)//PC3管脚
3182                     ; 161 {
3183                     	switch	.text
3184  01b7               _Beep_init:
3188                     ; 162 	PC_DDR|=(1<<3);//配置PC3，输出10MHz
3190  01b7 7216500c      	bset	_PC_DDR,#3
3191                     ; 163   PC_CR1|=(1<<3);
3193  01bb 7216500d      	bset	_PC_CR1,#3
3194                     ; 164   PC_CR2|=(1<<3);
3196  01bf 7216500e      	bset	_PC_CR2,#3
3197                     ; 165 }
3200  01c3 81            	ret
3226                     ; 166 void KM1_init(void)
3226                     ; 167 {
3227                     	switch	.text
3228  01c4               _KM1_init:
3232                     ; 168 	PA_DDR|=(1<<3);//配置PA3，输出10MHz
3234  01c4 72165002      	bset	_PA_DDR,#3
3235                     ; 169   PA_CR1|=(1<<3);
3237  01c8 72165003      	bset	_PA_CR1,#3
3238                     ; 170   PA_CR2|=(1<<3);
3240  01cc 72165004      	bset	_PA_CR2,#3
3241                     ; 171 }
3244  01d0 81            	ret
3286                     ; 172 @far @interrupt void UART1_RX_IRQHandler(void)
3286                     ; 173 { 
3288                     	switch	.text
3289  01d1               f_UART1_RX_IRQHandler:
3291       00000001      OFST:	set	1
3292  01d1 88            	push	a
3295                     ; 175     if(UART1_SR & UART1_FLAG_RXNE)  
3297  01d2 c65230        	ld	a,_UART1_SR
3298  01d5 a520          	bcp	a,#32
3299  01d7 2604          	jrne	L02
3300  01d9 ac880288      	jpf	L5402
3301  01dd               L02:
3302                     ; 177 				Res =(u8)UART1_DR;
3304  01dd c65231        	ld	a,_UART1_DR
3305  01e0 6b01          	ld	(OFST+0,sp),a
3306                     ; 180 			 if(Find_State==Find_0x55_1)
3308  01e2 b602          	ld	a,_Find_State
3309  01e4 a101          	cp	a,#1
3310  01e6 2612          	jrne	L7402
3311                     ; 182 				 if(Res==0x55)
3313  01e8 7b01          	ld	a,(OFST+0,sp)
3314  01ea a155          	cp	a,#85
3315  01ec 2704          	jreq	L22
3316  01ee ac880288      	jpf	L5402
3317  01f2               L22:
3318                     ; 184 					 Find_State=Find_0xAA_1;
3320  01f2 35020002      	mov	_Find_State,#2
3321  01f6 ac880288      	jpf	L5402
3322  01fa               L7402:
3323                     ; 187 			 else if(Find_State==Find_0xAA_1)
3325  01fa b602          	ld	a,_Find_State
3326  01fc a102          	cp	a,#2
3327  01fe 2612          	jrne	L5502
3328                     ; 189 				 if(Res==0xAA)
3330  0200 7b01          	ld	a,(OFST+0,sp)
3331  0202 a1aa          	cp	a,#170
3332  0204 2606          	jrne	L7502
3333                     ; 191 					 Find_State=Find_KM1;
3335  0206 35030002      	mov	_Find_State,#3
3337  020a 207c          	jra	L5402
3338  020c               L7502:
3339                     ; 195 					 Find_State=Find_0x55_1;
3341  020c 35010002      	mov	_Find_State,#1
3342  0210 2076          	jra	L5402
3343  0212               L5502:
3344                     ; 198 			 else if(Find_State==Find_KM1)
3346  0212 b602          	ld	a,_Find_State
3347  0214 a103          	cp	a,#3
3348  0216 260a          	jrne	L5602
3349                     ; 200 				 KM1_State=Res;
3351  0218 7b01          	ld	a,(OFST+0,sp)
3352  021a b701          	ld	_KM1_State,a
3353                     ; 201 				 Find_State=Find_Beep;
3355  021c 35040002      	mov	_Find_State,#4
3357  0220 2066          	jra	L5402
3358  0222               L5602:
3359                     ; 203 				else if(Find_State==Find_Beep)
3361  0222 b602          	ld	a,_Find_State
3362  0224 a104          	cp	a,#4
3363  0226 260a          	jrne	L1702
3364                     ; 205 				 Beep_State=Res;
3366  0228 7b01          	ld	a,(OFST+0,sp)
3367  022a b700          	ld	_Beep_State,a
3368                     ; 206 				 Find_State=Find_0xAA_2;
3370  022c 35050002      	mov	_Find_State,#5
3372  0230 2056          	jra	L5402
3373  0232               L1702:
3374                     ; 208 				else if(Find_State==Find_0xAA_2)
3376  0232 b602          	ld	a,_Find_State
3377  0234 a105          	cp	a,#5
3378  0236 2612          	jrne	L5702
3379                     ; 210 					if(Res==0xAA)
3381  0238 7b01          	ld	a,(OFST+0,sp)
3382  023a a1aa          	cp	a,#170
3383  023c 2606          	jrne	L7702
3384                     ; 212 					 Find_State=Find_0x55_2;
3386  023e 35060002      	mov	_Find_State,#6
3388  0242 2044          	jra	L5402
3389  0244               L7702:
3390                     ; 216 					 Find_State=Find_0x55_1;
3392  0244 35010002      	mov	_Find_State,#1
3393  0248 203e          	jra	L5402
3394  024a               L5702:
3395                     ; 219 			 else if(Find_State==Find_0x55_2)
3397  024a b602          	ld	a,_Find_State
3398  024c a106          	cp	a,#6
3399  024e 2638          	jrne	L5402
3400                     ; 221 				 if(Res==0x55)
3402  0250 7b01          	ld	a,(OFST+0,sp)
3403  0252 a155          	cp	a,#85
3404  0254 262e          	jrne	L7012
3405                     ; 223 					 Find_State=Find_0x55_1;
3407  0256 35010002      	mov	_Find_State,#1
3408                     ; 224 					 if(Beep_State==0x01)
3410  025a b600          	ld	a,_Beep_State
3411  025c a101          	cp	a,#1
3412  025e 2606          	jrne	L1112
3413                     ; 226 						 PC_ODR|=(1<<3);
3415  0260 7216500a      	bset	_PC_ODR,#3
3417  0264 2008          	jra	L3112
3418  0266               L1112:
3419                     ; 228 					 else if(Beep_State==0x00)
3421  0266 3d00          	tnz	_Beep_State
3422  0268 2604          	jrne	L3112
3423                     ; 230 						 PC_ODR&=0xF7;
3425  026a 7217500a      	bres	_PC_ODR,#3
3426  026e               L3112:
3427                     ; 233 						if(KM1_State==0x01)
3429  026e b601          	ld	a,_KM1_State
3430  0270 a101          	cp	a,#1
3431  0272 2606          	jrne	L7112
3432                     ; 235 						 PA_ODR|=(1<<3);
3434  0274 72165000      	bset	_PA_ODR,#3
3436  0278 200e          	jra	L5402
3437  027a               L7112:
3438                     ; 237 					 else if(KM1_State==0x00)
3440  027a 3d01          	tnz	_KM1_State
3441  027c 260a          	jrne	L5402
3442                     ; 239 						 PA_ODR&=0xF7;
3444  027e 72175000      	bres	_PA_ODR,#3
3445  0282 2004          	jra	L5402
3446  0284               L7012:
3447                     ; 244 					 Find_State=Find_0x55_1;
3449  0284 35010002      	mov	_Find_State,#1
3450  0288               L5402:
3451                     ; 250 		return ;
3454  0288 84            	pop	a
3455  0289 80            	iret
3544                     	xdef	f_UART1_RX_IRQHandler
3545                     	xdef	_main
3546                     	switch	.ubsct
3547  0000               _Beep_State:
3548  0000 00            	ds.b	1
3549                     	xdef	_Beep_State
3550  0001               _KM1_State:
3551  0001 00            	ds.b	1
3552                     	xdef	_KM1_State
3553  0002               _Find_State:
3554  0002 00            	ds.b	1
3555                     	xdef	_Find_State
3556                     	xdef	_KM1_init
3557                     	xdef	_Beep_init
3558                     	xdef	_IWDG_init
3559                     	xdef	_cal_CRC
3560  0003               _SBuf:
3561  0003 000000000000  	ds.b	60
3562                     	xdef	_SBuf
3563  003f               _state:
3564  003f 00            	ds.b	1
3565                     	xdef	_state
3566  0040               _crc_get:
3567  0040 0000          	ds.b	2
3568                     	xdef	_crc_get
3569  0042               _card_id:
3570  0042 00000000      	ds.b	4
3571                     	xdef	_card_id
3572                     	xdef	_crc_tab
3573                     	xref	_PcdAnticoll
3574                     	xref	_PcdRequest
3575                     	xref	_RC522_Init
3576                     	xref	_SPI_conf
3577                     	xref	_UART1_SendByte
3578                     	xref	_uart_conf
3579                     	xref	_delayms
3599                     	end
