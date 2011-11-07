.file	"../tests2/diplodocus-reverse.l3"
.globl _c0_main
_c0_reverse:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %r9d, %ebx
.reverse_0:
	cmpl %edx, %esi
	jl .ternary_true5
	movl $0, %r9d
	jmp .ternary_end6
.ternary_true5:
	movl %edx, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
.ternary_end6:
	cmpl $0, %r9d
	jnz .ternary_true3
	movl $0, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl %ecx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
.ternary_end4:
	cmpl $0, %r9d
	jnz .ternary_true1
	movl $0, %eax
	jmp .ternary_end2
.ternary_true1:
	movl %r8d, %eax
	cmpl %ebx, %eax
	setl %al
	movzbl %al, %eax
.ternary_end2:
	movl $1, %r9d
	cmpl %eax, %r9d
	jnz .reverse_3
.reverse_1:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.reverse_3:
.reverse_4:
	movl $1, %eax
	movl $1, %r12d
	movl %edi, %r9d
	cmpl %r12d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %eax
	jnz .reverse_7
.reverse_5:
	subl $1, %edi
	movl %ebx, %eax
	movl %esi, %r9d
	movl %eax, %esi
	callq _c0_reverse
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.reverse_7:
.reverse_8:
	movl $1, %eax
	movl $2, %r9d
	movl %edi, %r12d
	cmpl %r9d, %r12d
	sete %r12b
	movzbl %r12b, %r12d
	cmpl %r12d, %eax
	jnz .reverse_11
.reverse_9:
	subl $1, %edi
	movl %r8d, %eax
	movl %edx, %r8d
	movl %ebx, %r9d
	movl %eax, %edx
	callq _c0_reverse
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.reverse_11:
.reverse_12:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %edi
	movl $5, %esi
	movl $4, %edx
	movl $3, %ecx
	movl $2, %r8d
	movl $1, %r9d
	callq _c0_reverse
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .main_3
.main_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.main_3:
.main_4:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
