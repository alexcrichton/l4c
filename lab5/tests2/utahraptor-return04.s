.file	"../tests2/utahraptor-return04.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl %r9d, %r8d
	addl $4, %r8d
	movl %r8d, %edx
	sall $3, %edx
	movl $0, %ecx
	subl $8, %ecx
	movl $4, %r8d
	imull %ecx, %r8d
	subl %r8d, %r9d
	movl %edx, %r8d
	cmpl %r9d, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .main_3
.main_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.main_3:
.main_4:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
