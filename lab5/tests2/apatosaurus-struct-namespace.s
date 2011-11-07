.file	"../tests2/apatosaurus-struct-namespace.l4"
.globl _c0_main
_c0_balloon:
	addq $-8, %rsp
.balloon_0:
	movl $50, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $1, %rdi
	movq $8, %rsi
	callq calloc
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl $50, (%r9)
	movq $4, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl $1, (%r9)
	callq _c0_balloon
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
