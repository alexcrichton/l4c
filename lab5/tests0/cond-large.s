.file	"../tests0/cond-large.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	jmp .ternary_true1
	movq $0, %r9
	movq %rax, %rcx
	addq %r9, %rcx
	jmp .ternary_end2
.ternary_true1:
	movq $0, %r9
	movq %rax, %rcx
	addq %r9, %rcx
.ternary_end2:
	movq $0, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
