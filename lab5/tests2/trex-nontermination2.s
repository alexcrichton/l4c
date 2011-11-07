.file	"../tests2/trex-nontermination2.l3"
.globl _c0_main
_c0_f:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.f_0:
	movl $0, %r8d
	cmpl %r9d, %r8d
	jl .ternary_true1
	movl %r9d, %edi
	addl $1, %edi
	movq %r9, %rbx
	callq _c0_g
	movq %rbx, %r9
	movl %eax, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl %r9d, %edi
	subl $1, %edi
	callq _c0_g
	movl %eax, %r8d
.ternary_end2:
	movl %r8d, %r9d
	movl %r9d, %eax
	addl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_g:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.g_0:
	movl $0, %r8d
	cmpl %r8d, %r9d
	jl .ternary_true3
	movl %r9d, %edi
	subl $1, %edi
	movq %r9, %rbx
	callq _c0_f
	movq %rbx, %r9
	movl %eax, %r8d
	jmp .ternary_end4
.ternary_true3:
	movl %r9d, %edi
	addl $1, %edi
	callq _c0_f
	movl %eax, %r8d
.ternary_end4:
	movl %r8d, %r9d
	movl %r9d, %eax
	addl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %edi
	callq _c0_f
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
