.file	"../tests1/lammergeier-venusaur.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	jmp .ternary_true1
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $20, %r9d
.ternary_end2:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
