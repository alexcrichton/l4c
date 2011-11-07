.file	"../tests1/hobby-oom.l3"
.globl _c0_main
_c0_abs:
	addq $-8, %rsp
.abs_0:
	movl $0, %r8d
	cmpl %r8d, %edi
	jl .ternary_true1
	movl %edi, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl $0, %r8d
	subl %edi, %r8d
.ternary_end2:
	movl %r8d, %eax
	addq $8, %rsp
	ret
_c0_dammit:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.dammit_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_abs
	movq %rbx, %r9
	movl %eax, %r8d
	movl %r9d, %edi
	subl $1, %edi
	movq %r8, %rbx
	callq _c0_dammit
	movq %rbx, %r8
	addl %eax, %r8d
	movl %r8d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $10, %edi
	callq _c0_dammit
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
