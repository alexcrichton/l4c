.file	"../tests2/stegosaurus-return06.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $25642, %r9d
	movl $0, %ecx
	movl $0, %r8d
.main_8:
	movl %ecx, %edx
	movl %r8d, %eax
.main_1:
	movl $1, %ecx
	movl %eax, %r8d
	cmpl %r9d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_6
.main_2:
	movl %eax, %r8d
.main_10:
	movl %edx, %edi
	movl %r8d, %esi
.main_3:
	movl $1, %edx
	movl %eax, %r8d
	imull %eax, %r8d
	movl %esi, %ecx
	imull %esi, %ecx
	addl %ecx, %r8d
	movl %r9d, %ecx
	imull %r9d, %ecx
	cmpl %ecx, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_5
.main_4:
	movl %edi, %ecx
	addl $1, %ecx
	movl %esi, %r8d
	addl $1, %r8d
.main_9:
	movl %ecx, %edi
	movl %r8d, %esi
	jmp .main_3
.main_5:
	movl %eax, %r8d
	addl $1, %r8d
.main_7:
	movl %edi, %edx
	movl %r8d, %eax
	jmp .main_1
.main_6:
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
