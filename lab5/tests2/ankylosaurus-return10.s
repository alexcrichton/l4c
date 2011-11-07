.file	"../tests2/ankylosaurus-return10.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $2, %esi
	movl $3, %edx
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_2
.main_1:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_2:
	movl $1, %r8d
	movl %edx, %r9d
	cmpl %esi, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_4
.main_3:
	movl %esi, %eax
	addq $8, %rsp
	ret
.main_4:
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
