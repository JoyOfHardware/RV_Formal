PREFIX=powerpc64le-unknown-linux-gnu-
CC=$(PREFIX)gcc
LD=$(PREFIX)ld
OBJCOPY=$(PREFIX)objcopy

OBJS = main.o
OBJS += head.o
OBJS += uart_lpc_serial.o

CFLAGS = -g -Wall -Wdouble-promotion -Wfloat-conversion -std=c99
CFLAGS += -mno-string -mno-multiple -mno-vsx -mno-altivec -nostdlib
CFLAGS += -mlittle-endian -mstrict-align -msoft-float
CFLAGS += -Os
CFLAGS += -fdata-sections -ffunction-sections -fno-stack-protector -ffreestanding
CFLAGS += -U_FORTIFY_SOURCE

LDFLAGS = -N -T powerpc.lds -nostdlib

all : firmware.bin

firmware.bin: firmware.elf
	$(OBJCOPY) -O binary $< $@

firmware.elf : $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

%.o : %.c
	$(CC) -c $(CFLAGS) $< -o $@

%.o : %.S
	$(CC) -c $< -o $@

.PHONY: clean
clean:
	rm -rf $(OBJS)
	rm -rf firmware.bin
	rm -rf firmware.elf
