.file	"../tests2/monoclonius-val02.l3"
.globl _c0_main
_c0_exp:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
.exp_0:
	movl $1, %ecx
	movl $0, %esi
	movl %r8d, %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .exp_3
.exp_1:
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.exp_3:
.exp_4:
	movl $2, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl %edx, %ecx
	movl $1, %esi
	movl $1, %edx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .exp_6
.exp_5:
	movl $2, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl %r9d, %edi
	imull %r9d, %edi
	movl %eax, %esi
	movq %r9, %rbx
	callq _c0_exp
	movq %rbx, %r9
	imull %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.exp_6:
	movl $2, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl %r9d, %edi
	imull %r9d, %edi
	movl %eax, %esi
	callq _c0_exp
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %edi
	movl $134217728, %esi
	callq _c0_exp
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
