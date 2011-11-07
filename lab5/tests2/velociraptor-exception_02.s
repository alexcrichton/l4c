.file	"../tests2/velociraptor-exception_02.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $5, %eax
	movl $0, %r9d
	movl $1, %edx
	movl $1, %ecx
	movl $1, %r8d
	cmpl %edx, %r8d
	jnz .main_2
.main_1:
	cltd
	idivl %r9d
	movl %eax, %r9d
.main_5:
.main_3:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_2:
.main_4:
	movl %ecx, %r9d
	jmp .main_3
.ident	"15-411 L4 reference compiler"
