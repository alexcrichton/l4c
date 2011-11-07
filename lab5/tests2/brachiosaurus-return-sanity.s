.file	"../tests2/brachiosaurus-return-sanity.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
	movl $2, %edx
	movl $1, %ecx
	movl %r9d, %r8d
	cmpl %edx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_10
.main_1:
	movl $1, %ecx
	movl %r9d, %r8d
	cmpl %edx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_7
.main_2:
	movl $1, %r8d
	cmpl %edx, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_4
.main_3:
	movl $2, %eax
	addq $8, %rsp
	ret
.main_4:
	movl $1, %eax
	addq $8, %rsp
	ret
.main_7:
	movl $3, %eax
	addq $8, %rsp
	ret
.main_10:
	movl $4, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
