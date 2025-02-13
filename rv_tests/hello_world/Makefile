# RISC-V toolchain
CC = riscv64-unknown-elf-gcc
AS = riscv64-unknown-elf-as
LD = riscv64-unknown-elf-ld
OBJCOPY = riscv64-unknown-elf-objcopy
QEMU = qemu-system-riscv64

# Compilation flags
ARCH_FLAGS = -march=rv64imac -mabi=lp64
LDSCRIPT = linker.ld

# Output files
ELF = hello.elf
BIN = hello.bin
OBJ = hello.o
SRC = hello.S

# Default rule
all: $(BIN)

# Assemble and link to ELF
$(ELF): $(SRC) $(LDSCRIPT)
	$(AS) $(ARCH_FLAGS) -o $(OBJ) $(SRC)
	$(LD) -T $(LDSCRIPT) -o $(ELF) $(OBJ)

# Convert ELF to raw binary
$(BIN): $(ELF)
	$(OBJCOPY) -O binary $(ELF) $(BIN)

# Run in QEMU
run: $(BIN)
	echo "Press CTRL+A then X to exit QEMU"
	$(QEMU) -machine virt -nographic -bios none -kernel $(BIN) -device loader,file=$(BIN),addr=0x80000000

# Clean up generated files
clean:
	rm -f $(OBJ) $(ELF) $(BIN)
