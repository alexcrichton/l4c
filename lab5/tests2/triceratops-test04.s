.file	"../tests2/triceratops-test04.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $0, %esi
.main_1:
	movl $1, %edx
	movl $0, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edx
	jnz .main_4
.main_2:
	movl %esi, %eax
	addq $8, %rsp
	ret
.main_4:
	movl %esi, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
