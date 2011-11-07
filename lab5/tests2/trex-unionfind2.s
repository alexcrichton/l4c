.file	"../tests2/trex-unionfind2.l4"
.globl _c0_main
_c0_find:
	addq $-8, %rsp
.find_0:
	movl %esi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %ecx, %eax
	cmpl %r9d, %eax
	sete %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_union:
	addq $-8, %rsp
	movq %rdi, %r9
	movl %ecx, %eax
.union_0:
	movl %esi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, %edi
	movl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, %esi
	movl $0, %r8d
.union_8:
	movl %r8d, %edx
.union_1:
	movl $1, %ecx
	movl %edx, %r8d
	cmpl %eax, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .union_6
.union_2:
	movl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl $1, %ecx
	cmpl %edi, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .union_4
.union_3:
	movl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl %esi, (%r8)
.union_5:
	movl %edx, %r8d
	addl $1, %r8d
.union_7:
	movl %r8d, %edx
	jmp .union_1
.union_4:
	jmp .union_5
.union_6:
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_setup:
	addq $-8, %rsp
.setup_0:
	movl $0, %r8d
.setup_5:
	movl %r8d, %edx
.setup_1:
	movl $1, %ecx
	movl %edx, %r8d
	cmpl %esi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .setup_3
.setup_2:
	movl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl %edx, (%r8)
	movl %edx, %r8d
	addl $1, %r8d
.setup_4:
	movl %r8d, %edx
	jmp .setup_1
.setup_3:
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_query:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.query_0:
	movl $0, %ecx
.query_5:
	movl %ecx, %ebx
.query_1:
	movl $1, %ecx
	movl %r8d, %edx
	subl $1, %edx
	movl %ebx, %esi
	cmpl %edx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %ecx
	jnz .query_3
.query_2:
	movq %r9, %rdi
	movl %ebx, %esi
	movl %ebx, %edx
	addl $1, %edx
	movl %r8d, %ecx
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_union
	movq %r13, %r8
	movq %r12, %r9
	movl %ebx, %ecx
	addl $1, %ecx
.query_4:
	movl %ecx, %ebx
	jmp .query_1
.query_3:
	movq %r9, %rdi
	movl $0, %esi
	movl $99, %edx
	movl %r8d, %ecx
	callq _c0_find
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_go:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.go_0:
	movl $100, %r9d
	movslq %r9d, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movq %r8, %rdi
	movl %r9d, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_setup
	movq %r12, %r8
	movq %rbx, %r9
	movq %r8, %rdi
	movl %r9d, %esi
	callq _c0_query
	cmpl $0, %eax
	jnz .ternary_true1
	movl $0, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r9d
.ternary_end2:
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_go
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
