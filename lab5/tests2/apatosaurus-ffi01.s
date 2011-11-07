.file	"../tests2/apatosaurus-ffi01.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $67, %edi
	callq printchar
	movl $9, %edi
	callq printint
	movl $255, %edi
	callq printhex
	movl $3, %edi
	callq printfloat
	movl $3, %edi
	callq tofloat
	movl $7, %edi
	callq fromfloat
	movl $99, %edi
	movl $101, %esi
	callq fadd
	movl $99, %edi
	movl $101, %esi
	callq fsub
	movl $99, %edi
	movl $101, %esi
	callq fmul
	movl $99, %edi
	movl $101, %esi
	callq fdiv
	movl $2, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
