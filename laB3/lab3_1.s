@ ARM Assembly - lab 3.1
@ 
@ Roshan Ragel - roshanr@pdn.ac.lk
@ Hasindu Gamaarachchi - hasindu@ce.pdn.ac.lk

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------

@	int myPow(int x, int n) {
@    		int ans = 1;
@    		for (int i = 1; i <= n; i++) {
@        		ans *= x;
@    		}
@    		return ans;
@	}
	
mypow:
	mov r7, #1	@ ans = 1
	mov r8, #1	@ i = 1
	b for
for:
	cmp r8, r1	@ cmp i and n
	bgt return
	mov r9, r7
	mul r7, r9, r0
	add r8, r8, #1
	b for
return:
	mov r0, r7
	mov pc, lr

@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value x
	mov r5, #3 	@the value n
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl mypow
	mov r6,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	mov r3, r6
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "%d^%d is %d\n"

