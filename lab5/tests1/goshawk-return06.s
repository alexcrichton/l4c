.file	"../tests1/goshawk-return06.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $0, %ecx
	movl $1, %r8d
	cmpl %r9d, %r8d
	jnz .main_7
.main_1:
	movl $1, %r9d
	cmpl %ecx, %r9d
	jnz .main_3
.main_2:
	movl $15, %eax
	addq $8, %rsp
	ret
.main_3:
	movl $0, %eax
	subl $3, %eax
	addq $8, %rsp
	ret
.main_7:
.main_8:
	movl $22, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
