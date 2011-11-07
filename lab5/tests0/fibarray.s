.file	"../tests0/fibarray.l4"
.globl _c0_main
_c0_fib:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.fib_0:
	movl %r9d, %r8d
	addl $1, %r8d
	movslq %r8d, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $1, (%r8)
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $1, (%r8)
	movl $2, %r8d
.fib_5:
	movl %r8d, %edi
.fib_1:
	movl $1, %ecx
	movl %edi, %r8d
	cmpl %r9d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .fib_3
.fib_2:
	movl %edi, %r8d
	subl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movl %edi, %r8d
	subl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl %edi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl %esi, (%r8)
	addl %edx, (%r8)
	movl %edi, %r8d
	addl $1, %r8d
.fib_4:
	movl %r8d, %edi
	jmp .fib_1
.fib_3:
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $10, %edi
	callq _c0_fib
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
