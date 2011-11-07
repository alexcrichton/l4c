.file	"../tests2/diplodocus-return-tco.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1000, %edi
	callq _c0_nice
	addq $8, %rsp
	ret
_c0_nice:
	addq $-8, %rsp
.nice_0:
	movl $1, %edx
	movl $1, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .nice_3
.nice_1:
	movl $1337, %eax
	addq $8, %rsp
	ret
.nice_3:
.nice_4:
	subl $1, %edi
	callq _c0_nice
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
