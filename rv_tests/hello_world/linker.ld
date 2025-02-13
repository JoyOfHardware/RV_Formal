OUTPUT_ARCH(riscv)
ENTRY(_start)

SECTIONS
{
    /* Start execution at 0x80000000 */
    . = 0x80000000;

    .text : {
        *(.text.init)
        *(.text)
    }

    .rodata : {
        *(.rodata)
    }

    .data : {
        *(.data)
    }

    .bss : {
        *(.bss)
    }
}
