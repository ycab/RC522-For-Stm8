# ST Visual Debugger Generated MAKE File, based on 数码管.stp

ifeq ($(CFG), )
CFG=Debug
$(warning ***No configuration specified. Defaulting to $(CFG)***)
endif

ToolsetRoot=
ToolsetBin=
ToolsetInc=C:\Hstm8
ToolsetLib=C:\Lib
ToolsetIncOpts=-iC:\Hstm8 
ToolsetLibOpts=-lC:\Lib 
ObjectExt=o
OutputExt=elf
InputName=$(basename $(notdir $<))


# 
# Debug
# 
ifeq "$(CFG)" "Debug"


OutputPath=Debug
ProjectSFile=数码管
TargetSName=数码管
TargetFName=数码管.elf
IntermPath=$(dir $@)
CFLAGS_PRJ=$(ToolsetBin)\cxstm8  -ispi -iuart +mods0 +debug -pxp -no -pp -l -idelay $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<
ASMFLAGS_PRJ=$(ToolsetBin)\castm8  -xx -l $(ToolsetIncOpts) -o$(IntermPath)$(InputName).$(ObjectExt) $<

all : $(OutputPath) 数码管.elf

$(OutputPath) : 
	if not exist $(OutputPath)/ mkdir $(OutputPath)

Debug\delay.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\main.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\rc522.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\spi.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\stm8_interrupt_vector.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Debug\uart.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

数码管.elf :  $(OutputPath)\delay.o $(OutputPath)\main.o $(OutputPath)\rc522.o $(OutputPath)\spi.o $(OutputPath)\stm8_interrupt_vector.o $(OutputPath)\uart.o $(OutputPath)\数码管.lkf
	$(ToolsetBin)\clnk  -m $(OutputPath)\$(TargetSName).map $(ToolsetLibOpts) -o $(OutputPath)\$(TargetSName).sm8 $(OutputPath)\$(TargetSName).lkf 
	$(ToolsetBin)\cvdwarf  $(OutputPath)\$(TargetSName).sm8 

	$(ToolsetBin)\chex  -o $(OutputPath)\$(TargetSName).s19 $(OutputPath)\$(TargetSName).sm8
clean : 
	-@erase $(OutputPath)\delay.o
	-@erase $(OutputPath)\main.o
	-@erase $(OutputPath)\rc522.o
	-@erase $(OutputPath)\spi.o
	-@erase $(OutputPath)\stm8_interrupt_vector.o
	-@erase $(OutputPath)\uart.o
	-@erase $(OutputPath)\数码管.elf
	-@erase $(OutputPath)\数码管.map
	-@erase $(OutputPath)\数码管.st7
	-@erase $(OutputPath)\数码管.s19
	-@erase $(OutputPath)\delay.ls
	-@erase $(OutputPath)\main.ls
	-@erase $(OutputPath)\rc522.ls
	-@erase $(OutputPath)\spi.ls
	-@erase $(OutputPath)\stm8_interrupt_vector.ls
	-@erase $(OutputPath)\uart.ls
endif

# 
# Release
# 
ifeq "$(CFG)" "Release"


OutputPath=Release
ProjectSFile=数码管
TargetSName=数码管
TargetFName=数码管.elf
IntermPath=$(dir $@)
CFLAGS_PRJ=$(ToolsetBin)\cxstm8  -ispi -iuart -idelay +mods0 -pp $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $< 
ASMFLAGS_PRJ=$(ToolsetBin)\castm8  $(ToolsetIncOpts) -o$(IntermPath)$(InputName).$(ObjectExt) $<

all : $(OutputPath) 数码管.elf

$(OutputPath) : 
	if not exist $(OutputPath)/ mkdir $(OutputPath)

Release\delay.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\main.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\rc522.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\spi.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8_interrupt_vector.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\uart.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

数码管.elf :  $(OutputPath)\delay.o $(OutputPath)\main.o $(OutputPath)\rc522.o $(OutputPath)\spi.o $(OutputPath)\stm8_interrupt_vector.o $(OutputPath)\uart.o $(OutputPath)\数码管.lkf
	$(ToolsetBin)\clnk  $(ToolsetLibOpts) -o $(OutputPath)\$(TargetSName).sm8 $(OutputPath)\$(TargetSName).lkf 
	$(ToolsetBin)\cvdwarf  $(OutputPath)\$(TargetSName).sm8 

	$(ToolsetBin)\chex  -o $(OutputPath)\$(TargetSName).s19 $(OutputPath)\$(TargetSName).sm8
clean : 
	-@erase $(OutputPath)\delay.o
	-@erase $(OutputPath)\main.o
	-@erase $(OutputPath)\rc522.o
	-@erase $(OutputPath)\spi.o
	-@erase $(OutputPath)\stm8_interrupt_vector.o
	-@erase $(OutputPath)\uart.o
	-@erase $(OutputPath)\数码管.elf
	-@erase $(OutputPath)\数码管.map
	-@erase $(OutputPath)\数码管.st7
	-@erase $(OutputPath)\数码管.s19
	-@erase $(OutputPath)\delay.ls
	-@erase $(OutputPath)\main.ls
	-@erase $(OutputPath)\rc522.ls
	-@erase $(OutputPath)\spi.ls
	-@erase $(OutputPath)\stm8_interrupt_vector.ls
	-@erase $(OutputPath)\uart.ls
endif
