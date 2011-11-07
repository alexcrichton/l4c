.file	"../tests1/hobby-circular.l4"
.globl _c0_main
_c0_tail:
	addq $-8, %rsp
.tail_0:
	movl $1, %edx
	movq $0, %rcx
	movq %rdi, %r8
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .tail_3
.tail_1:
	movq $0, %rax
	addq $8, %rsp
	ret
.tail_3:
.tail_4:
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movl $1, %edx
	movq $0, %rcx
	cmpq %rcx, %r8
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .tail_7
.tail_5:
	movq %rdi, %rax
	addq $8, %rsp
	ret
.tail_7:
.tail_8:
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_tail
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $1, %rdi
	movq $16, %rsi
	callq calloc
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl $0, (%r9)
	movq $8, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq %rax, (%r9)
	movq %rax, %rdi
	callq _c0_tail
	movq %rax, %r9
	movq $0, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
