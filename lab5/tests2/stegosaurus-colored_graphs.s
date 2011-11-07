.file	"../tests2/stegosaurus-colored_graphs.l3"
.globl _c0_main
_c0_pow:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movl %esi, %edx
.pow_0:
	movl $1, %esi
	movl $1, %r8d
	movl %edx, %ecx
	cmpl %r8d, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .pow_3
.pow_1:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.pow_3:
.pow_4:
	movl %r9d, %edi
	movl %edx, %esi
	subl $1, %esi
	movq %r9, %rbx
	callq _c0_pow
	movq %rbx, %r9
	imull %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_choose:
	addq $-8, %rsp
	movl %edi, %r9d
	movl %esi, %r8d
.choose_0:
	movl $1, %ecx
	movl %r9d, %edx
.choose_8:
	movl %edx, %edi
	movl %ecx, %edx
.choose_1:
	movl $1, %esi
	movl %r8d, %ecx
	cmpl %edi, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .choose_3
.choose_2:
	imull %edi, %edx
	movl %edi, %ecx
	subl $1, %ecx
.choose_7:
	movl %ecx, %edi
	jmp .choose_1
.choose_3:
	movl $2, %ecx
.choose_10:
	movl %edx, %eax
.choose_4:
	movl $1, %edi
	movl %r9d, %esi
	subl %r8d, %esi
	movl %ecx, %edx
	cmpl %esi, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .choose_6
.choose_5:
	cltd
	idivl %ecx
	movl %eax, %edx
	addl $1, %ecx
.choose_9:
	movl %edx, %eax
	jmp .choose_4
.choose_6:
	addq $8, %rsp
	ret
_c0_a:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
.a_0:
	movl $0, %edx
	movl $1, %ecx
	movl $1, %edi
	movl %r8d, %esi
	cmpl %edi, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %ecx
	jnz .a_3
.a_1:
	movl $1, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.a_3:
.a_4:
	movl $1, %esi
.a_9:
	movl %edx, %ecx
	movl %esi, %ebx
.a_5:
	movl $1, %esi
	movl %ebx, %edx
	cmpl %r9d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .a_7
.a_6:
	movl %r9d, %edi
	movl %ebx, %esi
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_choose
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %r12d
	movl $2, %edi
	movl %r9d, %esi
	subl %ebx, %esi
	movl %ebx, %edx
	imull %esi, %edx
	movl %edx, %esi
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq _c0_pow
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %eax, %edx
	movl %ebx, %edi
	movl %r8d, %esi
	subl $1, %esi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq _c0_a
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl %r12d, %esi
	imull %edx, %esi
	movl %esi, %edx
	imull %eax, %edx
	addl %edx, %ecx
	movl %ebx, %edx
	addl $1, %edx
.a_8:
	movl %edx, %ebx
	jmp .a_5
.a_7:
	movl %ecx, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $7, %edi
	movl $4, %esi
	callq _c0_a
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
