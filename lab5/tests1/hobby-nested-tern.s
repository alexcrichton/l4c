.file	"../tests1/hobby-nested-tern.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $6, %r9d
	movl $5, %r8d
	cmpl %r8d, %r9d
	jl .ternary_true1
	movl $6, %r8d
	cmpl %r9d, %r8d
	jle .ternary_true5
	movl $1, %r8d
	jmp .ternary_end6
.ternary_true5:
	movl $8, %r8d
.ternary_end6:
	jmp .ternary_end2
.ternary_true1:
	movl $2, %r8d
	cmpl %r9d, %r8d
	jl .ternary_true3
	movl $3, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl $5, %r9d
.ternary_end4:
	movl %r9d, %r8d
.ternary_end2:
	movl %r8d, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
