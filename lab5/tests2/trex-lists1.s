.file	"../tests2/trex-lists1.l4"
.globl _c0_main
_c0_length:
	addq $-8, %rsp
.length_0:
	movq $0, %r8
	cmpq %r8, %rdi
	jz .ternary_true1
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_length
	movl $1, %r9d
	addl %eax, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $0, %r9d
.ternary_end2:
	movl %r9d, %eax
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
	movl $1, (%r9)
	movq $8, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq %rax, (%r9)
	movq %rax, %rdi
	callq _c0_length
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
