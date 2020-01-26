@ lab1-asm/choose.s
@ Copyright (c) 2018-19 J. M. Spivey

        .syntax unified
        .global foo
        .text

        .thumb_func
foo:
@ Compute Choose(n, r) using the recurrence
@   Choose(n, r) = Choose(n-1, r) + Choose(n-1, r-1)

        push {r4, lr}           @ Save registers
        sub sp, #8              @ Allocate space for locals
        movs r4, #1             @ Initialise result to 1

        cmp r1, #0              @ If r = 0 or r = n we are done
        beq done
        cmp r1, r0
        beq done

        subs r0, r0, #1         @ Compute n-1
        str r0, [sp, #0]        @ Save n-1 in stack
        str r1, [sp, #4]        @ Save r in stack
        bl foo                  @ Call foo(n-1, r)
        movs r4, r0             @ Save result in r4
        ldr r0, [sp, #0]        @ Reload n-1
        ldr r1, [sp, #4]        @ Reload r
        subs r1, r1, #1         @ Compute r-1
        bl foo                  @ Call foo(n-1, r-1)
        adds r4, r4, r0         @ Add to previous result

done:      
        movs r0, r4             @ Put result in r0
        add sp, #8              @ Reclaim space
        pop {r4, pc}            @ Restore and return


