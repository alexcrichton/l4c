.file	"../tests1/lammergeier-ivysaur.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	jmp .ternary_true1
	movl $3, %r9d
	jmp .ternary_end8
.ternary_true7:
	movl $4, %r9d
.ternary_end8:
	jmp .ternary_end2
.ternary_true1:
	movl $2, %r9d
	jmp .ternary_end6
.ternary_true5:
	movl $1, %r9d
.ternary_end6:
	jmp .ternary_end4
.ternary_true3:
	movl $0, %r9d
.ternary_end4:
.ternary_end2:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
