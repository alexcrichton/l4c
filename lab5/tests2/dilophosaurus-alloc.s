.file	"../tests2/dilophosaurus-alloc.l4"
.globl _c0_main
_c0_boo:
	addq $-8, %rsp
.boo_0:
	cmpl $0, %edi
	jnz .ternary_true1
	movl $0, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r9d
.ternary_end2:
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq $1, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %r9, %r8
	movl $100, (%r8)
	movq %r9, %r8
	movl (%r8), %ecx
	movq %rax, %r8
	movl %ecx, (%r8)
	cmpq %rax, %r9
	sete %dil
	movzbl %dil, %edi
	callq _c0_boo
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
