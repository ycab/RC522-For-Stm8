#include "delay.h"

void delayms(u16 ms)
{
   u8 i;
  while(ms != 0)
  { 
    for(i=0;i<250;i++)
    {
    }
    for(i=0;i<75;i++)
    {
    }
    ms--;  
		;
  }     
}