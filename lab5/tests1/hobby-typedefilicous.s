.file	"../tests1/hobby-typedefilicous.l3"
.globl _c0_main
_c0_someboringfunctionname:
	addq $-8, %rsp
.someboringfunctionname_0:
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	callq _c0_someboringfunctionname
	movl %eax, %ecx
	movl $1, %r8d
	movl $0, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_2
.main_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_2:
	movl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
