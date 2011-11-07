.file	"../tests2/diplodocus-conditionalnest.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $2, %esi
	movl $3, %edx
	movl $4, %ecx
	movl $1, %r8d
	cmpl %r9d, %r8d
	jle .ternary_true1
	movl $3, %r8d
	cmpl %r8d, %edx
	jz .ternary_true7
	movl %r9d, %r8d
	jmp .ternary_end8
.ternary_true7:
	movl %ecx, %r8d
.ternary_end8:
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r8d
	cmpl %r8d, %esi
	jl .ternary_true3
	movl %edx, %r8d
	jmp .ternary_end4
.ternary_true3:
	movl $5, %r8d
	cmpl %ecx, %r8d
	jle .ternary_true5
	movl %esi, %r8d
	jmp .ternary_end6
.ternary_true5:
	movl %r9d, %r8d
.ternary_end6:
.ternary_end4:
.ternary_end2:
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
