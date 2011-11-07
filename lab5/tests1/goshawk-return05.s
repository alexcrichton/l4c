.file	"../tests1/goshawk-return05.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $1, %esi
	movl $2, %edx
	movl $5, %ecx
	movl $7, %r8d
	cmpl $0, %r9d
	jnz .ternary_true1
	cmpl $0, %esi
	jnz .ternary_true3
	movl %r8d, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl %ecx, %r9d
.ternary_end4:
	jmp .ternary_end2
.ternary_true1:
	movl %edx, %r9d
.ternary_end2:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
