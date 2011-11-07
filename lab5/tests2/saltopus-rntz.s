.file	"../tests2/saltopus-rntz.l4"
.globl _c0_main
_c0_RNtz:
	addq $-8, %rsp
.RNtz_0:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movq $4, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	cmpl %r8d, %edx
	jz .ternary_true3
	movl $0, %ecx
	jmp .ternary_end4
.ternary_true3:
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %edx, %ecx
	cmpl %r8d, %ecx
	sete %cl
	movzbl %cl, %ecx
.ternary_end4:
	cmpl $0, %ecx
	jnz .ternary_true1
	movl $0, %r8d
	jmp .ternary_end2
.ternary_true1:
	movq $4, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movq $8, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %ecx, %r8d
	cmpl %r9d, %r8d
	sete %r8b
	movzbl %r8b, %r8d
.ternary_end2:
	movl %r8d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $12, %rsi
	callq calloc
	movl $42, %r9d
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl %r9d, (%r8)
	movq $4, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl %r9d, (%r8)
	movq $8, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl %r9d, (%r8)
	movq %rax, %rdi
	movq %r9, %rbx
	callq _c0_RNtz
	movq %rbx, %r9
	movl $1, %r8d
	cmpl %eax, %r8d
	jnz .main_3
.main_1:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_3:
.main_4:
	movl %r9d, %eax
	subl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
