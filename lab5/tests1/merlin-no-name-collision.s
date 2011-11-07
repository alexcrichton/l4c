.file	"../tests1/merlin-no-name-collision.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl %r9d, %edi
	callq _c0_p
	movl $1, %r9d
	cmpl %eax, %r9d
	jnz .main_3
.main_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_3:
.main_4:
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_p:
	addq $-8, %rsp
.p_0:
	callq _c0_h
	addq $8, %rsp
	ret
_c0_h:
	addq $-8, %rsp
.h_0:
	movl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
