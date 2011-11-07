.file	"../tests1/eagle-lib.l3"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	callq readint
	movl $1, %ecx
	movl $3, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_3
.main_1:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_3:
.main_4:
	callq readhex
	movl $1, %ecx
	movl $-559026163, %r9d
	movl %eax, %r8d
	cmpl %r9d, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_7
.main_5:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_7:
.main_8:
	callq readfloat
	movl %eax, %r9d
	movq %r9, %rbx
	callq readfloat
	movq %rbx, %r9
	movl %eax, %ecx
	movl %r9d, %edi
	movl %ecx, %esi
	callq fadd
	movl %eax, %r9d
	movl %r9d, %edi
	callq fromfloat
	movl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
