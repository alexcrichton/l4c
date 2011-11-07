.file	"../tests2/brachiosaurus-variable8.l2"
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
	movl $1, %ecx
	movl $1, %r9d
	movl $3, %r8d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_15
.main_11:
	movl $2, %r9d
.main_21:
	movl %r9d, %edx
.main_12:
	movl $1, %ecx
	movl $3, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_16
.main_13:
	movl %edx, %r9d
	addl $1, %r9d
	jmp .main_22
.main_16:
.main_19:
.main_20:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_15:
	movl $3, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_22:
	movl %r9d, %edx
	jmp .main_12
.ident	"15-411 L4 reference compiler"
