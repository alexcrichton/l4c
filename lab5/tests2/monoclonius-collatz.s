.file	"../tests2/monoclonius-collatz.l2"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $10000, %r8d
	movl $1, %ecx
.main_11:
.main_1:
	movl $1, %esi
	movl %ecx, %edx
	cmpl %r8d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_9
.main_2:
	movl %ecx, %edx
.main_13:
	movl %edx, %esi
.main_3:
	movl $1, %eax
	movl $1, %edi
	movl %esi, %edx
	cmpl %edi, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_8
.main_4:
	movl $2, %edi
	movl %esi, %eax
	cltd
	idivl %edi
	movl %edx, %edi
	movl $1, %ebx
	movl $0, %eax
	movl %edi, %edx
	cmpl %eax, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ebx
	jnz .main_6
.main_5:
	movl $2, %r9d
	movl %esi, %eax
	cltd
	idivl %r9d
	movl %eax, %r9d
.main_15:
	movl %eax, %esi
	movl %r9d, %edx
.main_7:
.main_12:
	movl %esi, %r9d
	movl %edx, %esi
	jmp .main_3
.main_6:
	movl $3, %edx
	imull %esi, %edx
	addl $1, %edx
.main_14:
	movl %r9d, %esi
	jmp .main_7
.main_8:
	addl $1, %ecx
.main_10:
	jmp .main_1
.main_9:
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
