.file	"../tests2/velociraptor-return_13.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $0, %edx
	movl $1, %r8d
	cmpl %r9d, %r8d
	jnz .ternary_true1
	movl $1, %ecx
	xorl %edx, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %ecx
.ternary_end2:
	movl $1, %r8d
	xorl %ecx, %r8d
	cmpl $0, %r9d
	jnz .ternary_true5
	movl $1, %ecx
	xorl %edx, %ecx
	jmp .ternary_end6
.ternary_true5:
	movl $1, %ecx
.ternary_end6:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .ternary_true3
	movl $1, %r8d
	cmpl %r9d, %r8d
	jnz .ternary_true7
	movl %edx, %r8d
	jmp .ternary_end8
.ternary_true7:
	movl $1, %r8d
.ternary_end8:
	movl $1, %r9d
	xorl %r8d, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl $1, %r9d
.ternary_end4:
	movl $4, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
