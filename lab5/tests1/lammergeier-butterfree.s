.file	"../tests1/lammergeier-butterfree.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $305419896, %r9d
	movl $0, %r8d
.main_5:
	movl %r8d, %esi
	movl %r9d, %edx
.main_1:
	movl $1, %ecx
	movl $134217728, %r8d
	movl %esi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_3
.main_2:
	movl %edx, %r9d
	sarl $1, %r9d
	movl %r9d, %ecx
	andl $2147483647, %ecx
	movl %edx, %r9d
	sall $3, %r9d
	movl %edx, %r8d
	sall $7, %r8d
	xorl %r8d, %r9d
	andl $-2147483648, %r9d
	movl %ecx, %r8d
	orl %r9d, %r8d
	movl %esi, %r9d
	addl $1, %r9d
.main_4:
	movl %r9d, %esi
	movl %r8d, %edx
	jmp .main_1
.main_3:
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
