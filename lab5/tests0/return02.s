.file	"../tests0/return02.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $9, %r9d
	movl $1, %edx
	movl $1, %ecx
	movl $3, %r8d
.main_9:
	movl %r8d, %edi
	movl %ecx, %esi
.main_1:
	movl $1, %ecx
	movl %edi, %r8d
	cmpl %r9d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_3
.main_2:
	movl %esi, %r8d
	addl %edx, %r8d
	movl %esi, %edx
	movl %r8d, %ecx
	movl %edi, %r8d
	addl $1, %r8d
.main_8:
	movl %r8d, %edi
	movl %ecx, %esi
	jmp .main_1
.main_3:
	movl $1, %r8d
	movl $0, %r9d
	cmpl %edi, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_5
.main_4:
	movl %esi, %eax
	addq $8, %rsp
	ret
.main_5:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
