.file	"../tests1/hawk-shift.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2147483647, %r8d
	movl $0, %r9d
.main_5:
.main_1:
	movl $1, %esi
	movl $31, %edx
	movl %r9d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_3
.main_2:
	movl %r9d, %ecx
	sarl %cl, %r8d
	movl %r9d, %ecx
	sall %cl, %r8d
	addl $1, %r9d
.main_4:
	jmp .main_1
.main_3:
	movl %r8d, %r9d
	sarl $30, %r9d
	sarl $32, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
