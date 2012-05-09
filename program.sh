#!/bin/bash

if [ -z $1 ]; then
  echo "Usage $0 <source.c>"
  exit
fi

FILE=$(echo $1 | sed 's/\..*//')

rm $FILE.o $FILE.elf $FILE.hex
avr-gcc -Os -DF_CPU=16000000UL -mmcu=atmega328p -c -o $FILE.o $1
avr-gcc -mmcu=atmega328p $FILE.o -o $FILE.elf
avr-objcopy -O ihex -R .eeprom $FILE.elf $FILE.hex
avrdude -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:$FILE.hex
