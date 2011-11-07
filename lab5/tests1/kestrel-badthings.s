.file	"../tests1/kestrel-badthings.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
.main_5:
.main_1:
	movl $1, %ecx
	movl $0, %r8d
	cmpl %r9d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_3
.main_2:
	movl %r9d, %eax
	cltd
	idivl %r9d
	movl %eax, %r9d
.main_4:
	jmp .main_1
.main_3:
	movl $42, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
