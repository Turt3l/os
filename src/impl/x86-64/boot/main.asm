; make it global for easier access when linking
global start

;putting it in the text section(code section for the binary)
section .text
; 32 bit mode because instructions are in 32 bit
bits 32
; entry point start label
start:
    ;print OK

    ; colour monitors reside at 0xb8000
    mov dword [0xb8000], 0x2f4b2f4f
    ; makes the cpy halt and not run any instructions any further
    hlt