.file	"../tests0/return01.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $100, %r9d
	movl $0, %ecx
	movl $0, %r8d
.main_5:
	movl %r8d, %esi
	movl %ecx, %edx
.main_1:
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %r9d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_3
.main_2:
	movl %edx, %ecx
	addl %esi, %ecx
	movl %esi, %r8d
	addl $1, %r8d
.main_4:
	movl %r8d, %esi
	movl %ecx, %edx
	jmp .main_1
.main_3:
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
