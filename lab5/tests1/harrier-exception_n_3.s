.file	"../tests1/harrier-exception_n_3.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %r8d
	movl $5, %r9d
.main_5:
.main_1:
	movl %r8d, %eax
	cltd
	idivl %r8d
	movl $1, %edx
	movl $0, %ecx
	cmpl %eax, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_3
.main_2:
	subl $1, %r8d
	subl $1, %r9d
.main_4:
	jmp .main_1
.main_3:
	movl $3, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
