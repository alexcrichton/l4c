.file	"../tests2/diplodocus-forloopfun.l3"
.globl _c0_main
_c0_fun1:
	addq $-8, %rsp
.fun1_0:
	movl %edi, %eax
	addl $1, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %ecx
	movl $0, %r9d
	movl %ecx, %r8d
	addl %r9d, %r8d
.main_9:
	movl %ecx, %r9d
.main_1:
	movl $1, %edx
	movl $10, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_11
.main_2:
	addl $1, %r9d
	movl $1, %edx
	movl $5, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_5
.main_3:
	jmp .main_10
.main_5:
.main_6:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_fun1
	movq %rbx, %r9
.main_8:
	jmp .main_1
.main_11:
.main_7:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_10:
	jmp .main_7
.ident	"15-411 L4 reference compiler"
