.file	"../tests2/ankylosaurus-return07.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r8d
	movl $0, %r9d
.main_10:
.main_1:
	movl $1, %esi
	movl $6, %edx
	movl %r9d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_7
.main_2:
	movl $2, %ecx
	movl %r9d, %eax
	cltd
	idivl %ecx
	movl %edx, %ecx
	movl $1, %esi
	movl $0, %edx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_5
.main_3:
	movl %r9d, %ecx
	addl $1, %ecx
	jmp .main_9
.main_5:
	addl %r9d, %r8d
.main_6:
	addl $1, %r9d
.main_8:
	jmp .main_1
.main_7:
	movl %r8d, %eax
	addq $8, %rsp
	ret
.main_9:
	movl %ecx, %r9d
	jmp .main_1
.ident	"15-411 L4 reference compiler"
