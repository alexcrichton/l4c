.file	"../tests2/trex-interesting02.l2"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r9d
	movl $1000, %ebx
	movl $3, %eax
	movl $5, %edi
	movl %eax, %esi
	imull %edi, %esi
	movl %eax, %r8d
.main_11:
	movl %r8d, %edx
	movl %r9d, %ecx
.main_1:
	movl $1, %r8d
	movl %edx, %r9d
	cmpl %ebx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_3
.main_2:
	movl %ecx, %r8d
	addl %edx, %r8d
	movl %edx, %r9d
	addl %eax, %r9d
.main_10:
	movl %r9d, %edx
	movl %r8d, %ecx
	jmp .main_1
.main_3:
	movl %edi, %r9d
.main_13:
	movl %r9d, %edx
.main_4:
	movl $1, %r8d
	movl %edx, %r9d
	cmpl %ebx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_6
.main_5:
	movl %ecx, %r8d
	addl %edx, %r8d
	movl %edx, %r9d
	addl %edi, %r9d
.main_12:
	movl %r9d, %edx
	movl %r8d, %ecx
	jmp .main_4
.main_6:
	movl %esi, %r9d
.main_15:
	movl %r9d, %edx
.main_7:
	movl $1, %r8d
	movl %edx, %r9d
	cmpl %ebx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_9
.main_8:
	movl %ecx, %r8d
	subl %edx, %r8d
	movl %edx, %r9d
	addl %esi, %r9d
.main_14:
	movl %r9d, %edx
	movl %r8d, %ecx
	jmp .main_7
.main_9:
	movl %ecx, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
