.file	"../tests2/monoclonius-loop01.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1024, %r9d
.main_5:
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
	movl %edx, %r9d
	addl $1024, %r9d
.main_4:
	movl %r9d, %edx
	jmp .main_1
.main_3:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
