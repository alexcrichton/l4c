.file	"../tests1/kestrel-large-struct.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $1337, %rdi
	movq $44, %rsi
	callq calloc
	movl $42, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
