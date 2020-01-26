@ lab1-asm/add.s
@ Copyright (c) 2018-19 J. M. Spivey

        .syntax unified
        .global foo

        .text
        .thumb_func
foo:
@ ----------------
@ Two parameters are in registers r0 and r1

        adds r0, r0, r1         @ Add r0 and r1, result in r0

@ Result is now in register r0
@ ----------------
        bx lr                   @ Return to the caller

