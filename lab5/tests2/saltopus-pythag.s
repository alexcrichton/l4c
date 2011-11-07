.file	"../tests2/saltopus-pythag.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
.main_15:
	movl %r9d, %edi
.main_1:
	movl $1, %ecx
	movl $1000, %r8d
	movl %edi, %r9d
	cmpl %r8d, %r9d
	setle %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_13
.main_2:
	movl $1, %r9d
.main_17:
	movl %r9d, %esi
.main_3:
	movl $1, %ecx
	movl $1000, %r8d
	subl %edi, %r8d
	movl %esi, %r9d
	cmpl %r8d, %r9d
	setle %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_12
.main_4:
	movl %edi, %r9d
	addl %esi, %r9d
	movl $1000, %edx
	subl %r9d, %edx
	movl $1, %ecx
	movl %edi, %r9d
	imull %edi, %r9d
	movl %esi, %r8d
	imull %esi, %r8d
	addl %r8d, %r9d
	movl %edx, %r8d
	imull %edx, %r8d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_10
.main_5:
	movl $1, %r8d
	movl %edi, %r9d
	cmpl %esi, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_8
.main_6:
	movl %edi, %r9d
	imull %esi, %r9d
	movl %r9d, %eax
	imull %edx, %eax
	addq $8, %rsp
	ret
.main_8:
.main_9:
.main_11:
	movl %esi, %r9d
	addl $1, %r9d
.main_16:
	movl %r9d, %esi
	jmp .main_3
.main_10:
	jmp .main_11
.main_12:
	movl %edi, %r9d
	addl $1, %r9d
.main_14:
	movl %r9d, %edi
	jmp .main_1
.main_13:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
