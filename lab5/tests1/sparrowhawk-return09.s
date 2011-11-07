.file	"../tests1/sparrowhawk-return09.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $1, %r8d
	cmpl %r8d, %r9d
	jnz .main_2
.main_1:
.main_3:
	movl $1, %r8d
	movl $1, %r9d
	cmpl %r9d, %r8d
	jnz .main_6
.main_4:
	movl $9, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_6:
.main_7:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_2:
	jmp .main_3
.ident	"15-411 L4 reference compiler"
