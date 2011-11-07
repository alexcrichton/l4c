.file	"../tests2/saltopus-palindrome.l2"
.globl _c0_main
_c0_main:
	addq $-56, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
.main_0:
	movl $9, %r9d
.main_22:
.main_1:
	movl $1, %r8d
	movl $0, %ecx
	cmpl %r9d, %ecx
	setle %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .main_19
.main_2:
	movl %r9d, %r8d
	imull $100001, %r8d
	movl $9, %ecx
.main_24:
	movl %ecx, %r14d
.main_3:
	movl $1, %edx
	movl $0, %ecx
	cmpl %r14d, %ecx
	setle %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_18
.main_4:
	movl %r14d, %edx
	imull $10010, %edx
	movl %r8d, %ecx
	addl %edx, %ecx
	movl $9, %edx
.main_26:
	movl %r12d, 52(%rsp)
	movl %esi, %r13d
	movl %edx, %r15d
.main_5:
	movl $1, %esi
	movl $0, %edx
	cmpl %r15d, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_17
.main_6:
	movl %r15d, %edx
	imull $1100, %edx
	movl %ecx, %ebp
	addl %edx, %ebp
	movl $990, %edx
.main_28:
	movl 52(%rsp), %esi
	movl %r13d, %edi
	movl %edx, %r12d
.main_7:
	movl $1, %eax
	movl $100, %edx
	cmpl %r12d, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_16
.main_8:
	movl %ebp, %eax
	cltd
	idivl %r12d
	movl %edx, %r13d
	movl $1, 52(%rsp)
	movl $0, %eax
	movl %r13d, %edx
	cmpl %eax, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, 52(%rsp)
	jnz .main_14
.main_9:
	movl %ebp, %eax
	cltd
	idivl %r12d
	movl %eax, %edi
	movl $1, %esi
	movl $1000, %edx
	movl %edi, %ebx
	cmpl %edx, %ebx
	setl %bl
	movzbl %bl, %ebx
	cmpl %ebx, %esi
	jnz .main_12
.main_10:
	movl %ebp, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $56, %rsp
	ret
.main_12:
.main_13:
.main_30:
	movl %eax, %edx
	movl %edi, 52(%rsp)
.main_15:
	movl %r12d, %eax
	subl $1, %eax
.main_27:
	movl %edx, %esi
	movl 52(%rsp), %edi
	movl %r13d, %ebx
	movl %eax, %r12d
	jmp .main_7
.main_14:
.main_29:
	movl %esi, %edx
	movl %edi, 52(%rsp)
	jmp .main_15
.main_16:
	movl %r15d, %edx
	subl $1, %edx
.main_25:
	movl %esi, 52(%rsp)
	movl %edi, %r13d
	movl %r12d, %eax
	movl %ebp, %edi
	movl %edx, %r15d
	jmp .main_5
.main_17:
	movl %r14d, %edx
	subl $1, %edx
.main_23:
	movl 52(%rsp), %r12d
	movl %r13d, %esi
	movl %edx, %r14d
	jmp .main_3
.main_18:
	subl $1, %r9d
.main_21:
	jmp .main_1
.main_19:
	movl $7, %r9d
	movl %r9d, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $56, %rsp
	ret
.ident	"15-411 L4 reference compiler"
