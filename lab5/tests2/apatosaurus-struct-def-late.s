.file	"../tests2/apatosaurus-struct-def-late.l4"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $1, %rdi
	movq $16, %rsi
	callq calloc
	movq %rax, %r9
	movq %r9, %rdi
	movl $50, %esi
	movq %r9, %rbx
	callq _c0_setLateVal
	movq %rbx, %r9
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rdi
	callq _c0_getLateVal
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_setLateVal:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.setLateVal_0:
	movq $8, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq $1, %rdi
	movq $4, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, (%rcx)
	movq $8, %rcx
	addq %rcx, %r9
	movq (%r9), %r9
	movq $0, %rcx
	addq %rcx, %r9
	movl %r8d, (%r9)
	movl $0, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_getLateVal:
	addq $-8, %rsp
.getLateVal_0:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
