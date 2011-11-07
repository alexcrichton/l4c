.file	"../tests2/dilophosaurus-block03.l2"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $-1, %r9d
	movl $0, %r8d
	movl %r8d, %ecx
	addl $1, %ecx
	movl %r9d, %r8d
	addl %ecx, %r8d
	movl $2, %r9d
	movl %r8d, %ebx
	addl %r9d, %ebx
	movl $1, %r9d
	movl $1, %r8d
	addl %r8d, %r9d
	movl $1, %r8d
	addl %r8d, %r9d
	movl $1, %ecx
	movl %r9d, %r8d
	addl %ecx, %r8d
	movl $1, %r9d
	addl %r9d, %r8d
	movl $1, %r9d
	addl %r9d, %r8d
	movl $1, %r9d
	movl %r8d, %eax
	addl %ecx, %eax
	movl $1, %edi
	movl $1, %esi
	movl $1, %ecx
	movl $1, %edx
	movl $1, %r8d
	addl %edi, %r9d
	addl %esi, %r9d
	addl %ecx, %r9d
	movl %r9d, %ecx
	addl %edx, %ecx
	movl $0, %r9d
	subl %r8d, %r9d
	movl $0, %r8d
	subl %r9d, %r8d
	movl %ecx, %r9d
	addl %r8d, %r9d
	movl %eax, %r8d
	imull %r9d, %r8d
	movl %ebx, %r9d
	orl %r8d, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
