.file	"../tests2/vulcanodon-exception04.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $0, %r8d
.main_1:
	movl $1, %edx
	movl $5, %ecx
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_9
.main_2:
	movl $0, %esi
.main_3:
	movl $1, %edx
	movl $5, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_11
.main_4:
	movl %esi, %r8d
	addl $1, %r8d
	jmp .main_10
.main_11:
.main_7:
	jmp .main_9
.main_9:
	movl $10, %eax
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
	jmp .main_9
.main_10:
	jmp .main_7
.ident	"15-411 L4 reference compiler"
