.file	"../tests1/condor-pow.l3"
.globl _c0_main
_c0_pow:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
.pow_0:
	movl $1, %esi
	movl $0, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .pow_3
.pow_1:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.pow_3:
.pow_4:
	movl $1, %edx
	movl $1, %ecx
	movl %r8d, %esi
	cmpl %ecx, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .pow_7
.pow_5:
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.pow_7:
.pow_8:
	movl $2, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl %r9d, %edi
	movl %eax, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_pow
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $2, %esi
	movl %r8d, %eax
	cltd
	idivl %esi
	movl %edx, %r8d
	movl %r9d, %edi
	movl %r8d, %esi
	movq %rcx, %rbx
	callq _c0_pow
	movq %rbx, %rcx
	movl %eax, %r9d
	movl %ecx, %r8d
	imull %ecx, %r8d
	movl %r8d, %eax
	imull %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $6, %r8d
	movl $4, %r9d
	movl %r8d, %edi
	movl %r9d, %esi
	callq _c0_pow
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
