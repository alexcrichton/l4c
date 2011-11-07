.file	"../tests2/ouranosaurus-exception_left_to_right_fun_eval.l3"
.globl _c0_main
_c0_f1:
	addq $-8, %rsp
.f1_0:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
_c0_f2:
	addq $-8, %rsp
.f2_0:
	callq _c0_f2
	addl $1, %eax
	addq $8, %rsp
	ret
_c0_f3:
	addq $-8, %rsp
.f3_0:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	callq _c0_f1
	movl %eax, %r9d
	movq %r9, %rbx
	callq _c0_f2
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	callq _c0_f3
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
