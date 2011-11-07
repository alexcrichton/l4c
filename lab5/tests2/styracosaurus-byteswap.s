.file	"../tests2/styracosaurus-byteswap.l3"
.globl _c0_main
_c0_swap:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
	movl %edx, %esi
.swap_0:
	movl $0, %ecx
	cmpl %ecx, %r8d
	jl .ternary_true5
	movl $3, %ecx
	cmpl %r8d, %ecx
	setl %cl
	movzbl %cl, %ecx
	jmp .ternary_end6
.ternary_true5:
	movl $1, %ecx
.ternary_end6:
	cmpl $0, %ecx
	jnz .ternary_true3
	movl $0, %edx
	movl %esi, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	jmp .ternary_end4
.ternary_true3:
	movl $1, %ecx
.ternary_end4:
	cmpl $0, %ecx
	jnz .ternary_true1
	movl $3, %ecx
	cmpl %esi, %ecx
	setl %cl
	movzbl %cl, %ecx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %ecx
.ternary_end2:
	movl $1, %edx
	cmpl %ecx, %edx
	jnz .swap_3
.swap_1:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.swap_3:
.swap_4:
	movl $8, %eax
	imull %r8d, %eax
	movl $8, %ebx
	imull %esi, %ebx
	movl $255, %edi
	movl %edi, %r8d
	movl %eax, %ecx
	sall %cl, %r8d
	movl %r9d, %ecx
	andl %r8d, %ecx
	movl %ecx, %r8d
	movl %eax, %ecx
	sarl %cl, %r8d
	movl %edi, %edx
	movl %ebx, %ecx
	sall %cl, %edx
	movl %r9d, %ecx
	andl %edx, %ecx
	movl %ecx, %edx
	movl %ebx, %ecx
	sarl %cl, %edx
	movl %edi, %esi
	movl %eax, %ecx
	sall %cl, %esi
	movl %ebx, %ecx
	sall %cl, %edi
	movl %esi, %ecx
	orl %edi, %ecx
	movl $-1, %esi
	xorl %ecx, %esi
	andl %esi, %r9d
	movl %ebx, %ecx
	sall %cl, %r8d
	movl %eax, %ecx
	sall %cl, %edx
	orl %edx, %r8d
	orl %r8d, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $305419896, %edi
	movl $1, %esi
	movl $3, %edx
	callq _c0_swap
	movl %eax, %r9d
	movl $1, %ecx
	movl $1446253176, %r8d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_2
.main_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_2:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
