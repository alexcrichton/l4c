.file	"../tests2/brachiosaurus-tpain.l1"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $1, %r9d
	movl $2, %r8d
	movl $4, %ebx
	movl $8, %ecx
	movl $16, %edi
	movl $1, %esi
	movl %edi, %eax
	cltd
	idivl %esi
	movl $1, %esi
	cltd
	idivl %esi
	movl $1, %esi
	cltd
	idivl %esi
	cltd
	idivl %edi
	movl %eax, %esi
	movl %ebx, %eax
	cltd
	idivl %ecx
	movl %esi, %ecx
	subl $1, %ecx
	addl %r8d, %ecx
	subl %r8d, %ecx
	subl %r8d, %ecx
	subl %r8d, %ecx
	subl %r8d, %ecx
	subl %r8d, %ecx
	subl %r8d, %ecx
	subl %r8d, %ecx
	subl %r8d, %ecx
	subl %r8d, %ecx
	movl %ecx, %edx
	subl %r8d, %edx
	movl %eax, %ecx
	imull %r8d, %ecx
	imull %r8d, %ecx
	imull %r8d, %ecx
	imull %r8d, %ecx
	imull %r8d, %ecx
	imull %r8d, %ecx
	imull %r8d, %ecx
	movl %ecx, %r8d
	imull %r9d, %r8d
	movl %edx, %eax
	addl %r8d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
