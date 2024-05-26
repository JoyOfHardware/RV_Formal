PREFIX=powerpc64le-unknown-linux-gnu-
AS_END=-le
LD_END=-EL

all: firmware.bin

test.o: test.s
	$(PREFIX)as $(AS_END) -mpower9 -o test.o test.s

firmware.elf: linker.lds test.o
	$(PREFIX)ld $(LD_END) -T linker.lds -o firmware.elf test.o

firmware.bin: firmware.elf
	$(PREFIX)objcopy $(OB_END) -O binary firmware.elf firmware.bin

.PHONY: clean

clean:
	-rm test.o
	-rm firmware.elf
	-rm firmware.bin
