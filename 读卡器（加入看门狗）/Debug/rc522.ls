   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2585                     ; 19 unsigned char    SPI_RW(unsigned char value)
2585                     ; 20 {
2587                     	switch	.text
2588  0000               _SPI_RW:
2590  0000 88            	push	a
2591       00000000      OFST:	set	0
2594  0001               L1661:
2595                     ; 21    while(!(SPI_SR & 0X02));//判断发射为不为空
2597  0001 c65203        	ld	a,_SPI_SR
2598  0004 a502          	bcp	a,#2
2599  0006 27f9          	jreq	L1661
2600                     ; 22    SPI_DR = value;        //写值
2602  0008 7b01          	ld	a,(OFST+1,sp)
2603  000a c75204        	ld	_SPI_DR,a
2605  000d               L1761:
2606                     ; 23    while(!(SPI_SR & 0X02));//判断发射为不为空
2608  000d c65203        	ld	a,_SPI_SR
2609  0010 a502          	bcp	a,#2
2610  0012 27f9          	jreq	L1761
2612  0014               L7761:
2613                     ; 24    while(!(SPI_SR & 0x01));//判断是否收到数据
2615  0014 c65203        	ld	a,_SPI_SR
2616  0017 a501          	bcp	a,#1
2617  0019 27f9          	jreq	L7761
2618                     ; 25    return SPI_DR;         
2620  001b c65204        	ld	a,_SPI_DR
2623  001e 5b01          	addw	sp,#1
2624  0020 81            	ret
2627                     	bsct
2628  0000               _fHasRATS:
2629  0000 00            	dc.b	0
2665                     ; 31 void RC522_Init(void)
2665                     ; 32 {
2666                     	switch	.text
2667  0021               _RC522_Init:
2669  0021 88            	push	a
2670       00000001      OFST:	set	1
2673                     ; 34 	delayms(1);
2675  0022 ae0001        	ldw	x,#1
2676  0025 cd0000        	call	_delayms
2678                     ; 35 	WriteRawRC(ControlReg,0x10);//18 10
2680  0028 ae0010        	ldw	x,#16
2681  002b a60c          	ld	a,#12
2682  002d 95            	ld	xh,a
2683  002e cd036e        	call	_WriteRawRC
2685                     ; 36 	WriteRawRC(ModeReg,0x3F);//22 3f
2687  0031 ae003f        	ldw	x,#63
2688  0034 a611          	ld	a,#17
2689  0036 95            	ld	xh,a
2690  0037 cd036e        	call	_WriteRawRC
2692                     ; 37 	WriteRawRC(RFU23,0x00);//46 00
2694  003a 5f            	clrw	x
2695  003b a623          	ld	a,#35
2696  003d 95            	ld	xh,a
2697  003e cd036e        	call	_WriteRawRC
2699                     ; 38 	WriteRawRC(RFU25,0x80);//4a 80
2701  0041 ae0080        	ldw	x,#128
2702  0044 a625          	ld	a,#37
2703  0046 95            	ld	xh,a
2704  0047 cd036e        	call	_WriteRawRC
2706                     ; 39 	WriteRawRC(AutoTestReg,0x40);//6c 40 
2708  004a ae0040        	ldw	x,#64
2709  004d a636          	ld	a,#54
2710  004f 95            	ld	xh,a
2711  0050 cd036e        	call	_WriteRawRC
2713                     ; 40 	WriteRawRC(TxAutoReg,0x40);//2a 40
2715  0053 ae0040        	ldw	x,#64
2716  0056 a615          	ld	a,#21
2717  0058 95            	ld	xh,a
2718  0059 cd036e        	call	_WriteRawRC
2720                     ; 41 	ReadRawRC(TxAutoReg);//aa 40
2722  005c a615          	ld	a,#21
2723  005e cd0341        	call	_ReadRawRC
2725                     ; 42 	SetBitMask(TxControlReg,0x03);//a8 80 28 83
2727  0061 ae0003        	ldw	x,#3
2728  0064 a614          	ld	a,#20
2729  0066 95            	ld	xh,a
2730  0067 cd0398        	call	_SetBitMask
2732                     ; 43 	WriteRawRC(TPrescalerReg,0x3D);//56 3d
2734  006a ae003d        	ldw	x,#61
2735  006d a62b          	ld	a,#43
2736  006f 95            	ld	xh,a
2737  0070 cd036e        	call	_WriteRawRC
2739                     ; 44 	WriteRawRC(TModeReg,0x0D);//54 0d
2741  0073 ae000d        	ldw	x,#13
2742  0076 a62a          	ld	a,#42
2743  0078 95            	ld	xh,a
2744  0079 cd036e        	call	_WriteRawRC
2746                     ; 45 	WriteRawRC(TReloadRegL,0x0A);//5a 0a
2748  007c ae000a        	ldw	x,#10
2749  007f a62d          	ld	a,#45
2750  0081 95            	ld	xh,a
2751  0082 cd036e        	call	_WriteRawRC
2753                     ; 46 	WriteRawRC(TReloadRegH,0x00);//58 00
2755  0085 5f            	clrw	x
2756  0086 a62c          	ld	a,#44
2757  0088 95            	ld	xh,a
2758  0089 cd036e        	call	_WriteRawRC
2760                     ; 47 	WriteRawRC(ComIrqReg,0x01);//08 01
2762  008c ae0001        	ldw	x,#1
2763  008f a604          	ld	a,#4
2764  0091 95            	ld	xh,a
2765  0092 cd036e        	call	_WriteRawRC
2767                     ; 48 	SetBitMask(ControlReg,0x40);//98 10 18 50
2769  0095 ae0040        	ldw	x,#64
2770  0098 a60c          	ld	a,#12
2771  009a 95            	ld	xh,a
2772  009b cd0398        	call	_SetBitMask
2774  009e               L1271:
2775                     ; 51 		Temp = ReadRawRC(ComIrqReg);//88	15
2777  009e a604          	ld	a,#4
2778  00a0 cd0341        	call	_ReadRawRC
2780  00a3 6b01          	ld	(OFST+0,sp),a
2781                     ; 52 	}while(!(Temp&0x01));
2783  00a5 7b01          	ld	a,(OFST+0,sp)
2784  00a7 a501          	bcp	a,#1
2785  00a9 27f3          	jreq	L1271
2786                     ; 53 	WriteRawRC(ComIrqReg,0x01);//08 01
2788  00ab ae0001        	ldw	x,#1
2789  00ae a604          	ld	a,#4
2790  00b0 95            	ld	xh,a
2791  00b1 cd036e        	call	_WriteRawRC
2793                     ; 54 	WriteRawRC(CommandReg,0x00);//02 00
2795  00b4 5f            	clrw	x
2796  00b5 a601          	ld	a,#1
2797  00b7 95            	ld	xh,a
2798  00b8 cd036e        	call	_WriteRawRC
2800                     ; 55 }
2803  00bb 84            	pop	a
2804  00bc 81            	ret
2892                     ; 70 unsigned char PcdRequest(unsigned char req_code,unsigned char *pTagType)
2892                     ; 71 {
2893                     	switch	.text
2894  00bd               _PcdRequest:
2896  00bd 88            	push	a
2897  00be 5244          	subw	sp,#68
2898       00000044      OFST:	set	68
2901                     ; 77 	char i=0;
2903  00c0 0f03          	clr	(OFST-65,sp)
2904                     ; 78 	if(fHasRATS != 1)
2906  00c2 b600          	ld	a,_fHasRATS
2907  00c4 a101          	cp	a,#1
2908  00c6 277c          	jreq	L1771
2909  00c8               L3771:
2910                     ; 82 			status = ReadRawRC(Status2Reg);	//90 00(01,05)
2912  00c8 a608          	ld	a,#8
2913  00ca cd0341        	call	_ReadRawRC
2915  00cd 6b44          	ld	(OFST+0,sp),a
2916                     ; 83 			WriteRawRC(Status2Reg,status&0xf7);	//10 00
2918  00cf 7b44          	ld	a,(OFST+0,sp)
2919  00d1 a4f7          	and	a,#247
2920  00d3 97            	ld	xl,a
2921  00d4 a608          	ld	a,#8
2922  00d6 95            	ld	xh,a
2923  00d7 cd036e        	call	_WriteRawRC
2925                     ; 84 			WriteRawRC(CollReg,0x80);		//1c 80
2927  00da ae0080        	ldw	x,#128
2928  00dd a60e          	ld	a,#14
2929  00df 95            	ld	xh,a
2930  00e0 cd036e        	call	_WriteRawRC
2932                     ; 85 			ClearBitMask(TxModeReg,0x80);	//a4 00 24 00
2934  00e3 ae0080        	ldw	x,#128
2935  00e6 a612          	ld	a,#18
2936  00e8 95            	ld	xh,a
2937  00e9 cd03ac        	call	_ClearBitMask
2939                     ; 86 			ClearBitMask(RxModeReg,0x80);	//a6 00 26 00
2941  00ec ae0080        	ldw	x,#128
2942  00ef a613          	ld	a,#19
2943  00f1 95            	ld	xh,a
2944  00f2 cd03ac        	call	_ClearBitMask
2946                     ; 87 			WriteRawRC(BitFramingReg,0x07); //1a 07
2948  00f5 ae0007        	ldw	x,#7
2949  00f8 a60d          	ld	a,#13
2950  00fa 95            	ld	xh,a
2951  00fb cd036e        	call	_WriteRawRC
2953                     ; 88 			SetBitMask(TxControlReg,0x03);  //a8 83 28 83
2955  00fe ae0003        	ldw	x,#3
2956  0101 a614          	ld	a,#20
2957  0103 95            	ld	xh,a
2958  0104 cd0398        	call	_SetBitMask
2960                     ; 89 			ucComMF522Buf[0] = req_code;
2962  0107 7b45          	ld	a,(OFST+1,sp)
2963  0109 6b04          	ld	(OFST-64,sp),a
2964                     ; 90 			i++;
2966  010b 0c03          	inc	(OFST-65,sp)
2967                     ; 91 			status = PcdComMF522_P(PCD_TRANSCEIVE,ucComMF522Buf,1,ucComMF522Buf,&unLen,0x0002);
2969  010d ae0002        	ldw	x,#2
2970  0110 89            	pushw	x
2971  0111 96            	ldw	x,sp
2972  0112 1c0003        	addw	x,#OFST-65
2973  0115 89            	pushw	x
2974  0116 96            	ldw	x,sp
2975  0117 1c0008        	addw	x,#OFST-60
2976  011a 89            	pushw	x
2977  011b 4b01          	push	#1
2978  011d 96            	ldw	x,sp
2979  011e 1c000b        	addw	x,#OFST-57
2980  0121 89            	pushw	x
2981  0122 a60c          	ld	a,#12
2982  0124 cd03c1        	call	_PcdComMF522_P
2984  0127 5b09          	addw	sp,#9
2985  0129 6b44          	ld	(OFST+0,sp),a
2986                     ; 92 			if(i>=2)
2988  012b 7b03          	ld	a,(OFST-65,sp)
2989  012d a102          	cp	a,#2
2990  012f 2503          	jrult	L21
2991  0131 cc01df        	jp	L3002
2992  0134               L21:
2993                     ; 93 				break;
2995                     ; 94 			delayms(1);
2997  0134 ae0001        	ldw	x,#1
2998  0137 cd0000        	call	_delayms
3000                     ; 95 		}while(status ==MI_TIMEOUT );
3002  013a 7b44          	ld	a,(OFST+0,sp)
3003  013c a104          	cp	a,#4
3004  013e 2788          	jreq	L3771
3005  0140 acdf01df      	jpf	L3002
3006  0144               L1771:
3007                     ; 101 	 	SetBitMask(TxModeReg,0x80);//a4 80 24 80
3009  0144 ae0080        	ldw	x,#128
3010  0147 a612          	ld	a,#18
3011  0149 95            	ld	xh,a
3012  014a cd0398        	call	_SetBitMask
3014                     ; 102 		SetBitMask(RxModeReg,0x80);//a6 80 26 80
3016  014d ae0080        	ldw	x,#128
3017  0150 a613          	ld	a,#19
3018  0152 95            	ld	xh,a
3019  0153 cd0398        	call	_SetBitMask
3021                     ; 103 		ucComMF522Buf[0] = 0xCA;
3023  0156 a6ca          	ld	a,#202
3024  0158 6b04          	ld	(OFST-64,sp),a
3025                     ; 104 		ucComMF522Buf[1] = 0x00;
3027  015a 0f05          	clr	(OFST-63,sp)
3028                     ; 105 		status = PcdComMF522_P(PCD_TRANSCEIVE,ucComMF522Buf,2,ucComMF522Buf,&unLen,0x00F0);
3030  015c ae00f0        	ldw	x,#240
3031  015f 89            	pushw	x
3032  0160 96            	ldw	x,sp
3033  0161 1c0003        	addw	x,#OFST-65
3034  0164 89            	pushw	x
3035  0165 96            	ldw	x,sp
3036  0166 1c0008        	addw	x,#OFST-60
3037  0169 89            	pushw	x
3038  016a 4b02          	push	#2
3039  016c 96            	ldw	x,sp
3040  016d 1c000b        	addw	x,#OFST-57
3041  0170 89            	pushw	x
3042  0171 a60c          	ld	a,#12
3043  0173 cd03c1        	call	_PcdComMF522_P
3045  0176 5b09          	addw	sp,#9
3046                     ; 107 		status = ReadRawRC(Status2Reg);	//90 00(01,05)
3048  0178 a608          	ld	a,#8
3049  017a cd0341        	call	_ReadRawRC
3051  017d 6b44          	ld	(OFST+0,sp),a
3052                     ; 108 		WriteRawRC(Status2Reg,status&0xf7);	//10 00
3054  017f 7b44          	ld	a,(OFST+0,sp)
3055  0181 a4f7          	and	a,#247
3056  0183 97            	ld	xl,a
3057  0184 a608          	ld	a,#8
3058  0186 95            	ld	xh,a
3059  0187 cd036e        	call	_WriteRawRC
3061                     ; 109 		WriteRawRC(CollReg,0x80);		//1c 80
3063  018a ae0080        	ldw	x,#128
3064  018d a60e          	ld	a,#14
3065  018f 95            	ld	xh,a
3066  0190 cd036e        	call	_WriteRawRC
3068                     ; 111 		ClearBitMask(TxModeReg,0x80);	//a4 80 24 00
3070  0193 ae0080        	ldw	x,#128
3071  0196 a612          	ld	a,#18
3072  0198 95            	ld	xh,a
3073  0199 cd03ac        	call	_ClearBitMask
3075                     ; 112 		ClearBitMask(RxModeReg,0x80);	//a6 00 26 00
3077  019c ae0080        	ldw	x,#128
3078  019f a613          	ld	a,#19
3079  01a1 95            	ld	xh,a
3080  01a2 cd03ac        	call	_ClearBitMask
3082                     ; 113 		WriteRawRC(BitFramingReg,0x07);	//1a 07
3084  01a5 ae0007        	ldw	x,#7
3085  01a8 a60d          	ld	a,#13
3086  01aa 95            	ld	xh,a
3087  01ab cd036e        	call	_WriteRawRC
3089                     ; 115 		SetBitMask(TxControlReg,0x03);//a8 83 28 83
3091  01ae ae0003        	ldw	x,#3
3092  01b1 a614          	ld	a,#20
3093  01b3 95            	ld	xh,a
3094  01b4 cd0398        	call	_SetBitMask
3096                     ; 117 		ucComMF522Buf[0] = req_code;
3098  01b7 7b45          	ld	a,(OFST+1,sp)
3099  01b9 6b04          	ld	(OFST-64,sp),a
3100                     ; 118 		status = PcdComMF522_P(PCD_TRANSCEIVE,ucComMF522Buf,1,ucComMF522Buf,&unLen,0x0002);
3102  01bb ae0002        	ldw	x,#2
3103  01be 89            	pushw	x
3104  01bf 96            	ldw	x,sp
3105  01c0 1c0003        	addw	x,#OFST-65
3106  01c3 89            	pushw	x
3107  01c4 96            	ldw	x,sp
3108  01c5 1c0008        	addw	x,#OFST-60
3109  01c8 89            	pushw	x
3110  01c9 4b01          	push	#1
3111  01cb 96            	ldw	x,sp
3112  01cc 1c000b        	addw	x,#OFST-57
3113  01cf 89            	pushw	x
3114  01d0 a60c          	ld	a,#12
3115  01d2 cd03c1        	call	_PcdComMF522_P
3117  01d5 5b09          	addw	sp,#9
3118  01d7 6b44          	ld	(OFST+0,sp),a
3119                     ; 119 		if(status == 0)
3121  01d9 0d44          	tnz	(OFST+0,sp)
3122  01db 2602          	jrne	L3002
3123                     ; 120 			fHasRATS = 0;
3125  01dd 3f00          	clr	_fHasRATS
3126  01df               L3002:
3127                     ; 122 	if ((status == MI_OK) && (unLen == 0x10))
3129  01df 0d44          	tnz	(OFST+0,sp)
3130  01e1 2614          	jrne	L7002
3132  01e3 1e01          	ldw	x,(OFST-67,sp)
3133  01e5 a30010        	cpw	x,#16
3134  01e8 260d          	jrne	L7002
3135                     ; 124        *pTagType     = ucComMF522Buf[0];
3137  01ea 7b04          	ld	a,(OFST-64,sp)
3138  01ec 1e48          	ldw	x,(OFST+4,sp)
3139  01ee f7            	ld	(x),a
3140                     ; 125        *(pTagType+1) = ucComMF522Buf[1];
3142  01ef 7b05          	ld	a,(OFST-63,sp)
3143  01f1 1e48          	ldw	x,(OFST+4,sp)
3144  01f3 e701          	ld	(1,x),a
3146  01f5 2004          	jra	L1102
3147  01f7               L7002:
3148                     ; 129      status = MI_ERR;  
3150  01f7 a602          	ld	a,#2
3151  01f9 6b44          	ld	(OFST+0,sp),a
3152  01fb               L1102:
3153                     ; 131 	return status;
3155  01fb 7b44          	ld	a,(OFST+0,sp)
3158  01fd 5b45          	addw	sp,#69
3159  01ff 81            	ret
3244                     ; 139 unsigned char PcdAnticoll(unsigned char *pSnr)
3244                     ; 140 {
3245                     	switch	.text
3246  0200               _PcdAnticoll:
3248  0200 89            	pushw	x
3249  0201 5245          	subw	sp,#69
3250       00000045      OFST:	set	69
3253                     ; 146 	unsigned char  snr_check=0;    
3255  0203 0f04          	clr	(OFST-65,sp)
3256                     ; 149         ClearBitMask(TxModeReg,0x80);//a4 00 24 00
3258  0205 ae0080        	ldw	x,#128
3259  0208 a612          	ld	a,#18
3260  020a 95            	ld	xh,a
3261  020b cd03ac        	call	_ClearBitMask
3263                     ; 150 	ClearBitMask(RxModeReg,0x80);//a6 00 26 00
3265  020e ae0080        	ldw	x,#128
3266  0211 a613          	ld	a,#19
3267  0213 95            	ld	xh,a
3268  0214 cd03ac        	call	_ClearBitMask
3270                     ; 151 	WriteRawRC(CollReg,0x00);	//1c 00
3272  0217 5f            	clrw	x
3273  0218 a60e          	ld	a,#14
3274  021a 95            	ld	xh,a
3275  021b cd036e        	call	_WriteRawRC
3277                     ; 152 	delayms(1);
3279  021e ae0001        	ldw	x,#1
3280  0221 cd0000        	call	_delayms
3282                     ; 153 	WriteRawRC(BitFramingReg,0x00);//1a 00
3284  0224 5f            	clrw	x
3285  0225 a60d          	ld	a,#13
3286  0227 95            	ld	xh,a
3287  0228 cd036e        	call	_WriteRawRC
3289                     ; 154 	ucComMF522Buf[0] = PICC_ANTICOLL1;
3291  022b a693          	ld	a,#147
3292  022d 6b05          	ld	(OFST-64,sp),a
3293                     ; 155         ucComMF522Buf[1] = 0x20;
3295  022f a620          	ld	a,#32
3296  0231 6b06          	ld	(OFST-63,sp),a
3297                     ; 156 	status = PcdComMF522_P(PCD_TRANSCEIVE,ucComMF522Buf,2,ucComMF522Buf,&unLen,0x0020);
3299  0233 ae0020        	ldw	x,#32
3300  0236 89            	pushw	x
3301  0237 96            	ldw	x,sp
3302  0238 1c0003        	addw	x,#OFST-66
3303  023b 89            	pushw	x
3304  023c 96            	ldw	x,sp
3305  023d 1c0009        	addw	x,#OFST-60
3306  0240 89            	pushw	x
3307  0241 4b02          	push	#2
3308  0243 96            	ldw	x,sp
3309  0244 1c000c        	addw	x,#OFST-57
3310  0247 89            	pushw	x
3311  0248 a60c          	ld	a,#12
3312  024a cd03c1        	call	_PcdComMF522_P
3314  024d 5b09          	addw	sp,#9
3315  024f 6b03          	ld	(OFST-66,sp),a
3316                     ; 157 	delayms(1);
3318  0251 ae0001        	ldw	x,#1
3319  0254 cd0000        	call	_delayms
3321                     ; 158 	WriteRawRC(BitFramingReg,0x00);//1a 00
3323  0257 5f            	clrw	x
3324  0258 a60d          	ld	a,#13
3325  025a 95            	ld	xh,a
3326  025b cd036e        	call	_WriteRawRC
3328                     ; 159 	WriteRawRC(CollReg,0x80);//1c 80 
3330  025e ae0080        	ldw	x,#128
3331  0261 a60e          	ld	a,#14
3332  0263 95            	ld	xh,a
3333  0264 cd036e        	call	_WriteRawRC
3335                     ; 161 	if (status == MI_OK)
3337  0267 0d03          	tnz	(OFST-66,sp)
3338  0269 264b          	jrne	L5502
3339                     ; 164     	 for (i=0; i<4; i++)
3341  026b 0f45          	clr	(OFST+0,sp)
3342  026d               L7502:
3343                     ; 166              *(pSnr+i)  = ucComMF522Buf[i];
3345  026d 7b46          	ld	a,(OFST+1,sp)
3346  026f 97            	ld	xl,a
3347  0270 7b47          	ld	a,(OFST+2,sp)
3348  0272 1b45          	add	a,(OFST+0,sp)
3349  0274 2401          	jrnc	L61
3350  0276 5c            	incw	x
3351  0277               L61:
3352  0277 02            	rlwa	x,a
3353  0278 89            	pushw	x
3354  0279 96            	ldw	x,sp
3355  027a 1c0007        	addw	x,#OFST-62
3356  027d 9f            	ld	a,xl
3357  027e 5e            	swapw	x
3358  027f 1b47          	add	a,(OFST+2,sp)
3359  0281 2401          	jrnc	L02
3360  0283 5c            	incw	x
3361  0284               L02:
3362  0284 02            	rlwa	x,a
3363  0285 f6            	ld	a,(x)
3364  0286 85            	popw	x
3365  0287 f7            	ld	(x),a
3366                     ; 167              snr_check ^= ucComMF522Buf[i];
3368  0288 96            	ldw	x,sp
3369  0289 1c0005        	addw	x,#OFST-64
3370  028c 9f            	ld	a,xl
3371  028d 5e            	swapw	x
3372  028e 1b45          	add	a,(OFST+0,sp)
3373  0290 2401          	jrnc	L22
3374  0292 5c            	incw	x
3375  0293               L22:
3376  0293 02            	rlwa	x,a
3377  0294 7b04          	ld	a,(OFST-65,sp)
3378  0296 f8            	xor	a,	(x)
3379  0297 6b04          	ld	(OFST-65,sp),a
3380                     ; 164     	 for (i=0; i<4; i++)
3382  0299 0c45          	inc	(OFST+0,sp)
3385  029b 7b45          	ld	a,(OFST+0,sp)
3386  029d a104          	cp	a,#4
3387  029f 25cc          	jrult	L7502
3388                     ; 169          if (snr_check != ucComMF522Buf[i])
3390  02a1 96            	ldw	x,sp
3391  02a2 1c0005        	addw	x,#OFST-64
3392  02a5 9f            	ld	a,xl
3393  02a6 5e            	swapw	x
3394  02a7 1b45          	add	a,(OFST+0,sp)
3395  02a9 2401          	jrnc	L42
3396  02ab 5c            	incw	x
3397  02ac               L42:
3398  02ac 02            	rlwa	x,a
3399  02ad f6            	ld	a,(x)
3400  02ae 1104          	cp	a,(OFST-65,sp)
3401  02b0 2704          	jreq	L5502
3402                     ; 171            status = MI_ERR;   
3404  02b2 a602          	ld	a,#2
3405  02b4 6b03          	ld	(OFST-66,sp),a
3406  02b6               L5502:
3407                     ; 175 	return status;
3409  02b6 7b03          	ld	a,(OFST-66,sp)
3412  02b8 5b47          	addw	sp,#71
3413  02ba 81            	ret
3487                     ; 184 unsigned char PcdSelect(unsigned char *pSnr)
3487                     ; 185 {
3488                     	switch	.text
3489  02bb               _PcdSelect:
3491  02bb 89            	pushw	x
3492  02bc 5243          	subw	sp,#67
3493       00000043      OFST:	set	67
3496                     ; 208 	SetBitMask(TxModeReg,0x80);//a4 80 24 80
3498  02be ae0080        	ldw	x,#128
3499  02c1 a612          	ld	a,#18
3500  02c3 95            	ld	xh,a
3501  02c4 cd0398        	call	_SetBitMask
3503                     ; 209 	SetBitMask(RxModeReg,0x80);//a6 00 26 80
3505  02c7 ae0080        	ldw	x,#128
3506  02ca a613          	ld	a,#19
3507  02cc 95            	ld	xh,a
3508  02cd cd0398        	call	_SetBitMask
3510                     ; 210 	ucComMF522Buf[0] = PICC_ANTICOLL1;
3512  02d0 a693          	ld	a,#147
3513  02d2 6b03          	ld	(OFST-64,sp),a
3514                     ; 211     ucComMF522Buf[1] = 0x70;
3516  02d4 a670          	ld	a,#112
3517  02d6 6b04          	ld	(OFST-63,sp),a
3518                     ; 212 	ucComMF522Buf[6] = 0;
3520  02d8 0f09          	clr	(OFST-58,sp)
3521                     ; 213 	for (i=0; i<4; i++)
3523  02da 0f43          	clr	(OFST+0,sp)
3524  02dc               L5212:
3525                     ; 215     	ucComMF522Buf[i+2] = *(pSnr+i);
3527  02dc 96            	ldw	x,sp
3528  02dd 1c0005        	addw	x,#OFST-62
3529  02e0 9f            	ld	a,xl
3530  02e1 5e            	swapw	x
3531  02e2 1b43          	add	a,(OFST+0,sp)
3532  02e4 2401          	jrnc	L03
3533  02e6 5c            	incw	x
3534  02e7               L03:
3535  02e7 02            	rlwa	x,a
3536  02e8 89            	pushw	x
3537  02e9 7b46          	ld	a,(OFST+3,sp)
3538  02eb 97            	ld	xl,a
3539  02ec 7b47          	ld	a,(OFST+4,sp)
3540  02ee 1b45          	add	a,(OFST+2,sp)
3541  02f0 2401          	jrnc	L23
3542  02f2 5c            	incw	x
3543  02f3               L23:
3544  02f3 02            	rlwa	x,a
3545  02f4 f6            	ld	a,(x)
3546  02f5 85            	popw	x
3547  02f6 f7            	ld	(x),a
3548                     ; 216 		ucComMF522Buf[6]  ^= *(pSnr+i);
3550  02f7 7b44          	ld	a,(OFST+1,sp)
3551  02f9 97            	ld	xl,a
3552  02fa 7b45          	ld	a,(OFST+2,sp)
3553  02fc 1b43          	add	a,(OFST+0,sp)
3554  02fe 2401          	jrnc	L43
3555  0300 5c            	incw	x
3556  0301               L43:
3557  0301 02            	rlwa	x,a
3558  0302 7b09          	ld	a,(OFST-58,sp)
3559  0304 f8            	xor	a,	(x)
3560  0305 6b09          	ld	(OFST-58,sp),a
3561                     ; 213 	for (i=0; i<4; i++)
3563  0307 0c43          	inc	(OFST+0,sp)
3566  0309 7b43          	ld	a,(OFST+0,sp)
3567  030b a104          	cp	a,#4
3568  030d 25cd          	jrult	L5212
3569                     ; 218 	status = PcdComMF522_P(PCD_TRANSCEIVE,ucComMF522Buf,7,ucComMF522Buf,&unLen,0x0010);
3571  030f ae0010        	ldw	x,#16
3572  0312 89            	pushw	x
3573  0313 96            	ldw	x,sp
3574  0314 1c0003        	addw	x,#OFST-64
3575  0317 89            	pushw	x
3576  0318 96            	ldw	x,sp
3577  0319 1c0007        	addw	x,#OFST-60
3578  031c 89            	pushw	x
3579  031d 4b07          	push	#7
3580  031f 96            	ldw	x,sp
3581  0320 1c000a        	addw	x,#OFST-57
3582  0323 89            	pushw	x
3583  0324 a60c          	ld	a,#12
3584  0326 cd03c1        	call	_PcdComMF522_P
3586  0329 5b09          	addw	sp,#9
3587  032b 6b43          	ld	(OFST+0,sp),a
3588                     ; 219 	if ((status == MI_OK))//&& (unLen == 0x18))
3590  032d 0d43          	tnz	(OFST+0,sp)
3591  032f 2607          	jrne	L3312
3592                     ; 221       pSnr[0] = ucComMF522Buf[0];
3594  0331 7b03          	ld	a,(OFST-64,sp)
3595  0333 1e44          	ldw	x,(OFST+1,sp)
3596  0335 f7            	ld	(x),a
3598  0336 2004          	jra	L5312
3599  0338               L3312:
3600                     ; 225       status = MI_ERR;    
3602  0338 a602          	ld	a,#2
3603  033a 6b43          	ld	(OFST+0,sp),a
3604  033c               L5312:
3605                     ; 227 	return status; 
3607  033c 7b43          	ld	a,(OFST+0,sp)
3610  033e 5b45          	addw	sp,#69
3611  0340 81            	ret
3667                     ; 236 unsigned char ReadRawRC(unsigned char Address)//Kevin modify
3667                     ; 237 {
3668                     	switch	.text
3669  0341               _ReadRawRC:
3671  0341 88            	push	a
3672       00000001      OFST:	set	1
3675                     ; 241    ucAddr = ((Address<<1)&0x7E)|0x80;
3677  0342 48            	sll	a
3678  0343 a47e          	and	a,#126
3679  0345 aa80          	or	a,#128
3680  0347 6b01          	ld	(OFST+0,sp),a
3681                     ; 242   PC_ODR&=0xEF;
3683  0349 7219500a      	bres	_PC_ODR,#4
3684                     ; 243  delayms(1);  
3686  034d ae0001        	ldw	x,#1
3687  0350 cd0000        	call	_delayms
3690  0353               L7612:
3691                     ; 245   while(SPI_flag);         //wait send complete
3693  0353 c65203        	ld	a,_SPI_SR
3694  0356 a580          	bcp	a,#128
3695  0358 26f9          	jrne	L7612
3696                     ; 246   SPI_RW(ucAddr);             //write reg
3698  035a 7b01          	ld	a,(OFST+0,sp)
3699  035c cd0000        	call	_SPI_RW
3701                     ; 247   ucResult = SPI_RW(0);       //read  reg
3703  035f 4f            	clr	a
3704  0360 cd0000        	call	_SPI_RW
3706  0363 6b01          	ld	(OFST+0,sp),a
3707                     ; 249   PC_ODR|=(1<<4);
3709  0365 7218500a      	bset	_PC_ODR,#4
3710                     ; 251   return ucResult;
3712  0369 7b01          	ld	a,(OFST+0,sp)
3715  036b 5b01          	addw	sp,#1
3716  036d 81            	ret
3772                     ; 260 void WriteRawRC(unsigned char Address, unsigned char value)//Kevin modify
3772                     ; 261 {
3773                     	switch	.text
3774  036e               _WriteRawRC:
3776  036e 89            	pushw	x
3777  036f 88            	push	a
3778       00000001      OFST:	set	1
3781                     ; 264    ucAddr = ((Address<<1)&0x7E);
3783  0370 9e            	ld	a,xh
3784  0371 48            	sll	a
3785  0372 a47e          	and	a,#126
3786  0374 6b01          	ld	(OFST+0,sp),a
3787                     ; 265    PC_ODR&=0xEF;                          // drive NSS low 
3789  0376 7219500a      	bres	_PC_ODR,#4
3790                     ; 266    delayms(1);
3792  037a ae0001        	ldw	x,#1
3793  037d cd0000        	call	_delayms
3796  0380               L3222:
3797                     ; 267    while (SPI_flag );   //wait send complete 
3799  0380 c65203        	ld	a,_SPI_SR
3800  0383 a580          	bcp	a,#128
3801  0385 26f9          	jrne	L3222
3802                     ; 268    SPI_RW(ucAddr);             // write reg address
3804  0387 7b01          	ld	a,(OFST+0,sp)
3805  0389 cd0000        	call	_SPI_RW
3807                     ; 270    SPI_RW(value);                    // write value     
3809  038c 7b03          	ld	a,(OFST+2,sp)
3810  038e cd0000        	call	_SPI_RW
3812                     ; 271     PC_ODR|=(1<<4);                          // drive NSS high
3814  0391 7218500a      	bset	_PC_ODR,#4
3815                     ; 272 }
3818  0395 5b03          	addw	sp,#3
3819  0397 81            	ret
3873                     ; 280 void SetBitMask(unsigned char reg,unsigned char mask)  
3873                     ; 281 {
3874                     	switch	.text
3875  0398               _SetBitMask:
3877  0398 89            	pushw	x
3878  0399 88            	push	a
3879       00000001      OFST:	set	1
3882                     ; 282     unsigned char  tmp = 0x0;
3884                     ; 283     tmp = ReadRawRC(reg);
3886  039a 9e            	ld	a,xh
3887  039b ada4          	call	_ReadRawRC
3889  039d 6b01          	ld	(OFST+0,sp),a
3890                     ; 284     WriteRawRC(reg,tmp | mask);  // set bit mask
3892  039f 7b01          	ld	a,(OFST+0,sp)
3893  03a1 1a03          	or	a,(OFST+2,sp)
3894  03a3 97            	ld	xl,a
3895  03a4 7b02          	ld	a,(OFST+1,sp)
3896  03a6 95            	ld	xh,a
3897  03a7 adc5          	call	_WriteRawRC
3899                     ; 285 }
3902  03a9 5b03          	addw	sp,#3
3903  03ab 81            	ret
3957                     ; 292 void ClearBitMask(unsigned char reg,unsigned char mask)  
3957                     ; 293 {
3958                     	switch	.text
3959  03ac               _ClearBitMask:
3961  03ac 89            	pushw	x
3962  03ad 88            	push	a
3963       00000001      OFST:	set	1
3966                     ; 294     unsigned char  tmp = 0x0;
3968                     ; 295     tmp = ReadRawRC(reg);
3970  03ae 9e            	ld	a,xh
3971  03af ad90          	call	_ReadRawRC
3973  03b1 6b01          	ld	(OFST+0,sp),a
3974                     ; 296     WriteRawRC(reg, tmp & ~mask);  // clear bit mask
3976  03b3 7b03          	ld	a,(OFST+2,sp)
3977  03b5 43            	cpl	a
3978  03b6 1401          	and	a,(OFST+0,sp)
3979  03b8 97            	ld	xl,a
3980  03b9 7b02          	ld	a,(OFST+1,sp)
3981  03bb 95            	ld	xh,a
3982  03bc adb0          	call	_WriteRawRC
3984                     ; 297 } 
3987  03be 5b03          	addw	sp,#3
3988  03c0 81            	ret
4111                     ; 300 unsigned char PcdComMF522_P(unsigned char Command, 
4111                     ; 301                  unsigned char *pInData, 
4111                     ; 302                  unsigned char InLenByte,
4111                     ; 303                  unsigned char *pOutData, 
4111                     ; 304                  unsigned int  *pOutLenBit,unsigned short TimeOut)
4111                     ; 305 {
4112                     	switch	.text
4113  03c1               _PcdComMF522_P:
4115  03c1 88            	push	a
4116  03c2 5205          	subw	sp,#5
4117       00000005      OFST:	set	5
4120                     ; 310 	delayms(1);
4122  03c4 ae0001        	ldw	x,#1
4123  03c7 cd0000        	call	_delayms
4125                     ; 311 	WriteRawRC(TPrescalerReg,0xFF);//56 ff
4127  03ca ae00ff        	ldw	x,#255
4128  03cd a62b          	ld	a,#43
4129  03cf 95            	ld	xh,a
4130  03d0 ad9c          	call	_WriteRawRC
4132                     ; 312 	WriteRawRC(TModeReg,0x87);		//54 87
4134  03d2 ae0087        	ldw	x,#135
4135  03d5 a62a          	ld	a,#42
4136  03d7 95            	ld	xh,a
4137  03d8 ad94          	call	_WriteRawRC
4139                     ; 313 	WriteRawRC(TReloadRegL,(unsigned char)TimeOut); //5a 02
4141  03da 7b11          	ld	a,(OFST+12,sp)
4142  03dc 97            	ld	xl,a
4143  03dd a62d          	ld	a,#45
4144  03df 95            	ld	xh,a
4145  03e0 ad8c          	call	_WriteRawRC
4147                     ; 314 	WriteRawRC(TReloadRegH,(unsigned char)(TimeOut>>8));//58 00
4149  03e2 7b10          	ld	a,(OFST+11,sp)
4150  03e4 97            	ld	xl,a
4151  03e5 a62c          	ld	a,#44
4152  03e7 95            	ld	xh,a
4153  03e8 ad84          	call	_WriteRawRC
4155                     ; 316 	delayms(1);
4157  03ea ae0001        	ldw	x,#1
4158  03ed cd0000        	call	_delayms
4160                     ; 318 	WriteRawRC(ComIrqReg,0x7F);//08 7f
4162  03f0 ae007f        	ldw	x,#127
4163  03f3 a604          	ld	a,#4
4164  03f5 95            	ld	xh,a
4165  03f6 cd036e        	call	_WriteRawRC
4167                     ; 319 	WriteRawRC(DivIrqReg,0x7F);//0a 7f
4169  03f9 ae007f        	ldw	x,#127
4170  03fc a605          	ld	a,#5
4171  03fe 95            	ld	xh,a
4172  03ff cd036e        	call	_WriteRawRC
4174                     ; 320 	WriteRawRC(FIFOLevelReg,0x80);//14 80
4176  0402 ae0080        	ldw	x,#128
4177  0405 a60a          	ld	a,#10
4178  0407 95            	ld	xh,a
4179  0408 cd036e        	call	_WriteRawRC
4181                     ; 322 	SetBitMask(CommandReg,Command);//82 0c 02 0c
4183  040b 7b06          	ld	a,(OFST+1,sp)
4184  040d 97            	ld	xl,a
4185  040e a601          	ld	a,#1
4186  0410 95            	ld	xh,a
4187  0411 ad85          	call	_SetBitMask
4189                     ; 323 	delayms(1);
4191  0413 ae0001        	ldw	x,#1
4192  0416 cd0000        	call	_delayms
4194                     ; 324 	SetBitMask(ComIEnReg,0xA1);		//84 80 04 a1
4196  0419 ae00a1        	ldw	x,#161
4197  041c a602          	ld	a,#2
4198  041e 95            	ld	xh,a
4199  041f cd0398        	call	_SetBitMask
4201                     ; 325 	SetBitMask(DivlEnReg,0x00);		//86 00 06 00
4203  0422 5f            	clrw	x
4204  0423 a603          	ld	a,#3
4205  0425 95            	ld	xh,a
4206  0426 cd0398        	call	_SetBitMask
4208                     ; 327 	for(n=0;n<InLenByte;n++)		//12 52
4210  0429 0f05          	clr	(OFST+0,sp)
4212  042b 2015          	jra	L1732
4213  042d               L5632:
4214                     ; 328 		WriteRawRC(FIFODataReg,pInData[n]);
4216  042d 7b09          	ld	a,(OFST+4,sp)
4217  042f 97            	ld	xl,a
4218  0430 7b0a          	ld	a,(OFST+5,sp)
4219  0432 1b05          	add	a,(OFST+0,sp)
4220  0434 2401          	jrnc	L05
4221  0436 5c            	incw	x
4222  0437               L05:
4223  0437 02            	rlwa	x,a
4224  0438 f6            	ld	a,(x)
4225  0439 97            	ld	xl,a
4226  043a a609          	ld	a,#9
4227  043c 95            	ld	xh,a
4228  043d cd036e        	call	_WriteRawRC
4230                     ; 327 	for(n=0;n<InLenByte;n++)		//12 52
4232  0440 0c05          	inc	(OFST+0,sp)
4233  0442               L1732:
4236  0442 7b05          	ld	a,(OFST+0,sp)
4237  0444 110b          	cp	a,(OFST+6,sp)
4238  0446 25e5          	jrult	L5632
4239                     ; 333 	SetBitMask(BitFramingReg,0x80);//9a 07 1a 87
4241  0448 ae0080        	ldw	x,#128
4242  044b a60d          	ld	a,#13
4243  044d 95            	ld	xh,a
4244  044e cd0398        	call	_SetBitMask
4246  0451               L5732:
4247                     ; 346 		n = ReadRawRC(ComIrqReg);//88 04(44,45(超时),64(正常))
4249  0451 a604          	ld	a,#4
4250  0453 cd0341        	call	_ReadRawRC
4252  0456 6b05          	ld	(OFST+0,sp),a
4253                     ; 347 		status = ReadRawRC(DivIrqReg);//8a 00
4255  0458 a605          	ld	a,#5
4256  045a cd0341        	call	_ReadRawRC
4258                     ; 348 		if(n & 0x20)
4260  045d 7b05          	ld	a,(OFST+0,sp)
4261  045f a520          	bcp	a,#32
4262  0461 2606          	jrne	L7732
4263                     ; 349 			break;
4265                     ; 350 		if(n & 0x01)
4267  0463 7b05          	ld	a,(OFST+0,sp)
4268  0465 a501          	bcp	a,#1
4269  0467 27e8          	jreq	L5732
4270                     ; 351 			break;
4271  0469               L7732:
4272                     ; 353 	if(!(n&0x01))
4274  0469 7b05          	ld	a,(OFST+0,sp)
4275  046b a501          	bcp	a,#1
4276  046d 2666          	jrne	L5042
4277                     ; 355 		SetBitMask(ControlReg,0x90);//98 10 18 90
4279  046f ae0090        	ldw	x,#144
4280  0472 a60c          	ld	a,#12
4281  0474 95            	ld	xh,a
4282  0475 cd0398        	call	_SetBitMask
4284                     ; 356 		ClearBitMask(ComIEnReg,0x7F);//84 a1 04 80
4286  0478 ae007f        	ldw	x,#127
4287  047b a602          	ld	a,#2
4288  047d 95            	ld	xh,a
4289  047e cd03ac        	call	_ClearBitMask
4291                     ; 357 		ClearBitMask(DivlEnReg,0xFF);//86 00 06 00
4293  0481 ae00ff        	ldw	x,#255
4294  0484 a603          	ld	a,#3
4295  0486 95            	ld	xh,a
4296  0487 cd03ac        	call	_ClearBitMask
4298                     ; 358 		n = ReadRawRC(FIFOLevelReg);//94 02 
4300  048a a60a          	ld	a,#10
4301  048c cd0341        	call	_ReadRawRC
4303  048f 6b05          	ld	(OFST+0,sp),a
4304                     ; 359 		lastBits = ReadRawRC(ControlReg) ;//98 10
4306  0491 a60c          	ld	a,#12
4307  0493 cd0341        	call	_ReadRawRC
4309                     ; 364 		status = ReadRawRC(ErrorReg);//8c 00
4311  0496 a606          	ld	a,#6
4312  0498 cd0341        	call	_ReadRawRC
4314  049b 6b02          	ld	(OFST-3,sp),a
4315                     ; 366                 for (i=0; i<n; i++)
4317  049d 5f            	clrw	x
4318  049e 1f03          	ldw	(OFST-2,sp),x
4320  04a0 2012          	jra	L3142
4321  04a2               L7042:
4322                     ; 367                 {   pOutData[i] = ReadRawRC(FIFODataReg);    }
4324  04a2 a609          	ld	a,#9
4325  04a4 cd0341        	call	_ReadRawRC
4327  04a7 1e0c          	ldw	x,(OFST+7,sp)
4328  04a9 72fb03        	addw	x,(OFST-2,sp)
4329  04ac f7            	ld	(x),a
4330                     ; 366                 for (i=0; i<n; i++)
4332  04ad 1e03          	ldw	x,(OFST-2,sp)
4333  04af 1c0001        	addw	x,#1
4334  04b2 1f03          	ldw	(OFST-2,sp),x
4335  04b4               L3142:
4338  04b4 7b05          	ld	a,(OFST+0,sp)
4339  04b6 5f            	clrw	x
4340  04b7 97            	ld	xl,a
4341  04b8 bf00          	ldw	c_x,x
4342  04ba 1e03          	ldw	x,(OFST-2,sp)
4343  04bc b300          	cpw	x,c_x
4344  04be 25e2          	jrult	L7042
4345                     ; 368 		*pOutLenBit = n*8;
4347  04c0 7b05          	ld	a,(OFST+0,sp)
4348  04c2 97            	ld	xl,a
4349  04c3 a608          	ld	a,#8
4350  04c5 42            	mul	x,a
4351  04c6 160e          	ldw	y,(OFST+9,sp)
4352  04c8 90ff          	ldw	(y),x
4353                     ; 370 		WriteRawRC(ComIrqReg,0x20);//08 20
4355  04ca ae0020        	ldw	x,#32
4356  04cd a604          	ld	a,#4
4357  04cf 95            	ld	xh,a
4358  04d0 cd036e        	call	_WriteRawRC
4361  04d3 2032          	jra	L7142
4362  04d5               L5042:
4363                     ; 374 		ClearBitMask(ComIEnReg,0x7F);//84 a1 04 80
4365  04d5 ae007f        	ldw	x,#127
4366  04d8 a602          	ld	a,#2
4367  04da 95            	ld	xh,a
4368  04db cd03ac        	call	_ClearBitMask
4370                     ; 375 		ClearBitMask(DivlEnReg,0xFF);//86 00 06 00
4372  04de ae00ff        	ldw	x,#255
4373  04e1 a603          	ld	a,#3
4374  04e3 95            	ld	xh,a
4375  04e4 cd03ac        	call	_ClearBitMask
4377                     ; 376 		if(pInData[0] == PICC_HALT)
4379  04e7 1e09          	ldw	x,(OFST+4,sp)
4380  04e9 f6            	ld	a,(x)
4381  04ea a150          	cp	a,#80
4382  04ec 260c          	jrne	L1242
4383                     ; 378 			ClearBitMask(ComIrqReg,0xFF);//86 00 06 00
4385  04ee ae00ff        	ldw	x,#255
4386  04f1 a604          	ld	a,#4
4387  04f3 95            	ld	xh,a
4388  04f4 cd03ac        	call	_ClearBitMask
4390                     ; 379 			return 0;	
4392  04f7 4f            	clr	a
4394  04f8 202f          	jra	L25
4395  04fa               L1242:
4396                     ; 381 		WriteRawRC(ComIrqReg,0x01);//08 01
4398  04fa ae0001        	ldw	x,#1
4399  04fd a604          	ld	a,#4
4400  04ff 95            	ld	xh,a
4401  0500 cd036e        	call	_WriteRawRC
4403                     ; 382 		status = MI_TIMEOUT;
4405  0503 a604          	ld	a,#4
4406  0505 6b02          	ld	(OFST-3,sp),a
4407  0507               L7142:
4408                     ; 385 	WriteRawRC(DivIrqReg,0x00);//0a 00
4410  0507 5f            	clrw	x
4411  0508 a605          	ld	a,#5
4412  050a 95            	ld	xh,a
4413  050b cd036e        	call	_WriteRawRC
4415                     ; 386 	WriteRawRC(FIFOLevelReg,0x80);//14 80
4417  050e ae0080        	ldw	x,#128
4418  0511 a60a          	ld	a,#10
4419  0513 95            	ld	xh,a
4420  0514 cd036e        	call	_WriteRawRC
4422                     ; 387 	WriteRawRC(ComIrqReg,0x01);//08 01
4424  0517 ae0001        	ldw	x,#1
4425  051a a604          	ld	a,#4
4426  051c 95            	ld	xh,a
4427  051d cd036e        	call	_WriteRawRC
4429                     ; 388 	WriteRawRC(BitFramingReg,0x00);//1a 00
4431  0520 5f            	clrw	x
4432  0521 a60d          	ld	a,#13
4433  0523 95            	ld	xh,a
4434  0524 cd036e        	call	_WriteRawRC
4436                     ; 389 	return status;
4438  0527 7b02          	ld	a,(OFST-3,sp)
4440  0529               L25:
4442  0529 5b06          	addw	sp,#6
4443  052b 81            	ret
4468                     ; 397 void PcdAntennaOn()
4468                     ; 398 {
4469                     	switch	.text
4470  052c               _PcdAntennaOn:
4474                     ; 404         SetBitMask(TxControlReg, 0x03);
4476  052c ae0003        	ldw	x,#3
4477  052f a614          	ld	a,#20
4478  0531 95            	ld	xh,a
4479  0532 cd0398        	call	_SetBitMask
4481                     ; 405         delayms(1);
4483  0535 ae0001        	ldw	x,#1
4484  0538 cd0000        	call	_delayms
4486                     ; 408 }
4489  053b 81            	ret
4514                     ; 414 void PcdAntennaOff()
4514                     ; 415 {
4515                     	switch	.text
4516  053c               _PcdAntennaOff:
4520                     ; 416     ClearBitMask(TxControlReg, 0x03);
4522  053c ae0003        	ldw	x,#3
4523  053f a614          	ld	a,#20
4524  0541 95            	ld	xh,a
4525  0542 cd03ac        	call	_ClearBitMask
4527                     ; 417     delayms(1);
4529  0545 ae0001        	ldw	x,#1
4530  0548 cd0000        	call	_delayms
4532                     ; 418 }
4535  054b 81            	ret
4559                     	xdef	_fHasRATS
4560                     	xdef	_SPI_RW
4561                     	xref	_delayms
4562                     	xdef	_ClearBitMask
4563                     	xdef	_SetBitMask
4564                     	xdef	_ReadRawRC
4565                     	xdef	_WriteRawRC
4566                     	xdef	_PcdComMF522_P
4567                     	xdef	_PcdSelect
4568                     	xdef	_PcdAnticoll
4569                     	xdef	_PcdRequest
4570                     	xdef	_PcdAntennaOff
4571                     	xdef	_PcdAntennaOn
4572                     	xdef	_RC522_Init
4573                     	xref.b	c_x
4592                     	end
