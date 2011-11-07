.file	"../tests0/exception01.l3"
.globl _c0_main
_c0_fib:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.fib_0:
	movl $1, %edx
	movl $0, %r8d
	movl %r9d, %ecx
	cmpl %r8d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .fib_3
.fib_1:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.fib_3:
.fib_4:
	movl $0, %r8d
	cmpl %r8d, %r9d
	jz .ternary_true1
	movl $1, %r8d
	movl %r9d, %ecx
	cmpl %r8d, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %ecx
.ternary_end2:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .fib_6
.fib_5:
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.fib_6:
	movl %r9d, %edi
	subl $1, %edi
	movq %r9, %rbx
	callq _c0_fib
	movq %rbx, %r9
	movl %eax, %r8d
	movl %r9d, %edi
	subl $2, %edi
	movq %r8, %rbx
	callq _c0_fib
	movq %rbx, %r8
	movl %r8d, %r9d
	addl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %edi
	subl $1, %edi
	callq _c0_fib
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
