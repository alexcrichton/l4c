.file	"../tests1/condor-return01.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
.main_5:
	movl %r9d, %edx
.main_1:
	movl $1, %ecx
	movl $3, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_3
.main_2:
	movl %edx, %r9d
	addl $1, %r9d
.main_4:
	movl %r9d, %edx
	jmp .main_1
.main_3:
	movl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
