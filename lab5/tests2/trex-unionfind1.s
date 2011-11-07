.file	"../tests2/trex-unionfind1.l4"
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
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.query_0:
	movq %r9, %rdi
	movl $0, %esi
	movl $1, %edx
	movl %r8d, %ecx
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_union
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $1, %esi
	movl $3, %edx
	movl %r8d, %ecx
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_union
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $4, %esi
	movl $5, %edx
	movl %r8d, %ecx
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_union
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $9, %esi
	movl $1, %edx
	movl %r8d, %ecx
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_union
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $5, %esi
	movl $9, %edx
	movl %r8d, %ecx
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_union
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $4, %esi
	movl $9, %edx
	movl %r8d, %ecx
	callq _c0_find
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_go:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.go_0:
	movl $10, %r9d
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
