.file	"../tests1/eagle-shift.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $0, %ecx
	subl $2, %ecx
	sall %cl, %r9d
.main_9:
	movl %r9d, %eax
.main_1:
	movl $1, %r9d
	movl $1, %r8d
	cmpl %r8d, %r9d
	jnz .main_7
.main_2:
	movl $1, %ecx
	movl $1, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_5
.main_3:
	addq $8, %rsp
	ret
.main_5:
.main_6:
	movl $2, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
.main_8:
	movl %r9d, %eax
	jmp .main_1
.main_7:
	movl $4, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
