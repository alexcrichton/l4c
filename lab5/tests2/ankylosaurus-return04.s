.file	"../tests2/ankylosaurus-return04.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $1, %r8d
	cmpl %r8d, %r9d
	jl .ternary_true1
	jmp .ternary_end2
.ternary_true1:
	movl %r9d, %r8d
.ternary_end2:
	movl %r8d, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
