.file	"../tests1/harrier-exception_n_2.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $10, %r9d
.main_5:
.main_1:
	movl $123, %eax
	cltd
	idivl %r9d
	movl $1, %ecx
	movl $0, %r8d
	cmpl %eax, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_3
.main_2:
	subl $1, %r9d
.main_4:
	jmp .main_1
.main_3:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
