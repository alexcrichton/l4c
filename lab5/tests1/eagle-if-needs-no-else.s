.file	"../tests1/eagle-if-needs-no-else.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
	movl $1, %ecx
	movl $2, %r8d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_3
.main_1:
	movl $3, %eax
	addq $8, %rsp
	ret
.main_3:
.main_4:
	movl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
