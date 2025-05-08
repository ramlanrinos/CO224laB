@ ARM Assembly - exercise 6 
@ Group Number : 31

	.text 	@ instruction memory
	
	
@ Write YOUR CODE HERE	

@ ---------------------

@	int fact(int n) {
@		int ans = 1;
@		for (int i = 1; i <= n; i++) {
@			ans *= i;
@		}
@		return ans;
@	}
	
fact:
	mov r12, #1		@ ans = 1
	mov r6, #1		@ i = 1
	b for
for:
	cmp r6, r0
	bgt return		@ go return if i > n
	mov r11, r12		@ take the value of r12 into r11 for mul operation
	mul r12, r11, r6	@ ans *= i
	add r6, r6, #1		@ i++
	b for
return:
	mov r0, r12		@ store the value of r12 into r0
	mov pc, lr		@ return

@ ---------------------	

.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value n

	@ calling the fact function
	mov r0, r4 	@the arg1 load
	bl fact
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
format: .asciz "Factorial of %d is %d\n"

