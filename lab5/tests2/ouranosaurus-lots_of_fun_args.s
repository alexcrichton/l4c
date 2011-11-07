.file	"../tests2/ouranosaurus-lots_of_fun_args.l3"
.globl _c0_main
_c0_this_fun_has_lots_of_args:
	addq $-8, %rsp
.this_fun_has_lots_of_args_0:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-120, %rsp
.main_0:
	movl $0, %edi
	movl $0, %esi
	movl $0, %edx
	movl $0, %ecx
	movl $0, %r8d
	movl $1, %r9d
	movl $0, 0(%rsp)
	movl $0, 8(%rsp)
	movl $1, 16(%rsp)
	movl $0, 24(%rsp)
	movl $0, 32(%rsp)
	movl $0, 40(%rsp)
	movl $0, 48(%rsp)
	movl $0, 56(%rsp)
	movl $0, 64(%rsp)
	movl $1, 72(%rsp)
	movl $0, 80(%rsp)
	movl $1, 88(%rsp)
	movl $0, 96(%rsp)
	movl $0, 104(%rsp)
	callq _c0_this_fun_has_lots_of_args
	addq $120, %rsp
	ret
.ident	"15-411 L4 reference compiler"
