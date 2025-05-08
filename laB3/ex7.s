@ ARM Assembly - exercise 7 
@ Group Number : 31

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------

@	int fibo(int n) {
@    		if (n <= 2) return 1;
@    		else return fibo(n - 1) + fibo(n - 2);
@	}

fibo:
    sub sp, sp, #12
    str lr, [sp, #8]        
    str r0, [sp, #4]        
    str r4, [sp, #0]        @ save r4 for temp ans

    cmp r0, #2
    ble base                @ go to base if n <= 2

    sub r0, r0, #1          @ r0 = n - 1
    bl fibo                 @ fibo(n-1)
    mov r4, r0              @ store the ans of fibo(n-1) into r4

    ldr r0, [sp, #4]        @ get n
    sub r0, r0, #2          @ r0 = n - 2
    bl fibo                 @ fibo(n-2)

    add r0, r4, r0          @ r0 = fibo(n-1) + fibo(n-2)
    b end

base:
    mov r0, #1              @ r0 = 1 if n <= 2

end:
    ldr r4, [sp, #0]        
    ldr lr, [sp, #8]        
    add sp, sp, #12         
    mov pc, lr              @ return

@ ---------------------
	
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value n

	@ calling the Fibonacci function
	mov r0, r4 	@the arg1 load
	bl fibo
	mov r5,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "F_%d is %d\n"
