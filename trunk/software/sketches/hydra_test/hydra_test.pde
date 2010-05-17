#include <Wire.h>
#include "LCDi2c4bit.h"        // this is our new library, note quite in 'system space' yet
#define PWM_BACKLIGHT_PIN            8   // pwm-controlled LED backlight
#define DS1307_I2C_ADDRESS 0x68


//LCDI2C4Bit lcd = LCDI2C4Bit(LCD_MCP_DEV_ADDR, LCD_PHYS_LINES, LCD_PHYS_ROWS, PWM_BACKLIGHT_PIN);   //0xa7 is the hardware addr of the i2c chip
LCDI2C4Bit lcd = LCDI2C4Bit(0xa7, 4, 20, PWM_BACKLIGHT_PIN);   //0xa7 is the hardware addr of the i2c chip

int i = 0;
char buffer[20];

// Convert decimal numbers to binary coded decimal
byte decToBcd(byte val)
{
  return ( (val/10*16) + (val%10) );
}

// Convert binary coded decimal to decimal numbers
byte bcdToDec(byte val)
{
  return ( (val/16*10) + (val%16) );
}

// Sets date and time, starts the clock
void setDate(byte second,        // 0-59
             byte minute,        // 0-59
             byte hour,          // 1-23
             byte dayOfWeek,     // 1-7
             byte dayOfMonth,    // 1-31
             byte month,         // 1-12
             byte year)          // 0-99
{
   Wire.beginTransmission(DS1307_I2C_ADDRESS);
   Wire.send(0);
   Wire.send(decToBcd(second));
   Wire.send(decToBcd(minute));
   Wire.send(decToBcd(hour));
   Wire.send(decToBcd(dayOfWeek));
   Wire.send(decToBcd(dayOfMonth));
   Wire.send(decToBcd(month));
   Wire.send(decToBcd(year));
   Wire.endTransmission();
}

// Gets the date and time
void getDate(byte *second,
             byte *minute,
             byte *hour,
             byte *dayOfWeek,
             byte *dayOfMonth,
             byte *month,
             byte *year)
{
  Wire.beginTransmission(DS1307_I2C_ADDRESS);
  Wire.send(0);
  Wire.endTransmission();
  Wire.requestFrom(DS1307_I2C_ADDRESS, 7);
  *second     = bcdToDec(Wire.receive() & 0x7f);
  *minute     = bcdToDec(Wire.receive());
  *hour       = bcdToDec(Wire.receive() & 0x3f);
  *dayOfWeek  = bcdToDec(Wire.receive());
  *dayOfMonth = bcdToDec(Wire.receive());
  *month      = bcdToDec(Wire.receive());
  *year       = bcdToDec(Wire.receive());
}


void setup() {
  pinMode(8, OUTPUT);
  Wire.begin();
  lcd.init();
  //lcd.clear();
  //lcd.cursorTo(0,1);
  //lcd.print("Hello World");

  // uncomment the next line if you need to set the clock.
  //   format is second, minute, hour, dayOfWeek, dayOfMonth, month, year;
  //   once you have set the clock, comment this back out so you don't reset
  //   each time you upload
  setDate(11, 15, 10, 11, 11, 9, 9);


}


void loop()
{
  byte second, minute, hour, dayOfWeek, dayOfMonth, month, year;
  getDate(&second, &minute, &hour, &dayOfWeek, &dayOfMonth, &month, &year);

  digitalWrite(8, HIGH);
  lcd.cursorTo(0,0);
  lcd.print("THIS. . .");
  lcd.cursorTo(1,0);
  lcd.print("IS. . .");
  lcd.cursorTo(2,0);
  lcd.print("HYDRAAA!!!!!!");
  lcd.cursorTo(3,0);
  i = millis()/1000;
  sprintf(buffer, "%d:%d:%d", hour, minute, second);
//  sprintf(buffer, "Uptime: %d seconds", i);
  lcd.print(buffer);
}



