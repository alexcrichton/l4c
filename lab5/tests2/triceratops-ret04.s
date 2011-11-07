.file	"../tests2/triceratops-ret04.l4"
.globl _c0_main
_c0_a:
	addq $-8, %rsp
.a_0:
	movq $0, %r8
	cmpq %r8, %rdi
	jz .ternary_true1
	movl $1, %r9d
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
	movq $0, %r9
	movq %r9, %rdi
	callq _c0_a
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
