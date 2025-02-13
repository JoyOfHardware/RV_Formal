.section .text.init
.global _start

.equ UART_BASE, 0x10000000  # QEMU's UART base address

_start:
    # Load address of the string into a1
    la a1, message

loop:
    lbu a0, 0(a1)            # Load a byte from the string
    beqz a0, exit            # If null terminator, exit
    li t0, UART_BASE         # Load UART address
    sb a0, 0(t0)             # Store character to UART (8-bit write)
    addi a1, a1, 1           # Move to next character
    j loop                   # Repeat

exit:
    j exit                   # Infinite loop

.section .rodata
message:
    .asciz "Hello, world!\n"
