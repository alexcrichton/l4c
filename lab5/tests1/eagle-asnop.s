.file	"../tests1/eagle-asnop.l4"
.globl _c0_main
_c0_read:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.read_0:
	callq eof
	movl $1, %r9d
	cmpl %eax, %r9d
	jnz .read_3
.read_1:
	movq $0, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.read_3:
.read_4:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq %r9, %rbx
	callq readint
	movq %rbx, %r9
	movq %r9, %r8
	movl %eax, (%r8)
	movq %r9, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $100, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq %r9, %rbx
	callq _c0_read
	movq %rbx, %r9
	movq %rax, %r8
	movl (%r8), %edx
	movl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, (%rcx)
	addl $5, (%rcx)
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
