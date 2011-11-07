.file	"../tests2/ankylosaurus-return03.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
	movl $1, %ecx
	movl $0, %r8d
.main_5:
	movl %r8d, %edi
	movl %ecx, %esi
.main_1:
	movl $1, %edx
	movl $5, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_3
.main_2:
	movl $10, %r8d
	imull %esi, %r8d
	movl %r8d, %ecx
	addl %r9d, %ecx
	movl %edi, %r8d
	addl $1, %r8d
.main_4:
	movl %r8d, %edi
	movl %ecx, %esi
	jmp .main_1
.main_3:
	movl %esi, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
