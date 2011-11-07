.file	"../tests1/merlin-error-field-and-type-collision.l4"
.globl _c0_main
_c0_PEWPEW:
	addq $-8, %rsp
.PEWPEW_0:
	movl %edi, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %edi
	callq _c0_PEWPEW
	movl $1, %r9d
	cmpl %eax, %r9d
	jnz .main_2
.main_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.main_2:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
