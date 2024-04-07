/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */

.global a_value,b_value
.type a_value,%gnu_unique_object
.type b_value,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
a_value:          .word     0  
b_value:           .word     0  

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: 
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    mov r0,r0
.endif
    
    /** note to profs: asmFunc.s solution is in Canvas at:
     *    Canvas Files->
     *        Lab Files and Coding Examples->
     *            Lab 5 Division
     * Use it to test the C test code */
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    
    /* load values for A and B into memory, then into registers */
    LDR r3, =a_value
    LDR r1, [r3]
    LDR r4, =b_value
    LDR r2, [r4]
    
    /* load hex values which will help with logical operators */
    LDR r9, =0xFFFF0000
    LDR r10, =0x0000FFFF
    
    MOV r1, r0                 /* copy 32 bit value to register rB, which will help compute 32 bit version of A */
    AND r5, r1, r9             /* use logical operator to keep the upper 16 bits in A */
    ASRS r1, r5, 16            /* shift value of rA to the LSB while including sign extension */
    
    MOV r2, r0                 /* copy 32 bit value to register rB, so that 32 bit version of B can be calculated */
    AND r6, r2, r10            /* use logical operator to keep the lower 16 bits in B */
    ROR r6, r6, 16             /* rotate the value so that rB is at the MSB */
    ASRS r2, r6, 16            /* shift value of rB to the LSB while including sign extension */
    
    STR r1, [r3]               /* store 16 bit version of A into memory */
    STR r2, [r4]               /* store 16 bit version of B into memory */
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    mov r0,r0 /* these are do-nothing lines to deal with IDE mem display bug */
    mov r0,r0 /* this is a do-nothing line to deal with IDE mem display bug */

screen_shot:    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




