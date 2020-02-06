SHELL = /bin/sh

BIN = bin/
SRC = src/

FILE = snake
LIBS = $(SRC)ledcontrol.c $(SRC)font.h

CC = avr-gcc
OBJCOPY = avr-objcopy
AVRDUDE = avrdude
SIZE    = avr-size

# To debug add -DDEBUG to CC_FLAGS
CC_FLAGS = -Wall
CHIP_COMPILE = atmega32
CHIP_FLASH = m32
DF_CPU = 16000000

.PHONY: all
all: $(BIN)snake.hex size
.PHONY: install
install: transfer size

$(BIN)$(FILE).elf: $(SRC)$(FILE).c $(SRC)ledcontrol.h $(SRC)font.h $(BIN)
	$(CC) -mmcu=$(CHIP_COMPILE) -DF_CPU=$(DF_CPU) -Os $(CC_FLAGS) $(SRC)$(FILE).c $(LIBS)  -o $(BIN)$(FILE).elf


$(BIN)$(FILE).hex: $(BIN)$(FILE).elf
	$(OBJCOPY) -O ihex $(BIN)$(FILE).elf $(BIN)$(FILE).hex

$(BIN): 
	mkdir $(BIN)


# Display size of file.
.PHONY: size
size: $(BIN)$(FILE).elf
	@echo
	$(SIZE) -C --mcu=$(CHIP_COMPILE) $(BIN)$(FILE).elf

.PHONY: transfer
transfer: $(BIN)snake.hex
	$(AVRDUDE) -c usbasp -p $(CHIP_FLASH) -U flash:w:$(BIN)$(FILE).hex

.PHONY: clean
clean:
	rm -f $(BIN)*.hex
	rm -f $(BIN)*.elf
