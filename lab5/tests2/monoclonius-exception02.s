.file	"../tests2/monoclonius-exception02.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r8d
	movl $5, %r9d
.main_5:
	movl %r8d, %eax
.main_1:
	movl $1, %ecx
	movl $1, %r8d
	cmpl %r8d, %ecx
	jnz .main_3
.main_2:
	cltd
	idivl %r9d
	movl %eax, %r8d
	subl $1, %r9d
.main_4:
	movl %r8d, %eax
	jmp .main_1
.main_3:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
