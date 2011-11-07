.file	"../tests2/diplodocus-compound.l3"
.globl _c0_main
_c0_foo:
	addq $-8, %rsp
.foo_0:
	movl %edi, %eax
	imull %esi, %eax
	addq $8, %rsp
	ret
_c0_boo:
	addq $-8, %rsp
.boo_0:
	cmpl $0, %edi
	jnz .ternary_true1
	movl $0, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl %esi, %r9d
.ternary_end2:
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_fooboo:
	addq $-8, %rsp
.fooboo_0:
	movl $2, %eax
	imull %edi, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $44, %r9d
	movl $10, %r8d
	movl %r9d, %edi
	movl %r8d, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_foo
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl %r8d, %edi
	movl %r9d, %esi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_foo
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl $1, %edi
	movl $1, %esi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_boo
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %ecx, %edi
	movl %eax, %esi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_fooboo
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ecx
	movl %r9d, %edi
	movl %r9d, %esi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_foo
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %esi
	addl %ecx, %edx
	movl %edx, %ecx
	cmpl %eax, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_2
.main_1:
	movl %r9d, %edi
	movl %r8d, %esi
	movq %r9, %rbx
	callq _c0_foo
	movq %rbx, %r9
	movl %eax, %r8d
	movl %r9d, %edi
	movl %r9d, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_foo
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edi
	movl %r8d, %esi
	cmpl %eax, %esi
	setl %sil
	movzbl %sil, %esi
	movq %r9, %rbx
	callq _c0_boo
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true3
	movl $0, %r8d
	jmp .ternary_end4
.ternary_true3:
	movl %r9d, %edi
	movl $0, %esi
	callq _c0_fooboo
	movl %eax, %r8d
.ternary_end4:
	movl %r8d, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.main_2:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
