.file	"../tests1/harrier-exception_n_4.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
.main_9:
	movl %r9d, %r8d
.main_1:
	movl $1, %r9d
	movl $1, %ecx
	cmpl %ecx, %r9d
	jnz .main_7
.main_2:
	movl %r8d, %r9d
	addl $1, %r9d
	movl $10, %eax
	cltd
	idivl %r9d
	movl %eax, %r8d
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %edx, %r8d
	movl $1, %edx
	movl $4332423, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_5
.main_3:
	movl $5, %eax
	addq $8, %rsp
	ret
.main_5:
.main_6:
.main_8:
	movl %r9d, %r8d
	jmp .main_1
.main_7:
	movl $3, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
