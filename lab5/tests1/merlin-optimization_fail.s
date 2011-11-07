.file	"../tests1/merlin-optimization_fail.l3"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r8d
	movl $0, %r9d
.main_5:
	movl %r8d, %esi
.main_1:
	movl $1, %edx
	movl $5, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_3
.main_2:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_foo
	movq %rbx, %r9
	movl $0, %r8d
	imull %eax, %r8d
	addl $1, %r8d
	addl $1, %r9d
.main_4:
	movl %r8d, %esi
	jmp .main_1
.main_3:
	movl %esi, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_foo:
	addq $-8, %rsp
.foo_0:
	movl $15411, %eax
	movl %edi, %r9d
	subl $3, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
