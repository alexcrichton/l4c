.file	"../tests2/galimimus-bool-ops.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $0, %ecx
	cmpl $0, %r9d
	jnz .ternary_true3
	movl $0, %r8d
	jmp .ternary_end4
.ternary_true3:
	movl $1, %r8d
	xorl %ecx, %r8d
.ternary_end4:
	cmpl $0, %r8d
	jnz .ternary_true1
	movl $1, %r8d
	cmpl %r9d, %r8d
	jnz .ternary_true5
	movl $0, %r9d
	jmp .ternary_end6
.ternary_true5:
	movl %ecx, %r9d
.ternary_end6:
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r9d
.ternary_end2:
	movl %r9d, %r8d
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .main_2
.main_1:
	movl $42, %eax
	addq $8, %rsp
	ret
.main_2:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
