.file	"../tests2/apatosaurus-struct-padding.l4"
.globl _c0_main
_c0_getit:
	addq $-8, %rsp
.getit_0:
	movq $72, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %rcx
	movl $0, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $104, %rsi
	callq calloc
	movq %rax, %r9
	movq $72, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq $1, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%r8)
	movq $72, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %rdx
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl $1, (%r8)
	movq %r9, %rdi
	callq _c0_getit
	cmpl $0, %eax
	jnz .ternary_true1
	movl $0, %r9d
	subl $1, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $10, %r9d
.ternary_end2:
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
