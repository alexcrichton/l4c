.file	"../tests2/diplodocus-xorswap.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1337, %r9d
	movl $45887, %r8d
	xorl %r8d, %r9d
	movl %r9d, %edx
	xorl %r8d, %edx
	xorl %edx, %r9d
	movl $1, %ecx
	movl $45887, %r8d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_3
.main_1:
	movl %edx, %eax
	addq $8, %rsp
	ret
.main_3:
.main_4:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
