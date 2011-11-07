.file	"../tests1/sparrowhawk-return08.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $1, %ecx
	movl $1, %r8d
	cmpl %r8d, %ecx
	jnz .main_6
.main_1:
	movl $1, %ecx
	movl $0, %r8d
	cmpl %r8d, %ecx
	jnz .main_2
.main_3:
	addl $1, %r9d
.main_5:
.main_9:
.main_7:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_2:
	movl $1, %eax
	addq $8, %rsp
	ret
.main_6:
.main_8:
	jmp .main_7
.ident	"15-411 L4 reference compiler"
