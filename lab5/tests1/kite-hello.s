.file	"../tests1/kite-hello.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $72, %edi
	callq printchar
	movl $101, %edi
	callq printchar
	movl $108, %edi
	callq printchar
	movl $108, %edi
	callq printchar
	movl $111, %edi
	callq printchar
	movl $44, %edi
	callq printchar
	movl $32, %edi
	callq printchar
	movl $119, %edi
	callq printchar
	movl $111, %edi
	callq printchar
	movl $114, %edi
	callq printchar
	movl $108, %edi
	callq printchar
	movl $100, %edi
	callq printchar
	movl $33, %edi
	callq printchar
	movl $10, %edi
	callq printchar
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
