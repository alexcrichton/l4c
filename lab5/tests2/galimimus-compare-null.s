.file	"../tests2/galimimus-compare-null.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %ecx
	movq $0, %r8
	movq $0, %r9
	cmpq %r9, %r8
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_2
.main_1:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
.main_3:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_2:
	jmp .main_3
.ident	"15-411 L4 reference compiler"
