.file	"../tests2/ouranosaurus-precedence_nightmare.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $13, %r9d
	movl $3, %ecx
	movl $5, %esi
	movl $48, %eax
	movl $4, %r8d
	movl %r9d, %edx
	imull %ecx, %edx
	movl $-1, %ecx
	xorl $-1, %ecx
	sarl $1, %ecx
	andl %ecx, %esi
	addl %esi, %edx
	movl $0, %ecx
	cmpl %ecx, %edx
	jz .ternary_true3
	movl $0, %ecx
	jmp .ternary_end4
.ternary_true3:
	movl $1, %ecx
.ternary_end4:
	cmpl $0, %ecx
	jnz .ternary_true1
	cltd
	idivl %r8d
	movl $88, %r8d
	cmpl %eax, %r8d
	jz .ternary_true5
	movl $0, %r8d
	subl %r9d, %r8d
	jmp .ternary_end6
.ternary_true5:
	movl $5, %eax
	movl $3, %r9d
	cltd
	idivl %r9d
	movl %edx, %r8d
.ternary_end6:
	movl %r8d, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $12, %r9d
.ternary_end2:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
