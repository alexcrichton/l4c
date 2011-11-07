.file	"../tests2/vulcanodon-exception05.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $100, %esi
	movl $100000, %r9d
.main_1:
	movl $1, %ecx
	movl $0, %r8d
	cmpl %r8d, %ecx
	jnz .main_4
.main_2:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_4:
.main_9:
	movl %r9d, %eax
	movl %esi, %ecx
.main_5:
	movl $1, %r8d
	movl $1, %r9d
	cmpl %r9d, %r8d
	jnz .main_7
.main_6:
	movl %ecx, %r9d
	subl $1, %r9d
	cltd
	idivl %r9d
	movl %eax, %r8d
.main_8:
	movl %r8d, %eax
	movl %r9d, %ecx
	jmp .main_5
.main_7:
	movl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
