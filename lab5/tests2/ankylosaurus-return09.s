.file	"../tests2/ankylosaurus-return09.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $0, %ecx
	cmpl $0, %r9d
	jnz .ternary_true7
	movl %ecx, %r8d
	jmp .ternary_end8
.ternary_true7:
	movl $1, %r8d
.ternary_end8:
	cmpl $0, %r8d
	jnz .ternary_true5
	movl $0, %r8d
	jmp .ternary_end6
.ternary_true5:
	movl %ecx, %r8d
.ternary_end6:
	cmpl $0, %r8d
	jnz .ternary_true3
	cmpl $0, %r9d
	jnz .ternary_true13
	movl $0, %r8d
	jmp .ternary_end14
.ternary_true13:
	movl $1, %r8d
	xorl %ecx, %r8d
.ternary_end14:
	cmpl $0, %r8d
	jnz .ternary_true11
	movl $0, %r8d
	jmp .ternary_end12
.ternary_true11:
	movl %ecx, %r8d
.ternary_end12:
	cmpl $0, %r8d
	jnz .ternary_true9
	movl $0, %r8d
	jmp .ternary_end10
.ternary_true9:
	movl %r9d, %r8d
.ternary_end10:
	movl %r8d, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl $1, %r9d
.ternary_end4:
	cmpl $0, %r9d
	jnz .ternary_true1
	movl %ecx, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r9d
.ternary_end2:
	movl %r9d, %r8d
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .main_2
.main_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_2:
	movl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
