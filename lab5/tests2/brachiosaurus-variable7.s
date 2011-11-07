.file	"../tests2/brachiosaurus-variable7.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $2, %r8d
	movl $3, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %r9d
	jnz .main_10
.main_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_10:
	movl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
