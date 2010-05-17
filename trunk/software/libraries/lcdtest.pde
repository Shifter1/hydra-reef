#include "LCDi2c4bit.h"        // this is our new library, note quite in 'system space' yet
#define PWM_BACKLIGHT_PIN            9   // pwm-controlled LED backlight


LCDI2C4Bit lcd = LCDI2C4Bit(LCD_MCP_DEV_ADDR, LCD_PHYS_LINES, LCD_PHYS_ROWS, PWM_BACKLIGHT_PIN);   //0xa7 is the hardware addr of the i2c chip

void setup() {
}


void loop()
{
}



