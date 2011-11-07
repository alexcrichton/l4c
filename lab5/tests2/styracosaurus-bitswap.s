.file	"../tests2/styracosaurus-bitswap.l3"
.globl _c0_main
_c0_swap:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
	movl %edx, %ebx
.swap_0:
	movl $0, %ecx
	cmpl %ecx, %r8d
	jl .ternary_true5
	movl $31, %ecx
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
	movl %ebx, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	jmp .ternary_end4
.ternary_true3:
	movl $1, %ecx
.ternary_end4:
	cmpl $0, %ecx
	jnz .ternary_true1
	movl $31, %ecx
	movl %ecx, %edx
	cmpl %ebx, %edx
	setl %dl
	movzbl %dl, %edx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %edx
.ternary_end2:
	movl $1, %ecx
	cmpl %edx, %ecx
	jnz .swap_3
.swap_1:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.swap_3:
.swap_4:
	movl $1, %eax
	movl %eax, %edx
	movl %r8d, %ecx
	sall %cl, %edx
	movl %r9d, %ecx
	andl %edx, %ecx
	movl %ecx, %edx
	movl %r8d, %ecx
	sarl %cl, %edx
	movl %eax, %esi
	movl %ebx, %ecx
	sall %cl, %esi
	movl %r9d, %ecx
	andl %esi, %ecx
	movl %ecx, %esi
	movl %ebx, %ecx
	sarl %cl, %esi
	movl %eax, %edi
	movl %r8d, %ecx
	sall %cl, %edi
	movl %ebx, %ecx
	sall %cl, %eax
	movl %edi, %ecx
	orl %eax, %ecx
	movl $-1, %eax
	xorl %ecx, %eax
	movl %r9d, %edi
	andl %eax, %edi
	movl %edx, %r9d
	movl %ebx, %ecx
	sall %cl, %r9d
	movl %esi, %edx
	movl %r8d, %ecx
	sall %cl, %edx
	movl %r9d, %r8d
	orl %edx, %r8d
	movl %edi, %r9d
	orl %r8d, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $16, %edi
	movl $1, %esi
	movl $4, %edx
	callq _c0_swap
	movl %eax, %r9d
	movl $1, %ecx
	movl $2, %r8d
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
