.file	"../tests2/diplodocus-bubblesort.l3"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $4, %edi
	movl $2, %esi
	movl $3, %edx
	movl $1, %ecx
	movl $0, %r8d
	callq _c0_sort
	movl %eax, %r9d
	movl $66, %edi
	movl $4, %esi
	movl $5, %edx
	movl $3, %ecx
	movl $1, %r8d
	movq %r9, %rbx
	callq _c0_sort
	movq %rbx, %r9
	movl %eax, %ebx
	movl $0, %edi
	subl $1, %edi
	movl $5, %esi
	movl $0, %edx
	subl $3, %edx
	movl $2, %ecx
	movl $99999, %r8d
	movq %r9, %r12
	callq _c0_sort
	movq %r12, %r9
	movl %eax, %r8d
	cmpl $0, %r9d
	jnz .ternary_true3
	movl $0, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl %ebx, %r9d
.ternary_end4:
	cmpl $0, %r9d
	jnz .ternary_true1
	movl $0, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl %r8d, %r9d
.ternary_end2:
	movl $1, %r8d
	cmpl %r9d, %r8d
	jnz .main_2
.main_1:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_2:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_sort:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movl %ecx, %edi
	movl %r8d, %ebx
.sort_0:
	cmpl %esi, %r9d
	jl .ternary_true9
	movl $0, %r8d
	jmp .ternary_end10
.ternary_true9:
	movl %esi, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
.ternary_end10:
	cmpl $0, %r8d
	jnz .ternary_true7
	movl $0, %r8d
	jmp .ternary_end8
.ternary_true7:
	movl %edx, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
.ternary_end8:
	cmpl $0, %r8d
	jnz .ternary_true5
	movl $0, %ecx
	jmp .ternary_end6
.ternary_true5:
	movl %edi, %ecx
	cmpl %ebx, %ecx
	setl %cl
	movzbl %cl, %ecx
.ternary_end6:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .sort_3
.sort_1:
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.sort_3:
.sort_4:
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .sort_7
.sort_5:
	movl %esi, %eax
	movl %r9d, %esi
	movl %edi, %ecx
	movl %ebx, %r8d
	movl %eax, %edi
	callq _c0_sort
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.sort_7:
.sort_8:
	movl $1, %r8d
	movl %edx, %ecx
	cmpl %esi, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .sort_11
.sort_9:
	movl %r9d, %eax
	movl %esi, %ecx
	movl %edi, %r8d
	movl %ebx, %r9d
	movl %eax, %edi
	movl %edx, %esi
	movl %ecx, %edx
	movl %r8d, %ecx
	movl %r9d, %r8d
	callq _c0_sort
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.sort_11:
.sort_12:
	movl $1, %r8d
	movl %edi, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .sort_15
.sort_13:
	movl %r9d, %eax
	movl %edi, %ecx
	movl %edx, %r8d
	movl %ebx, %r9d
	movl %eax, %edi
	movl %ecx, %edx
	movl %r8d, %ecx
	movl %r9d, %r8d
	callq _c0_sort
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.sort_15:
.sort_16:
	movl $1, %ecx
	movl %ebx, %r8d
	cmpl %edi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .sort_19
.sort_17:
	movl %r9d, %eax
	movl %ebx, %ecx
	movl %edi, %r8d
	movl %eax, %edi
	callq _c0_sort
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.sort_19:
.sort_20:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
