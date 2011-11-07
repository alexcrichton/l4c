.file	"../tests0/empty.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $2000, %rdi
	movq $0, %rsi
	callq calloc
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
