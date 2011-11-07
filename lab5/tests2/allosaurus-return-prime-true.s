.file	"../tests2/allosaurus-return-prime-true.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $19, %r9d
	movl $2, %r8d
.main_9:
	movl %r8d, %ecx
.main_1:
	movl $2, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl $1, %edx
	movl %ecx, %r8d
	cmpl %eax, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_7
.main_2:
	movl %r9d, %eax
	cltd
	idivl %ecx
	movl %edx, %r8d
	movl $1, %esi
	movl $0, %edx
	cmpl %edx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %esi
	jnz .main_5
.main_3:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_5:
.main_6:
	movl %ecx, %r8d
	addl $1, %r8d
.main_8:
	movl %r8d, %ecx
	jmp .main_1
.main_7:
	movl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
