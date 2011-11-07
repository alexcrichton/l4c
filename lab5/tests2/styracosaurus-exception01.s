.file	"../tests2/styracosaurus-exception01.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $9, %eax
	movl $1024, %r9d
	movl $1, %ecx
	movl $1, %r8d
	cmpl %r8d, %ecx
	jnz .main_1
.main_2:
	sarl $12, %r9d
.main_4:
	cltd
	idivl %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
