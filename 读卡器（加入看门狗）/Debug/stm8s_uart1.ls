   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  43                     ; 47 void UART1_DeInit(void)
  43                     ; 48 {
  45                     	switch	.text
  46  0000               _UART1_DeInit:
  48  0000 88            	push	a
  49       00000001      OFST:	set	1
  52                     ; 49     u8 dummy = 0;
  54  0001 0f01          	clr	(OFST+0,sp)
  55                     ; 53     dummy = UART1->SR;
  57  0003 c65230        	ld	a,21040
  58  0006 6b01          	ld	(OFST+0,sp),a
  59                     ; 54     dummy = UART1->DR;
  61  0008 c65231        	ld	a,21041
  62  000b 6b01          	ld	(OFST+0,sp),a
  63                     ; 56     UART1->BRR2 = UART1_BRR2_RESET_VALUE;  /*< Set UART1_BRR2 to reset value 0x00 */
  65  000d 725f5233      	clr	21043
  66                     ; 57     UART1->BRR1 = UART1_BRR1_RESET_VALUE;  /*< Set UART1_BRR1 to reset value 0x00 */
  68  0011 725f5232      	clr	21042
  69                     ; 59     UART1->CR1 = UART1_CR1_RESET_VALUE; /*< Set UART1_CR1 to reset value 0x00  */
  71  0015 725f5234      	clr	21044
  72                     ; 60     UART1->CR2 = UART1_CR2_RESET_VALUE; /*< Set UART1_CR2 to reset value 0x00  */
  74  0019 725f5235      	clr	21045
  75                     ; 61     UART1->CR3 = UART1_CR3_RESET_VALUE;  /*< Set UART1_CR3 to reset value 0x00  */
  77  001d 725f5236      	clr	21046
  78                     ; 62     UART1->CR4 = UART1_CR4_RESET_VALUE;  /*< Set UART1_CR4 to reset value 0x00  */
  80  0021 725f5237      	clr	21047
  81                     ; 63     UART1->CR5 = UART1_CR5_RESET_VALUE; /*< Set UART1_CR5 to reset value 0x00  */
  83  0025 725f5238      	clr	21048
  84                     ; 65     UART1->GTR = UART1_GTR_RESET_VALUE;
  86  0029 725f5239      	clr	21049
  87                     ; 66     UART1->PSCR = UART1_PSCR_RESET_VALUE;
  89  002d 725f523a      	clr	21050
  90                     ; 67 }
  93  0031 84            	pop	a
  94  0032 81            	ret
 398                     .const:	section	.text
 399  0000               L21:
 400  0000 00098969      	dc.l	625001
 401  0004               L25:
 402  0004 00000064      	dc.l	100
 403                     ; 82 void UART1_Init(u32 BaudRate, UART1_WordLength_TypeDef WordLength, UART1_StopBits_TypeDef StopBits, UART1_Parity_TypeDef Parity, UART1_SyncMode_TypeDef SyncMode, UART1_Mode_TypeDef Mode)
 403                     ; 83 {
 404                     	switch	.text
 405  0033               _UART1_Init:
 407  0033 520c          	subw	sp,#12
 408       0000000c      OFST:	set	12
 411                     ; 84     u32 BaudRate_Mantissa, BaudRate_Mantissa100 = 0;
 413  0035 96            	ldw	x,sp
 414  0036 1c0005        	addw	x,#OFST-7
 415  0039 cd0000        	call	c_ltor
 417                     ; 87     assert_param(IS_UART1_BAUDRATE_OK(BaudRate));
 419  003c 96            	ldw	x,sp
 420  003d 1c000f        	addw	x,#OFST+3
 421  0040 cd0000        	call	c_ltor
 423  0043 ae0000        	ldw	x,#L21
 424  0046 cd0000        	call	c_lcmp
 426  0049 2403          	jruge	L01
 427  004b 4f            	clr	a
 428  004c 2003          	jra	L41
 429  004e               L01:
 430  004e cd0000        	call	_assert_failed
 432  0051               L41:
 433                     ; 89     assert_param(IS_UART1_WORDLENGTH_OK(WordLength));
 435  0051 0d13          	tnz	(OFST+7,sp)
 436  0053 2706          	jreq	L02
 437  0055 7b13          	ld	a,(OFST+7,sp)
 438  0057 a110          	cp	a,#16
 439  0059 2603          	jrne	L61
 440  005b               L02:
 441  005b 4f            	clr	a
 442  005c 2003          	jra	L22
 443  005e               L61:
 444  005e cd0000        	call	_assert_failed
 446  0061               L22:
 447                     ; 91     assert_param(IS_UART1_STOPBITS_OK(StopBits));
 449  0061 0d14          	tnz	(OFST+8,sp)
 450  0063 2712          	jreq	L62
 451  0065 7b14          	ld	a,(OFST+8,sp)
 452  0067 a110          	cp	a,#16
 453  0069 270c          	jreq	L62
 454  006b 7b14          	ld	a,(OFST+8,sp)
 455  006d a120          	cp	a,#32
 456  006f 2706          	jreq	L62
 457  0071 7b14          	ld	a,(OFST+8,sp)
 458  0073 a130          	cp	a,#48
 459  0075 2603          	jrne	L42
 460  0077               L62:
 461  0077 4f            	clr	a
 462  0078 2003          	jra	L03
 463  007a               L42:
 464  007a cd0000        	call	_assert_failed
 466  007d               L03:
 467                     ; 93     assert_param(IS_UART1_PARITY_OK(Parity));
 469  007d 0d15          	tnz	(OFST+9,sp)
 470  007f 270c          	jreq	L43
 471  0081 7b15          	ld	a,(OFST+9,sp)
 472  0083 a104          	cp	a,#4
 473  0085 2706          	jreq	L43
 474  0087 7b15          	ld	a,(OFST+9,sp)
 475  0089 a106          	cp	a,#6
 476  008b 2603          	jrne	L23
 477  008d               L43:
 478  008d 4f            	clr	a
 479  008e 2003          	jra	L63
 480  0090               L23:
 481  0090 cd0000        	call	_assert_failed
 483  0093               L63:
 484                     ; 96     assert_param(IS_UART1_MODE_OK((u8)Mode));
 486  0093 7b17          	ld	a,(OFST+11,sp)
 487  0095 a108          	cp	a,#8
 488  0097 2730          	jreq	L24
 489  0099 7b17          	ld	a,(OFST+11,sp)
 490  009b a140          	cp	a,#64
 491  009d 272a          	jreq	L24
 492  009f 7b17          	ld	a,(OFST+11,sp)
 493  00a1 a104          	cp	a,#4
 494  00a3 2724          	jreq	L24
 495  00a5 7b17          	ld	a,(OFST+11,sp)
 496  00a7 a180          	cp	a,#128
 497  00a9 271e          	jreq	L24
 498  00ab 7b17          	ld	a,(OFST+11,sp)
 499  00ad a10c          	cp	a,#12
 500  00af 2718          	jreq	L24
 501  00b1 7b17          	ld	a,(OFST+11,sp)
 502  00b3 a10c          	cp	a,#12
 503  00b5 2712          	jreq	L24
 504  00b7 7b17          	ld	a,(OFST+11,sp)
 505  00b9 a144          	cp	a,#68
 506  00bb 270c          	jreq	L24
 507  00bd 7b17          	ld	a,(OFST+11,sp)
 508  00bf a1c0          	cp	a,#192
 509  00c1 2706          	jreq	L24
 510  00c3 7b17          	ld	a,(OFST+11,sp)
 511  00c5 a188          	cp	a,#136
 512  00c7 2603          	jrne	L04
 513  00c9               L24:
 514  00c9 4f            	clr	a
 515  00ca 2003          	jra	L44
 516  00cc               L04:
 517  00cc cd0000        	call	_assert_failed
 519  00cf               L44:
 520                     ; 100     assert_param(IS_UART1_SYNCMODE_OK((u8)SyncMode));
 522  00cf 7b16          	ld	a,(OFST+10,sp)
 523  00d1 a488          	and	a,#136
 524  00d3 a188          	cp	a,#136
 525  00d5 271b          	jreq	L64
 526  00d7 7b16          	ld	a,(OFST+10,sp)
 527  00d9 a444          	and	a,#68
 528  00db a144          	cp	a,#68
 529  00dd 2713          	jreq	L64
 530  00df 7b16          	ld	a,(OFST+10,sp)
 531  00e1 a422          	and	a,#34
 532  00e3 a122          	cp	a,#34
 533  00e5 270b          	jreq	L64
 534  00e7 7b16          	ld	a,(OFST+10,sp)
 535  00e9 a411          	and	a,#17
 536  00eb a111          	cp	a,#17
 537  00ed 2703          	jreq	L64
 538  00ef 4f            	clr	a
 539  00f0 2003          	jra	L05
 540  00f2               L64:
 541  00f2 cd0000        	call	_assert_failed
 543  00f5               L05:
 544                     ; 102     UART1->CR1 &= (u8)(~UART1_CR1_M);  /**< Clear the word length bit */
 546  00f5 72195234      	bres	21044,#4
 547                     ; 103     UART1->CR1 |= (u8)WordLength; /**< Set the word length bit according to UART1_WordLength value */
 549  00f9 c65234        	ld	a,21044
 550  00fc 1a13          	or	a,(OFST+7,sp)
 551  00fe c75234        	ld	21044,a
 552                     ; 105     UART1->CR3 &= (u8)(~UART1_CR3_STOP);  /**< Clear the STOP bits */
 554  0101 c65236        	ld	a,21046
 555  0104 a4cf          	and	a,#207
 556  0106 c75236        	ld	21046,a
 557                     ; 106     UART1->CR3 |= (u8)StopBits;  /**< Set the STOP bits number according to UART1_StopBits value  */
 559  0109 c65236        	ld	a,21046
 560  010c 1a14          	or	a,(OFST+8,sp)
 561  010e c75236        	ld	21046,a
 562                     ; 108     UART1->CR1 &= (u8)(~(UART1_CR1_PCEN | UART1_CR1_PS  ));  /**< Clear the Parity Control bit */
 564  0111 c65234        	ld	a,21044
 565  0114 a4f9          	and	a,#249
 566  0116 c75234        	ld	21044,a
 567                     ; 109     UART1->CR1 |= (u8)Parity;  /**< Set the Parity Control bit to UART1_Parity value */
 569  0119 c65234        	ld	a,21044
 570  011c 1a15          	or	a,(OFST+9,sp)
 571  011e c75234        	ld	21044,a
 572                     ; 111     UART1->BRR1 &= (u8)(~UART1_BRR1_DIVM);  /**< Clear the LSB mantissa of UART1DIV  */
 574  0121 725f5232      	clr	21042
 575                     ; 112     UART1->BRR2 &= (u8)(~UART1_BRR2_DIVM);  /**< Clear the MSB mantissa of UART1DIV  */
 577  0125 c65233        	ld	a,21043
 578  0128 a40f          	and	a,#15
 579  012a c75233        	ld	21043,a
 580                     ; 113     UART1->BRR2 &= (u8)(~UART1_BRR2_DIVF);  /**< Clear the Fraction bits of UART1DIV */
 582  012d c65233        	ld	a,21043
 583  0130 a4f0          	and	a,#240
 584  0132 c75233        	ld	21043,a
 585                     ; 116     BaudRate_Mantissa    = ((u32)CLK_GetClockFreq() / (BaudRate << 4));
 587  0135 96            	ldw	x,sp
 588  0136 1c000f        	addw	x,#OFST+3
 589  0139 cd0000        	call	c_ltor
 591  013c a604          	ld	a,#4
 592  013e cd0000        	call	c_llsh
 594  0141 96            	ldw	x,sp
 595  0142 1c0001        	addw	x,#OFST-11
 596  0145 cd0000        	call	c_rtol
 598  0148 cd0000        	call	_CLK_GetClockFreq
 600  014b 96            	ldw	x,sp
 601  014c 1c0001        	addw	x,#OFST-11
 602  014f cd0000        	call	c_ludv
 604  0152 96            	ldw	x,sp
 605  0153 1c0009        	addw	x,#OFST-3
 606  0156 cd0000        	call	c_rtol
 608                     ; 117     BaudRate_Mantissa100 = (((u32)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 610  0159 96            	ldw	x,sp
 611  015a 1c000f        	addw	x,#OFST+3
 612  015d cd0000        	call	c_ltor
 614  0160 a604          	ld	a,#4
 615  0162 cd0000        	call	c_llsh
 617  0165 96            	ldw	x,sp
 618  0166 1c0001        	addw	x,#OFST-11
 619  0169 cd0000        	call	c_rtol
 621  016c cd0000        	call	_CLK_GetClockFreq
 623  016f a664          	ld	a,#100
 624  0171 cd0000        	call	c_smul
 626  0174 96            	ldw	x,sp
 627  0175 1c0001        	addw	x,#OFST-11
 628  0178 cd0000        	call	c_ludv
 630  017b 96            	ldw	x,sp
 631  017c 1c0005        	addw	x,#OFST-7
 632  017f cd0000        	call	c_rtol
 634                     ; 118     UART1->BRR2 |= (u8)((u8)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100)) << 4) / 100) & (u8)0x0F); /**< Set the fraction of UART1DIV  */
 636  0182 96            	ldw	x,sp
 637  0183 1c0009        	addw	x,#OFST-3
 638  0186 cd0000        	call	c_ltor
 640  0189 a664          	ld	a,#100
 641  018b cd0000        	call	c_smul
 643  018e 96            	ldw	x,sp
 644  018f 1c0001        	addw	x,#OFST-11
 645  0192 cd0000        	call	c_rtol
 647  0195 96            	ldw	x,sp
 648  0196 1c0005        	addw	x,#OFST-7
 649  0199 cd0000        	call	c_ltor
 651  019c 96            	ldw	x,sp
 652  019d 1c0001        	addw	x,#OFST-11
 653  01a0 cd0000        	call	c_lsub
 655  01a3 a604          	ld	a,#4
 656  01a5 cd0000        	call	c_llsh
 658  01a8 ae0004        	ldw	x,#L25
 659  01ab cd0000        	call	c_ludv
 661  01ae b603          	ld	a,c_lreg+3
 662  01b0 a40f          	and	a,#15
 663  01b2 ca5233        	or	a,21043
 664  01b5 c75233        	ld	21043,a
 665                     ; 119     UART1->BRR2 |= (u8)((BaudRate_Mantissa >> 4) & (u8)0xF0); /**< Set the MSB mantissa of UART1DIV  */
 667  01b8 96            	ldw	x,sp
 668  01b9 1c0009        	addw	x,#OFST-3
 669  01bc cd0000        	call	c_ltor
 671  01bf a604          	ld	a,#4
 672  01c1 cd0000        	call	c_lursh
 674  01c4 b603          	ld	a,c_lreg+3
 675  01c6 a4f0          	and	a,#240
 676  01c8 b703          	ld	c_lreg+3,a
 677  01ca 3f02          	clr	c_lreg+2
 678  01cc 3f01          	clr	c_lreg+1
 679  01ce 3f00          	clr	c_lreg
 680  01d0 b603          	ld	a,c_lreg+3
 681  01d2 ca5233        	or	a,21043
 682  01d5 c75233        	ld	21043,a
 683                     ; 120     UART1->BRR1 |= (u8)BaudRate_Mantissa;           /**< Set the LSB mantissa of UART1DIV  */
 685  01d8 c65232        	ld	a,21042
 686  01db 1a0c          	or	a,(OFST+0,sp)
 687  01dd c75232        	ld	21042,a
 688                     ; 122     UART1->CR2 &= (u8)~(UART1_CR2_TEN | UART1_CR2_REN); /**< Disable the Transmitter and Receiver before seting the LBCL, CPOL and CPHA bits */
 690  01e0 c65235        	ld	a,21045
 691  01e3 a4f3          	and	a,#243
 692  01e5 c75235        	ld	21045,a
 693                     ; 123     UART1->CR3 &= (u8)~(UART1_CR3_CPOL | UART1_CR3_CPHA | UART1_CR3_LBCL); /**< Clear the Clock Polarity, lock Phase, Last Bit Clock pulse */
 695  01e8 c65236        	ld	a,21046
 696  01eb a4f8          	and	a,#248
 697  01ed c75236        	ld	21046,a
 698                     ; 124     UART1->CR3 |= (u8)((u8)SyncMode & (u8)(UART1_CR3_CPOL | UART1_CR3_CPHA | UART1_CR3_LBCL));  /**< Set the Clock Polarity, lock Phase, Last Bit Clock pulse */
 700  01f0 7b16          	ld	a,(OFST+10,sp)
 701  01f2 a407          	and	a,#7
 702  01f4 ca5236        	or	a,21046
 703  01f7 c75236        	ld	21046,a
 704                     ; 126     if ((u8)Mode & (u8)UART1_MODE_TX_ENABLE)
 706  01fa 7b17          	ld	a,(OFST+11,sp)
 707  01fc a504          	bcp	a,#4
 708  01fe 2706          	jreq	L102
 709                     ; 128         UART1->CR2 |= (u8)UART1_CR2_TEN;  /**< Set the Transmitter Enable bit */
 711  0200 72165235      	bset	21045,#3
 713  0204 2004          	jra	L302
 714  0206               L102:
 715                     ; 132         UART1->CR2 &= (u8)(~UART1_CR2_TEN);  /**< Clear the Transmitter Disable bit */
 717  0206 72175235      	bres	21045,#3
 718  020a               L302:
 719                     ; 134     if ((u8)Mode & (u8)UART1_MODE_RX_ENABLE)
 721  020a 7b17          	ld	a,(OFST+11,sp)
 722  020c a508          	bcp	a,#8
 723  020e 2706          	jreq	L502
 724                     ; 136         UART1->CR2 |= (u8)UART1_CR2_REN;  /**< Set the Receiver Enable bit */
 726  0210 72145235      	bset	21045,#2
 728  0214 2004          	jra	L702
 729  0216               L502:
 730                     ; 140         UART1->CR2 &= (u8)(~UART1_CR2_REN);  /**< Clear the Receiver Disable bit */
 732  0216 72155235      	bres	21045,#2
 733  021a               L702:
 734                     ; 143     if ((u8)SyncMode&(u8)UART1_SYNCMODE_CLOCK_DISABLE)
 736  021a 7b16          	ld	a,(OFST+10,sp)
 737  021c a580          	bcp	a,#128
 738  021e 2706          	jreq	L112
 739                     ; 145         UART1->CR3 &= (u8)(~UART1_CR3_CKEN); /**< Clear the Clock Enable bit */
 741  0220 72175236      	bres	21046,#3
 743  0224 200a          	jra	L312
 744  0226               L112:
 745                     ; 150         UART1->CR3 |= (u8)((u8)SyncMode & UART1_CR3_CKEN);
 747  0226 7b16          	ld	a,(OFST+10,sp)
 748  0228 a408          	and	a,#8
 749  022a ca5236        	or	a,21046
 750  022d c75236        	ld	21046,a
 751  0230               L312:
 752                     ; 152 }
 755  0230 5b0c          	addw	sp,#12
 756  0232 81            	ret
 811                     ; 167 void UART1_Cmd(FunctionalState NewState)
 811                     ; 168 {
 812                     	switch	.text
 813  0233               _UART1_Cmd:
 817                     ; 169     if (NewState != DISABLE)
 819  0233 4d            	tnz	a
 820  0234 2706          	jreq	L342
 821                     ; 171         UART1->CR1 &= (u8)(~UART1_CR1_UARTD); /**< UART1 Enable */
 823  0236 721b5234      	bres	21044,#5
 825  023a 2004          	jra	L542
 826  023c               L342:
 827                     ; 175         UART1->CR1 |= UART1_CR1_UARTD;  /**< UART1 Disable (for low power consumption) */
 829  023c 721a5234      	bset	21044,#5
 830  0240               L542:
 831                     ; 177 }
 834  0240 81            	ret
 960                     ; 198 void UART1_ITConfig(UART1_IT_TypeDef UART1_IT, FunctionalState NewState)
 960                     ; 199 {
 961                     	switch	.text
 962  0241               _UART1_ITConfig:
 964  0241 89            	pushw	x
 965  0242 89            	pushw	x
 966       00000002      OFST:	set	2
 969                     ; 200     u8 uartreg, itpos = 0x00;
 971  0243 7b02          	ld	a,(OFST+0,sp)
 972  0245 97            	ld	xl,a
 973                     ; 201     assert_param(IS_UART1_CONFIG_IT_OK(UART1_IT));
 975  0246 1e03          	ldw	x,(OFST+1,sp)
 976  0248 a30100        	cpw	x,#256
 977  024b 2723          	jreq	L26
 978  024d 1e03          	ldw	x,(OFST+1,sp)
 979  024f a30277        	cpw	x,#631
 980  0252 271c          	jreq	L26
 981  0254 1e03          	ldw	x,(OFST+1,sp)
 982  0256 a30266        	cpw	x,#614
 983  0259 2715          	jreq	L26
 984  025b 1e03          	ldw	x,(OFST+1,sp)
 985  025d a30205        	cpw	x,#517
 986  0260 270e          	jreq	L26
 987  0262 1e03          	ldw	x,(OFST+1,sp)
 988  0264 a30244        	cpw	x,#580
 989  0267 2707          	jreq	L26
 990  0269 1e03          	ldw	x,(OFST+1,sp)
 991  026b a30346        	cpw	x,#838
 992  026e 2603          	jrne	L06
 993  0270               L26:
 994  0270 4f            	clr	a
 995  0271 2003          	jra	L46
 996  0273               L06:
 997  0273 cd0000        	call	_assert_failed
 999  0276               L46:
1000                     ; 202     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1002  0276 7b07          	ld	a,(OFST+5,sp)
1003  0278 a101          	cp	a,#1
1004  027a 2704          	jreq	L07
1005  027c 0d07          	tnz	(OFST+5,sp)
1006  027e 2603          	jrne	L66
1007  0280               L07:
1008  0280 4f            	clr	a
1009  0281 2003          	jra	L27
1010  0283               L66:
1011  0283 cd0000        	call	_assert_failed
1013  0286               L27:
1014                     ; 205     uartreg = (u8)(UART1_IT >> (u8)0x08);
1016  0286 7b03          	ld	a,(OFST+1,sp)
1017  0288 6b01          	ld	(OFST-1,sp),a
1018                     ; 207     itpos = (u8)((u8)1 << (u8)((u8)UART1_IT & (u8)0x0F));
1020  028a 7b04          	ld	a,(OFST+2,sp)
1021  028c a40f          	and	a,#15
1022  028e 5f            	clrw	x
1023  028f 97            	ld	xl,a
1024  0290 a601          	ld	a,#1
1025  0292 5d            	tnzw	x
1026  0293 2704          	jreq	L47
1027  0295               L67:
1028  0295 48            	sll	a
1029  0296 5a            	decw	x
1030  0297 26fc          	jrne	L67
1031  0299               L47:
1032  0299 6b02          	ld	(OFST+0,sp),a
1033                     ; 209     if (NewState != DISABLE)
1035  029b 0d07          	tnz	(OFST+5,sp)
1036  029d 272a          	jreq	L523
1037                     ; 212         if (uartreg == 0x01)
1039  029f 7b01          	ld	a,(OFST-1,sp)
1040  02a1 a101          	cp	a,#1
1041  02a3 260a          	jrne	L723
1042                     ; 214             UART1->CR1 |= itpos;
1044  02a5 c65234        	ld	a,21044
1045  02a8 1a02          	or	a,(OFST+0,sp)
1046  02aa c75234        	ld	21044,a
1048  02ad 2045          	jra	L733
1049  02af               L723:
1050                     ; 216         else if (uartreg == 0x02)
1052  02af 7b01          	ld	a,(OFST-1,sp)
1053  02b1 a102          	cp	a,#2
1054  02b3 260a          	jrne	L333
1055                     ; 218             UART1->CR2 |= itpos;
1057  02b5 c65235        	ld	a,21045
1058  02b8 1a02          	or	a,(OFST+0,sp)
1059  02ba c75235        	ld	21045,a
1061  02bd 2035          	jra	L733
1062  02bf               L333:
1063                     ; 222             UART1->CR4 |= itpos;
1065  02bf c65237        	ld	a,21047
1066  02c2 1a02          	or	a,(OFST+0,sp)
1067  02c4 c75237        	ld	21047,a
1068  02c7 202b          	jra	L733
1069  02c9               L523:
1070                     ; 228         if (uartreg == 0x01)
1072  02c9 7b01          	ld	a,(OFST-1,sp)
1073  02cb a101          	cp	a,#1
1074  02cd 260b          	jrne	L143
1075                     ; 230             UART1->CR1 &= (u8)(~itpos);
1077  02cf 7b02          	ld	a,(OFST+0,sp)
1078  02d1 43            	cpl	a
1079  02d2 c45234        	and	a,21044
1080  02d5 c75234        	ld	21044,a
1082  02d8 201a          	jra	L733
1083  02da               L143:
1084                     ; 232         else if (uartreg == 0x02)
1086  02da 7b01          	ld	a,(OFST-1,sp)
1087  02dc a102          	cp	a,#2
1088  02de 260b          	jrne	L543
1089                     ; 234             UART1->CR2 &= (u8)(~itpos);
1091  02e0 7b02          	ld	a,(OFST+0,sp)
1092  02e2 43            	cpl	a
1093  02e3 c45235        	and	a,21045
1094  02e6 c75235        	ld	21045,a
1096  02e9 2009          	jra	L733
1097  02eb               L543:
1098                     ; 238             UART1->CR4 &= (u8)(~itpos);
1100  02eb 7b02          	ld	a,(OFST+0,sp)
1101  02ed 43            	cpl	a
1102  02ee c45237        	and	a,21047
1103  02f1 c75237        	ld	21047,a
1104  02f4               L733:
1105                     ; 242 }
1108  02f4 5b04          	addw	sp,#4
1109  02f6 81            	ret
1146                     ; 254 void UART1_HalfDuplexCmd(FunctionalState NewState)
1146                     ; 255 {
1147                     	switch	.text
1148  02f7               _UART1_HalfDuplexCmd:
1150  02f7 88            	push	a
1151       00000000      OFST:	set	0
1154                     ; 256     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1156  02f8 a101          	cp	a,#1
1157  02fa 2703          	jreq	L401
1158  02fc 4d            	tnz	a
1159  02fd 2603          	jrne	L201
1160  02ff               L401:
1161  02ff 4f            	clr	a
1162  0300 2003          	jra	L601
1163  0302               L201:
1164  0302 cd0000        	call	_assert_failed
1166  0305               L601:
1167                     ; 258     if (NewState != DISABLE)
1169  0305 0d01          	tnz	(OFST+1,sp)
1170  0307 2706          	jreq	L763
1171                     ; 260         UART1->CR5 |= UART1_CR5_HDSEL;  /**< UART1 Half Duplex Enable  */
1173  0309 72165238      	bset	21048,#3
1175  030d 2004          	jra	L173
1176  030f               L763:
1177                     ; 264         UART1->CR5 &= (u8)~UART1_CR5_HDSEL; /**< UART1 Half Duplex Disable */
1179  030f 72175238      	bres	21048,#3
1180  0313               L173:
1181                     ; 266 }
1184  0313 84            	pop	a
1185  0314 81            	ret
1243                     ; 280 void UART1_IrDAConfig(UART1_IrDAMode_TypeDef UART1_IrDAMode)
1243                     ; 281 {
1244                     	switch	.text
1245  0315               _UART1_IrDAConfig:
1247  0315 88            	push	a
1248       00000000      OFST:	set	0
1251                     ; 282     assert_param(IS_UART1_IRDAMODE_OK(UART1_IrDAMode));
1253  0316 a101          	cp	a,#1
1254  0318 2703          	jreq	L411
1255  031a 4d            	tnz	a
1256  031b 2603          	jrne	L211
1257  031d               L411:
1258  031d 4f            	clr	a
1259  031e 2003          	jra	L611
1260  0320               L211:
1261  0320 cd0000        	call	_assert_failed
1263  0323               L611:
1264                     ; 284     if (UART1_IrDAMode != UART1_IRDAMODE_NORMAL)
1266  0323 0d01          	tnz	(OFST+1,sp)
1267  0325 2706          	jreq	L124
1268                     ; 286         UART1->CR5 |= UART1_CR5_IRLP;
1270  0327 72145238      	bset	21048,#2
1272  032b 2004          	jra	L324
1273  032d               L124:
1274                     ; 290         UART1->CR5 &= ((u8)~UART1_CR5_IRLP);
1276  032d 72155238      	bres	21048,#2
1277  0331               L324:
1278                     ; 292 }
1281  0331 84            	pop	a
1282  0332 81            	ret
1318                     ; 306 void UART1_IrDACmd(FunctionalState NewState)
1318                     ; 307 {
1319                     	switch	.text
1320  0333               _UART1_IrDACmd:
1322  0333 88            	push	a
1323       00000000      OFST:	set	0
1326                     ; 310     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1328  0334 a101          	cp	a,#1
1329  0336 2703          	jreq	L421
1330  0338 4d            	tnz	a
1331  0339 2603          	jrne	L221
1332  033b               L421:
1333  033b 4f            	clr	a
1334  033c 2003          	jra	L621
1335  033e               L221:
1336  033e cd0000        	call	_assert_failed
1338  0341               L621:
1339                     ; 312     if (NewState != DISABLE)
1341  0341 0d01          	tnz	(OFST+1,sp)
1342  0343 2706          	jreq	L344
1343                     ; 315         UART1->CR5 |= UART1_CR5_IREN;
1345  0345 72125238      	bset	21048,#1
1347  0349 2004          	jra	L544
1348  034b               L344:
1349                     ; 320         UART1->CR5 &= ((u8)~UART1_CR5_IREN);
1351  034b 72135238      	bres	21048,#1
1352  034f               L544:
1353                     ; 322 }
1356  034f 84            	pop	a
1357  0350 81            	ret
1417                     ; 335 void UART1_LINBreakDetectionConfig(UART1_LINBreakDetectionLength_TypeDef UART1_LINBreakDetectionLength)
1417                     ; 336 {
1418                     	switch	.text
1419  0351               _UART1_LINBreakDetectionConfig:
1421  0351 88            	push	a
1422       00000000      OFST:	set	0
1425                     ; 337     assert_param(IS_UART1_LINBREAKDETECTIONLENGTH_OK(UART1_LINBreakDetectionLength));
1427  0352 4d            	tnz	a
1428  0353 2704          	jreq	L431
1429  0355 a101          	cp	a,#1
1430  0357 2603          	jrne	L231
1431  0359               L431:
1432  0359 4f            	clr	a
1433  035a 2003          	jra	L631
1434  035c               L231:
1435  035c cd0000        	call	_assert_failed
1437  035f               L631:
1438                     ; 339     if (UART1_LINBreakDetectionLength != UART1_LINBREAKDETECTIONLENGTH_10BITS)
1440  035f 0d01          	tnz	(OFST+1,sp)
1441  0361 2706          	jreq	L574
1442                     ; 341         UART1->CR4 |= UART1_CR4_LBDL;
1444  0363 721a5237      	bset	21047,#5
1446  0367 2004          	jra	L774
1447  0369               L574:
1448                     ; 345         UART1->CR4 &= ((u8)~UART1_CR4_LBDL);
1450  0369 721b5237      	bres	21047,#5
1451  036d               L774:
1452                     ; 347 }
1455  036d 84            	pop	a
1456  036e 81            	ret
1492                     ; 360 void UART1_LINCmd(FunctionalState NewState)
1492                     ; 361 {
1493                     	switch	.text
1494  036f               _UART1_LINCmd:
1496  036f 88            	push	a
1497       00000000      OFST:	set	0
1500                     ; 362     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1502  0370 a101          	cp	a,#1
1503  0372 2703          	jreq	L441
1504  0374 4d            	tnz	a
1505  0375 2603          	jrne	L241
1506  0377               L441:
1507  0377 4f            	clr	a
1508  0378 2003          	jra	L641
1509  037a               L241:
1510  037a cd0000        	call	_assert_failed
1512  037d               L641:
1513                     ; 364     if (NewState != DISABLE)
1515  037d 0d01          	tnz	(OFST+1,sp)
1516  037f 2706          	jreq	L715
1517                     ; 367         UART1->CR3 |= UART1_CR3_LINEN;
1519  0381 721c5236      	bset	21046,#6
1521  0385 2004          	jra	L125
1522  0387               L715:
1523                     ; 372         UART1->CR3 &= ((u8)~UART1_CR3_LINEN);
1525  0387 721d5236      	bres	21046,#6
1526  038b               L125:
1527                     ; 374 }
1530  038b 84            	pop	a
1531  038c 81            	ret
1567                     ; 387 void UART1_SmartCardCmd(FunctionalState NewState)
1567                     ; 388 {
1568                     	switch	.text
1569  038d               _UART1_SmartCardCmd:
1571  038d 88            	push	a
1572       00000000      OFST:	set	0
1575                     ; 389     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1577  038e a101          	cp	a,#1
1578  0390 2703          	jreq	L451
1579  0392 4d            	tnz	a
1580  0393 2603          	jrne	L251
1581  0395               L451:
1582  0395 4f            	clr	a
1583  0396 2003          	jra	L651
1584  0398               L251:
1585  0398 cd0000        	call	_assert_failed
1587  039b               L651:
1588                     ; 391     if (NewState != DISABLE)
1590  039b 0d01          	tnz	(OFST+1,sp)
1591  039d 2706          	jreq	L145
1592                     ; 394         UART1->CR5 |= UART1_CR5_SCEN;
1594  039f 721a5238      	bset	21048,#5
1596  03a3 2004          	jra	L345
1597  03a5               L145:
1598                     ; 399         UART1->CR5 &= ((u8)(~UART1_CR5_SCEN));
1600  03a5 721b5238      	bres	21048,#5
1601  03a9               L345:
1602                     ; 401 }
1605  03a9 84            	pop	a
1606  03aa 81            	ret
1643                     ; 414 void UART1_SmartCardNACKCmd(FunctionalState NewState)
1643                     ; 415 {
1644                     	switch	.text
1645  03ab               _UART1_SmartCardNACKCmd:
1647  03ab 88            	push	a
1648       00000000      OFST:	set	0
1651                     ; 416     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1653  03ac a101          	cp	a,#1
1654  03ae 2703          	jreq	L461
1655  03b0 4d            	tnz	a
1656  03b1 2603          	jrne	L261
1657  03b3               L461:
1658  03b3 4f            	clr	a
1659  03b4 2003          	jra	L661
1660  03b6               L261:
1661  03b6 cd0000        	call	_assert_failed
1663  03b9               L661:
1664                     ; 418     if (NewState != DISABLE)
1666  03b9 0d01          	tnz	(OFST+1,sp)
1667  03bb 2706          	jreq	L365
1668                     ; 421         UART1->CR5 |= UART1_CR5_NACK;
1670  03bd 72185238      	bset	21048,#4
1672  03c1 2004          	jra	L565
1673  03c3               L365:
1674                     ; 426         UART1->CR5 &= ((u8)~(UART1_CR5_NACK));
1676  03c3 72195238      	bres	21048,#4
1677  03c7               L565:
1678                     ; 428 }
1681  03c7 84            	pop	a
1682  03c8 81            	ret
1740                     ; 441 void UART1_WakeUpConfig(UART1_WakeUp_TypeDef UART1_WakeUp)
1740                     ; 442 {
1741                     	switch	.text
1742  03c9               _UART1_WakeUpConfig:
1744  03c9 88            	push	a
1745       00000000      OFST:	set	0
1748                     ; 443     assert_param(IS_UART1_WAKEUP_OK(UART1_WakeUp));
1750  03ca 4d            	tnz	a
1751  03cb 2704          	jreq	L471
1752  03cd a108          	cp	a,#8
1753  03cf 2603          	jrne	L271
1754  03d1               L471:
1755  03d1 4f            	clr	a
1756  03d2 2003          	jra	L671
1757  03d4               L271:
1758  03d4 cd0000        	call	_assert_failed
1760  03d7               L671:
1761                     ; 445     UART1->CR1 &= ((u8)~UART1_CR1_WAKE);
1763  03d7 72175234      	bres	21044,#3
1764                     ; 446     UART1->CR1 |= (u8)UART1_WakeUp;
1766  03db c65234        	ld	a,21044
1767  03de 1a01          	or	a,(OFST+1,sp)
1768  03e0 c75234        	ld	21044,a
1769                     ; 447 }
1772  03e3 84            	pop	a
1773  03e4 81            	ret
1810                     ; 459 void UART1_ReceiverWakeUpCmd(FunctionalState NewState)
1810                     ; 460 {
1811                     	switch	.text
1812  03e5               _UART1_ReceiverWakeUpCmd:
1814  03e5 88            	push	a
1815       00000000      OFST:	set	0
1818                     ; 461     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1820  03e6 a101          	cp	a,#1
1821  03e8 2703          	jreq	L402
1822  03ea 4d            	tnz	a
1823  03eb 2603          	jrne	L202
1824  03ed               L402:
1825  03ed 4f            	clr	a
1826  03ee 2003          	jra	L602
1827  03f0               L202:
1828  03f0 cd0000        	call	_assert_failed
1830  03f3               L602:
1831                     ; 463     if (NewState != DISABLE)
1833  03f3 0d01          	tnz	(OFST+1,sp)
1834  03f5 2706          	jreq	L336
1835                     ; 466         UART1->CR2 |= UART1_CR2_RWU;
1837  03f7 72125235      	bset	21045,#1
1839  03fb 2004          	jra	L536
1840  03fd               L336:
1841                     ; 471         UART1->CR2 &= ((u8)~UART1_CR2_RWU);
1843  03fd 72135235      	bres	21045,#1
1844  0401               L536:
1845                     ; 473 }
1848  0401 84            	pop	a
1849  0402 81            	ret
1872                     ; 483 u8 UART1_ReceiveData8(void)
1872                     ; 484 {
1873                     	switch	.text
1874  0403               _UART1_ReceiveData8:
1878                     ; 485     return ((u8)UART1->DR);
1880  0403 c65231        	ld	a,21041
1883  0406 81            	ret
1906                     ; 497 u16 UART1_ReceiveData9(void)
1906                     ; 498 {
1907                     	switch	.text
1908  0407               _UART1_ReceiveData9:
1910  0407 89            	pushw	x
1911       00000002      OFST:	set	2
1914                     ; 499     return (u16)( (((u16) UART1->DR) | ((u16)(((u16)( (u16)UART1->CR1 & (u16)UART1_CR1_R8)) << 1))) & ((u16)0x01FF));
1916  0408 c65234        	ld	a,21044
1917  040b 5f            	clrw	x
1918  040c a480          	and	a,#128
1919  040e 5f            	clrw	x
1920  040f 02            	rlwa	x,a
1921  0410 58            	sllw	x
1922  0411 1f01          	ldw	(OFST-1,sp),x
1923  0413 c65231        	ld	a,21041
1924  0416 5f            	clrw	x
1925  0417 97            	ld	xl,a
1926  0418 01            	rrwa	x,a
1927  0419 1a02          	or	a,(OFST+0,sp)
1928  041b 01            	rrwa	x,a
1929  041c 1a01          	or	a,(OFST-1,sp)
1930  041e 01            	rrwa	x,a
1931  041f 01            	rrwa	x,a
1932  0420 a4ff          	and	a,#255
1933  0422 01            	rrwa	x,a
1934  0423 a401          	and	a,#1
1935  0425 01            	rrwa	x,a
1938  0426 5b02          	addw	sp,#2
1939  0428 81            	ret
1973                     ; 512 void UART1_SendData8(u8 Data)
1973                     ; 513 {
1974                     	switch	.text
1975  0429               _UART1_SendData8:
1979                     ; 515     UART1->DR = Data;
1981  0429 c75231        	ld	21041,a
1982                     ; 516 }
1985  042c 81            	ret
2019                     ; 528 void UART1_SendData9(u16 Data)
2019                     ; 529 {
2020                     	switch	.text
2021  042d               _UART1_SendData9:
2023  042d 89            	pushw	x
2024       00000000      OFST:	set	0
2027                     ; 531     UART1->CR1 &= ((u8)~UART1_CR1_T8);
2029  042e 721d5234      	bres	21044,#6
2030                     ; 533     UART1->CR1 |= (u8)(((u8)(Data >> 2)) & UART1_CR1_T8);
2032  0432 54            	srlw	x
2033  0433 54            	srlw	x
2034  0434 9f            	ld	a,xl
2035  0435 a440          	and	a,#64
2036  0437 ca5234        	or	a,21044
2037  043a c75234        	ld	21044,a
2038                     ; 535     UART1->DR   = (u8)(Data);
2040  043d 7b02          	ld	a,(OFST+2,sp)
2041  043f c75231        	ld	21041,a
2042                     ; 536 }
2045  0442 85            	popw	x
2046  0443 81            	ret
2069                     ; 547 void UART1_SendBreak(void)
2069                     ; 548 {
2070                     	switch	.text
2071  0444               _UART1_SendBreak:
2075                     ; 549     UART1->CR2 |= UART1_CR2_SBK;
2077  0444 72105235      	bset	21045,#0
2078                     ; 550 }
2081  0448 81            	ret
2116                     ; 563 void UART1_SetAddress(u8 UART1_Address)
2116                     ; 564 {
2117                     	switch	.text
2118  0449               _UART1_SetAddress:
2120  0449 88            	push	a
2121       00000000      OFST:	set	0
2124                     ; 566     assert_param(IS_UART1_ADDRESS_OK(UART1_Address));
2126  044a a110          	cp	a,#16
2127  044c 2403          	jruge	L422
2128  044e 4f            	clr	a
2129  044f 2003          	jra	L622
2130  0451               L422:
2131  0451 cd0000        	call	_assert_failed
2133  0454               L622:
2134                     ; 569     UART1->CR4 &= ((u8)~UART1_CR4_ADD);
2136  0454 c65237        	ld	a,21047
2137  0457 a4f0          	and	a,#240
2138  0459 c75237        	ld	21047,a
2139                     ; 571     UART1->CR4 |= UART1_Address;
2141  045c c65237        	ld	a,21047
2142  045f 1a01          	or	a,(OFST+1,sp)
2143  0461 c75237        	ld	21047,a
2144                     ; 572 }
2147  0464 84            	pop	a
2148  0465 81            	ret
2182                     ; 585 void UART1_SetGuardTime(u8 UART1_GuardTime)
2182                     ; 586 {
2183                     	switch	.text
2184  0466               _UART1_SetGuardTime:
2188                     ; 588     UART1->GTR = UART1_GuardTime;
2190  0466 c75239        	ld	21049,a
2191                     ; 589 }
2194  0469 81            	ret
2228                     ; 614 void UART1_SetPrescaler(u8 UART1_Prescaler)
2228                     ; 615 {
2229                     	switch	.text
2230  046a               _UART1_SetPrescaler:
2234                     ; 617     UART1->PSCR = UART1_Prescaler;
2236  046a c7523a        	ld	21050,a
2237                     ; 618 }
2240  046d 81            	ret
2384                     ; 630 FlagStatus UART1_GetFlagStatus(UART1_Flag_TypeDef UART1_FLAG)
2384                     ; 631 {
2385                     	switch	.text
2386  046e               _UART1_GetFlagStatus:
2388  046e 89            	pushw	x
2389  046f 88            	push	a
2390       00000001      OFST:	set	1
2393                     ; 632     FlagStatus status = RESET;
2395  0470 0f01          	clr	(OFST+0,sp)
2396                     ; 635     assert_param(IS_UART1_FLAG_OK(UART1_FLAG));
2398  0472 a30080        	cpw	x,#128
2399  0475 272d          	jreq	L042
2400  0477 a30040        	cpw	x,#64
2401  047a 2728          	jreq	L042
2402  047c a30020        	cpw	x,#32
2403  047f 2723          	jreq	L042
2404  0481 a30010        	cpw	x,#16
2405  0484 271e          	jreq	L042
2406  0486 a30008        	cpw	x,#8
2407  0489 2719          	jreq	L042
2408  048b a30004        	cpw	x,#4
2409  048e 2714          	jreq	L042
2410  0490 a30002        	cpw	x,#2
2411  0493 270f          	jreq	L042
2412  0495 a30001        	cpw	x,#1
2413  0498 270a          	jreq	L042
2414  049a a30101        	cpw	x,#257
2415  049d 2705          	jreq	L042
2416  049f a30210        	cpw	x,#528
2417  04a2 2603          	jrne	L632
2418  04a4               L042:
2419  04a4 4f            	clr	a
2420  04a5 2003          	jra	L242
2421  04a7               L632:
2422  04a7 cd0000        	call	_assert_failed
2424  04aa               L242:
2425                     ; 639     if (UART1_FLAG == UART1_FLAG_LBDF)
2427  04aa 1e02          	ldw	x,(OFST+1,sp)
2428  04ac a30210        	cpw	x,#528
2429  04af 2611          	jrne	L7501
2430                     ; 641         if ((UART1->CR4 & (u8)UART1_FLAG) != (u8)0x00)
2432  04b1 c65237        	ld	a,21047
2433  04b4 1503          	bcp	a,(OFST+2,sp)
2434  04b6 2706          	jreq	L1601
2435                     ; 644             status = SET;
2437  04b8 a601          	ld	a,#1
2438  04ba 6b01          	ld	(OFST+0,sp),a
2440  04bc 202b          	jra	L5601
2441  04be               L1601:
2442                     ; 649             status = RESET;
2444  04be 0f01          	clr	(OFST+0,sp)
2445  04c0 2027          	jra	L5601
2446  04c2               L7501:
2447                     ; 652     else if (UART1_FLAG == UART1_FLAG_SBK)
2449  04c2 1e02          	ldw	x,(OFST+1,sp)
2450  04c4 a30101        	cpw	x,#257
2451  04c7 2611          	jrne	L7601
2452                     ; 654         if ((UART1->CR2 & (u8)UART1_FLAG) != (u8)0x00)
2454  04c9 c65235        	ld	a,21045
2455  04cc 1503          	bcp	a,(OFST+2,sp)
2456  04ce 2706          	jreq	L1701
2457                     ; 657             status = SET;
2459  04d0 a601          	ld	a,#1
2460  04d2 6b01          	ld	(OFST+0,sp),a
2462  04d4 2013          	jra	L5601
2463  04d6               L1701:
2464                     ; 662             status = RESET;
2466  04d6 0f01          	clr	(OFST+0,sp)
2467  04d8 200f          	jra	L5601
2468  04da               L7601:
2469                     ; 667         if ((UART1->SR & (u8)UART1_FLAG) != (u8)0x00)
2471  04da c65230        	ld	a,21040
2472  04dd 1503          	bcp	a,(OFST+2,sp)
2473  04df 2706          	jreq	L7701
2474                     ; 670             status = SET;
2476  04e1 a601          	ld	a,#1
2477  04e3 6b01          	ld	(OFST+0,sp),a
2479  04e5 2002          	jra	L5601
2480  04e7               L7701:
2481                     ; 675             status = RESET;
2483  04e7 0f01          	clr	(OFST+0,sp)
2484  04e9               L5601:
2485                     ; 679     return status;
2487  04e9 7b01          	ld	a,(OFST+0,sp)
2490  04eb 5b03          	addw	sp,#3
2491  04ed 81            	ret
2527                     ; 706 void UART1_ClearFlag(UART1_Flag_TypeDef UART1_FLAG)
2527                     ; 707 {
2528                     	switch	.text
2529  04ee               _UART1_ClearFlag:
2531  04ee 89            	pushw	x
2532       00000000      OFST:	set	0
2535                     ; 708     assert_param(IS_UART1_CLEAR_FLAG_OK(UART1_FLAG));
2537  04ef a30020        	cpw	x,#32
2538  04f2 2705          	jreq	L052
2539  04f4 a30210        	cpw	x,#528
2540  04f7 2603          	jrne	L642
2541  04f9               L052:
2542  04f9 4f            	clr	a
2543  04fa 2003          	jra	L252
2544  04fc               L642:
2545  04fc cd0000        	call	_assert_failed
2547  04ff               L252:
2548                     ; 711     if (UART1_FLAG == UART1_FLAG_RXNE)
2550  04ff 1e01          	ldw	x,(OFST+1,sp)
2551  0501 a30020        	cpw	x,#32
2552  0504 2606          	jrne	L1211
2553                     ; 713         UART1->SR = (u8)~(UART1_SR_RXNE);
2555  0506 35df5230      	mov	21040,#223
2557  050a 2004          	jra	L3211
2558  050c               L1211:
2559                     ; 718         UART1->CR4 &= (u8)~(UART1_CR4_LBDF);
2561  050c 72195237      	bres	21047,#4
2562  0510               L3211:
2563                     ; 720 }
2566  0510 85            	popw	x
2567  0511 81            	ret
2650                     ; 738 ITStatus UART1_GetITStatus(UART1_IT_TypeDef UART1_IT)
2650                     ; 739 {
2651                     	switch	.text
2652  0512               _UART1_GetITStatus:
2654  0512 89            	pushw	x
2655  0513 89            	pushw	x
2656       00000002      OFST:	set	2
2659                     ; 740     ITStatus pendingbitstatus = RESET;
2661  0514 7b02          	ld	a,(OFST+0,sp)
2662  0516 97            	ld	xl,a
2663                     ; 741     u8 itpos = 0;
2665  0517 7b01          	ld	a,(OFST-1,sp)
2666  0519 97            	ld	xl,a
2667                     ; 742     u8 itmask1 = 0;
2669  051a 7b02          	ld	a,(OFST+0,sp)
2670  051c 97            	ld	xl,a
2671                     ; 743     u8 itmask2 = 0;
2673  051d 7b02          	ld	a,(OFST+0,sp)
2674  051f 97            	ld	xl,a
2675                     ; 744     u8 enablestatus = 0;
2677  0520 7b02          	ld	a,(OFST+0,sp)
2678  0522 97            	ld	xl,a
2679                     ; 747     assert_param(IS_UART1_GET_IT_OK(UART1_IT));
2681  0523 1e03          	ldw	x,(OFST+1,sp)
2682  0525 a30277        	cpw	x,#631
2683  0528 272a          	jreq	L062
2684  052a 1e03          	ldw	x,(OFST+1,sp)
2685  052c a30266        	cpw	x,#614
2686  052f 2723          	jreq	L062
2687  0531 1e03          	ldw	x,(OFST+1,sp)
2688  0533 a30255        	cpw	x,#597
2689  0536 271c          	jreq	L062
2690  0538 1e03          	ldw	x,(OFST+1,sp)
2691  053a a30244        	cpw	x,#580
2692  053d 2715          	jreq	L062
2693  053f 1e03          	ldw	x,(OFST+1,sp)
2694  0541 a30235        	cpw	x,#565
2695  0544 270e          	jreq	L062
2696  0546 1e03          	ldw	x,(OFST+1,sp)
2697  0548 a30346        	cpw	x,#838
2698  054b 2707          	jreq	L062
2699  054d 1e03          	ldw	x,(OFST+1,sp)
2700  054f a30100        	cpw	x,#256
2701  0552 2603          	jrne	L652
2702  0554               L062:
2703  0554 4f            	clr	a
2704  0555 2003          	jra	L262
2705  0557               L652:
2706  0557 cd0000        	call	_assert_failed
2708  055a               L262:
2709                     ; 750     itpos = (u8)((u8)1 << (u8)((u8)UART1_IT & (u8)0x0F));
2711  055a 7b04          	ld	a,(OFST+2,sp)
2712  055c a40f          	and	a,#15
2713  055e 5f            	clrw	x
2714  055f 97            	ld	xl,a
2715  0560 a601          	ld	a,#1
2716  0562 5d            	tnzw	x
2717  0563 2704          	jreq	L462
2718  0565               L662:
2719  0565 48            	sll	a
2720  0566 5a            	decw	x
2721  0567 26fc          	jrne	L662
2722  0569               L462:
2723  0569 6b01          	ld	(OFST-1,sp),a
2724                     ; 752     itmask1 = (u8)((u8)UART1_IT >> (u8)4);
2726  056b 7b04          	ld	a,(OFST+2,sp)
2727  056d 4e            	swap	a
2728  056e a40f          	and	a,#15
2729  0570 6b02          	ld	(OFST+0,sp),a
2730                     ; 754     itmask2 = (u8)((u8)1 << itmask1);
2732  0572 7b02          	ld	a,(OFST+0,sp)
2733  0574 5f            	clrw	x
2734  0575 97            	ld	xl,a
2735  0576 a601          	ld	a,#1
2736  0578 5d            	tnzw	x
2737  0579 2704          	jreq	L072
2738  057b               L272:
2739  057b 48            	sll	a
2740  057c 5a            	decw	x
2741  057d 26fc          	jrne	L272
2742  057f               L072:
2743  057f 6b02          	ld	(OFST+0,sp),a
2744                     ; 758     if (UART1_IT == UART1_IT_PE)
2746  0581 1e03          	ldw	x,(OFST+1,sp)
2747  0583 a30100        	cpw	x,#256
2748  0586 261c          	jrne	L7611
2749                     ; 761         enablestatus = (u8)((u8)UART1->CR1 & itmask2);
2751  0588 c65234        	ld	a,21044
2752  058b 1402          	and	a,(OFST+0,sp)
2753  058d 6b02          	ld	(OFST+0,sp),a
2754                     ; 764         if (((UART1->SR & itpos) != (u8)0x00) && enablestatus)
2756  058f c65230        	ld	a,21040
2757  0592 1501          	bcp	a,(OFST-1,sp)
2758  0594 270a          	jreq	L1711
2760  0596 0d02          	tnz	(OFST+0,sp)
2761  0598 2706          	jreq	L1711
2762                     ; 767             pendingbitstatus = SET;
2764  059a a601          	ld	a,#1
2765  059c 6b02          	ld	(OFST+0,sp),a
2767  059e 2041          	jra	L5711
2768  05a0               L1711:
2769                     ; 772             pendingbitstatus = RESET;
2771  05a0 0f02          	clr	(OFST+0,sp)
2772  05a2 203d          	jra	L5711
2773  05a4               L7611:
2774                     ; 776     else if (UART1_IT == UART1_IT_LBDF)
2776  05a4 1e03          	ldw	x,(OFST+1,sp)
2777  05a6 a30346        	cpw	x,#838
2778  05a9 261c          	jrne	L7711
2779                     ; 779         enablestatus = (u8)((u8)UART1->CR4 & itmask2);
2781  05ab c65237        	ld	a,21047
2782  05ae 1402          	and	a,(OFST+0,sp)
2783  05b0 6b02          	ld	(OFST+0,sp),a
2784                     ; 781         if (((UART1->CR4 & itpos) != (u8)0x00) && enablestatus)
2786  05b2 c65237        	ld	a,21047
2787  05b5 1501          	bcp	a,(OFST-1,sp)
2788  05b7 270a          	jreq	L1021
2790  05b9 0d02          	tnz	(OFST+0,sp)
2791  05bb 2706          	jreq	L1021
2792                     ; 784             pendingbitstatus = SET;
2794  05bd a601          	ld	a,#1
2795  05bf 6b02          	ld	(OFST+0,sp),a
2797  05c1 201e          	jra	L5711
2798  05c3               L1021:
2799                     ; 789             pendingbitstatus = RESET;
2801  05c3 0f02          	clr	(OFST+0,sp)
2802  05c5 201a          	jra	L5711
2803  05c7               L7711:
2804                     ; 795         enablestatus = (u8)((u8)UART1->CR2 & itmask2);
2806  05c7 c65235        	ld	a,21045
2807  05ca 1402          	and	a,(OFST+0,sp)
2808  05cc 6b02          	ld	(OFST+0,sp),a
2809                     ; 797         if (((UART1->SR & itpos) != (u8)0x00) && enablestatus)
2811  05ce c65230        	ld	a,21040
2812  05d1 1501          	bcp	a,(OFST-1,sp)
2813  05d3 270a          	jreq	L7021
2815  05d5 0d02          	tnz	(OFST+0,sp)
2816  05d7 2706          	jreq	L7021
2817                     ; 800             pendingbitstatus = SET;
2819  05d9 a601          	ld	a,#1
2820  05db 6b02          	ld	(OFST+0,sp),a
2822  05dd 2002          	jra	L5711
2823  05df               L7021:
2824                     ; 805             pendingbitstatus = RESET;
2826  05df 0f02          	clr	(OFST+0,sp)
2827  05e1               L5711:
2828                     ; 810     return  pendingbitstatus;
2830  05e1 7b02          	ld	a,(OFST+0,sp)
2833  05e3 5b04          	addw	sp,#4
2834  05e5 81            	ret
2871                     ; 836 void UART1_ClearITPendingBit(UART1_IT_TypeDef UART1_IT)
2871                     ; 837 {
2872                     	switch	.text
2873  05e6               _UART1_ClearITPendingBit:
2875  05e6 89            	pushw	x
2876       00000000      OFST:	set	0
2879                     ; 838     assert_param(IS_UART1_CLEAR_FLAG_OK(UART1_IT));
2881  05e7 a30020        	cpw	x,#32
2882  05ea 2705          	jreq	L003
2883  05ec a30210        	cpw	x,#528
2884  05ef 2603          	jrne	L672
2885  05f1               L003:
2886  05f1 4f            	clr	a
2887  05f2 2003          	jra	L203
2888  05f4               L672:
2889  05f4 cd0000        	call	_assert_failed
2891  05f7               L203:
2892                     ; 841     if (UART1_IT == UART1_IT_RXNE)
2894  05f7 1e01          	ldw	x,(OFST+1,sp)
2895  05f9 a30255        	cpw	x,#597
2896  05fc 2606          	jrne	L1321
2897                     ; 843         UART1->SR = (u8)~(UART1_SR_RXNE);
2899  05fe 35df5230      	mov	21040,#223
2901  0602 2004          	jra	L3321
2902  0604               L1321:
2903                     ; 848         UART1->CR4 &= (u8)~(UART1_CR4_LBDF);
2905  0604 72195237      	bres	21047,#4
2906  0608               L3321:
2907                     ; 850 }
2910  0608 85            	popw	x
2911  0609 81            	ret
2924                     	xref	_CLK_GetClockFreq
2925                     	xdef	_UART1_ClearITPendingBit
2926                     	xdef	_UART1_GetITStatus
2927                     	xdef	_UART1_ClearFlag
2928                     	xdef	_UART1_GetFlagStatus
2929                     	xdef	_UART1_SetPrescaler
2930                     	xdef	_UART1_SetGuardTime
2931                     	xdef	_UART1_SetAddress
2932                     	xdef	_UART1_SendBreak
2933                     	xdef	_UART1_SendData9
2934                     	xdef	_UART1_SendData8
2935                     	xdef	_UART1_ReceiveData9
2936                     	xdef	_UART1_ReceiveData8
2937                     	xdef	_UART1_ReceiverWakeUpCmd
2938                     	xdef	_UART1_WakeUpConfig
2939                     	xdef	_UART1_SmartCardNACKCmd
2940                     	xdef	_UART1_SmartCardCmd
2941                     	xdef	_UART1_LINCmd
2942                     	xdef	_UART1_LINBreakDetectionConfig
2943                     	xdef	_UART1_IrDACmd
2944                     	xdef	_UART1_IrDAConfig
2945                     	xdef	_UART1_HalfDuplexCmd
2946                     	xdef	_UART1_ITConfig
2947                     	xdef	_UART1_Cmd
2948                     	xdef	_UART1_Init
2949                     	xdef	_UART1_DeInit
2950                     	xref	_assert_failed
2951                     	xref.b	c_lreg
2970                     	xref	c_lursh
2971                     	xref	c_lsub
2972                     	xref	c_smul
2973                     	xref	c_ludv
2974                     	xref	c_rtol
2975                     	xref	c_llsh
2976                     	xref	c_lcmp
2977                     	xref	c_ltor
2978                     	end
