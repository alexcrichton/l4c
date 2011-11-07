.file	"../tests2/saltopus-popcount-loop.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $309634783, %r9d
	movl $0, %r8d
.main_5:
	movl %r8d, %esi
	movl %r9d, %edx
.main_1:
	movl $1, %ecx
	movl $0, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_3
.main_2:
	movl %esi, %ecx
	addl $1, %ecx
	movl %edx, %r8d
	subl $1, %r8d
	movl %edx, %r9d
	andl %r8d, %r9d
.main_4:
	movl %ecx, %esi
	movl %r9d, %edx
	jmp .main_1
.main_3:
	movl %esi, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
