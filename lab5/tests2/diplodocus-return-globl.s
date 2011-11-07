.file	"../tests2/diplodocus-return-globl.l3"
.globl _c0_main
_c0_g_fun:
	addq $-8, %rsp
.g_fun_0:
	movl $2, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $1, %r8d
	cmpl %r9d, %r8d
	jnz .main_3
.main_1:
	callq _c0_g_fun
	addq $8, %rsp
	ret
.main_3:
.main_4:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_g_fun2:
	addq $-8, %rsp
.g_fun2_0:
	movl $1337, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
