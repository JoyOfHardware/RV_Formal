# Assemble the code
riscv64-unknown-elf-as -march=rv64imac -mabi=lp64 -o hello.o hello.S

# Link with our linker script to create an ELF file
riscv64-unknown-elf-ld -T linker.ld -o hello.elf hello.o

# Convert ELF to a raw binary
riscv64-unknown-elf-objcopy -O binary hello.elf hello.bin
