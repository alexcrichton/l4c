.file	"../tests2/brachiosaurus-compare-little-little-test.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %r9d
	movl $5, %edx
	movl $1, %ecx
	movl %r9d, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_2
.main_1:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_2:
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
