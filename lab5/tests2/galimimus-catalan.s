.file	"../tests2/galimimus-catalan.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %eax
	movl $1, %ecx
	movl %ecx, %r9d
	movl $1, %r8d
.main_8:
	movl %r9d, %edx
	movl %ecx, %esi
	movl %r8d, %r9d
.main_1:
	movl $1, %ecx
	movl %r9d, %r8d
	cmpl %eax, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_3
.main_2:
	imull %r9d, %edx
	movl %r9d, %ecx
	imull %r9d, %ecx
	movl %esi, %r8d
	imull %ecx, %r8d
	addl $1, %r9d
.main_7:
	movl %r8d, %esi
	jmp .main_1
.main_3:
	movl %eax, %r8d
	addl $1, %r8d
	movl %esi, %r9d
	imull %r8d, %r9d
	movl %eax, %r8d
	addl $1, %r8d
.main_10:
	movl %edx, %edi
	movl %r8d, %esi
.main_4:
	movl $1, %edx
	movl $2, %ecx
	imull %eax, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_6
.main_5:
	movl %edi, %ecx
	imull %esi, %ecx
	movl %esi, %r8d
	addl $1, %r8d
.main_9:
	movl %ecx, %edi
	movl %r8d, %esi
	jmp .main_4
.main_6:
	movl %edi, %eax
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
