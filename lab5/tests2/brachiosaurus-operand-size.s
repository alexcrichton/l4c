.file	"../tests2/brachiosaurus-operand-size.l4"
.globl _c0_main
_c0_arg:
	addq $-8, %rsp
	movq %r9, %rax
.arg_0:
	movq $0, %r9
	cmpq %r9, %rdi
	jz .ternary_true9
	movq $0, %rdi
	movq %rsi, %r9
	cmpq %rdi, %r9
	sete %r9b
	movzbl %r9b, %r9d
	jmp .ternary_end10
.ternary_true9:
	movl $1, %r9d
.ternary_end10:
	cmpl $0, %r9d
	jnz .ternary_true7
	movq $0, %r9
	cmpq %r9, %rdx
	sete %r9b
	movzbl %r9b, %r9d
	jmp .ternary_end8
.ternary_true7:
	movl $1, %r9d
.ternary_end8:
	cmpl $0, %r9d
	jnz .ternary_true5
	movq $0, %rdx
	movq %rcx, %r9
	cmpq %rdx, %r9
	sete %r9b
	movzbl %r9b, %r9d
	jmp .ternary_end6
.ternary_true5:
	movl $1, %r9d
.ternary_end6:
	cmpl $0, %r9d
	jnz .ternary_true3
	movq $0, %rcx
	movq %r8, %r9
	cmpq %rcx, %r9
	sete %r9b
	movzbl %r9b, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl $1, %r9d
.ternary_end4:
	cmpl $0, %r9d
	jnz .ternary_true1
	movq $0, %r8
	movq %rax, %r9
	cmpq %r8, %r9
	sete %r8b
	movzbl %r8b, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r8d
.ternary_end2:
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .arg_2
.arg_1:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	addq $8, %rsp
	ret
.arg_2:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	addq $8, %rsp
	ret
_c0_blarg:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.blarg_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %rcx
	movq $1, %rdi
	movq $4, %rsi
	movq %rcx, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movq $1, %rdi
	movq $4, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rdx
	movq $1, %rdi
	movq $4, %rsi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rbx
	movq $1, %rdi
	movq $4, %rsi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq calloc
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, %rdi
	movq %r9, %r12
	movq %rcx, %rsi
	movq %r8, %rax
	movq %rdx, %rcx
	movq %rbx, %r8
	movq %rdi, %r9
	movq %r12, %rdi
	movq %rax, %rdx
	callq _c0_arg
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq %rax, %r9
	movq $4, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $5, (%r8)
	movq %r9, %rbx
	callq _c0_blarg
	movq %rbx, %r9
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $-559038737, (%r8)
	movq $4, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
