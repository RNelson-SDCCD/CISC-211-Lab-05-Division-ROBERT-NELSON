/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
@ Define the globals so that the C code can access them
/* define and initialize global variables that C can access */
/* create a string */
.global nameStr
.type nameStr,%gnu_unique_object
    
/*** STUDENTS: Change the next line to your name!  **/
nameStr: .asciz "Robert Nelson"  

.align   /* realign so that next mem allocations are on word boundaries */
 
/* initialize a global variable that C can access to print the nameStr */
.global nameStrPtr
.type nameStrPtr,%gnu_unique_object
nameStrPtr: .word nameStr   /* Assign the mem loc of nameStr to nameStrPtr */
 
/* define and initialize global variables that C can access */

.global dividend,divisor,quotient,mod,we_have_a_problem
.type dividend,%gnu_unique_object
.type divisor,%gnu_unique_object
.type quotient,%gnu_unique_object
.type mod,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
dividend:          .word     0  
divisor:           .word     0  
quotient:          .word     0  
mod:               .word     0 
we_have_a_problem: .word     0

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
    
    /* START set all outputs to zero */
    ldr r2, =quotient
    ldr r3, =0
    str r3, [r2]
    
    ldr r2, =mod
    ldr r3, =0
    str r3, [r2]
    
    ldr r2, =we_have_a_problem
    ldr r3, =0
    str r3, [r2]
    /* END set all outputs to zero */
    
    /* Store the values passed into r0 & r1 to address of
     dividend and divisor */
    ldr r2, =dividend
    str r0, [r2]
    
    ldr r2, =divisor
    str r1, [r2]
    
    /* Load the value of quotient, used later */
    ldr r4, =quotient
    ldr r3, [r4]
    
    /* If either input value is 0, we have a problem */
    cmp r0, #0
    beq problem
    cmp r1, #0
    beq problem
    
    /* Perform division by subtraction */
    subtract:
    /* If dividend > divisor, goto store that value
     as modulo */
    cmp r0, r1
    blo mod_out
    
    /* Perform dividend - divisor */
    sub r0, r0, r1
    cmp r0, r1
    
    /* Iterate our quotient by 1; quotient is number
     of times divisor goes into dividend evenly */
    add r3, r3, 1
    
    /* If dividend > divisor, go back to start of loop */
    bhs subtract
    
    /* Store the assigned, iterated value of quotient
     into its address */
    quotient_out:
    str r3, [r4]
    
    /* Store the new value of dividend into address of
     mod, as it is now our remainder/modulo */
    mod_out:
    ldr r2, =mod
    str r0, [r2]
    
    /* Goto loading address of quotient into r0 as described */
    b quot_addr_out
    
    /* We have a problem */
    problem:
    /* Assign value of 1 to we_have_a_problem, continue to
     assigning address of quotient to r0 */
    ldr r2, =we_have_a_problem
    ldr r3, =1
    str r3, [r2]
    
    quot_addr_out:
    ldr r0, =quotient
    
    b done
    
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
           




