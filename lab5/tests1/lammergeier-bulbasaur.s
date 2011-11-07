.file	"../tests1/lammergeier-bulbasaur.l2"
.globl _c0_main
_c0_main:
	addq $-88, %rsp
	movq %rbp, 4(%rsp)
	movq %r15, 12(%rsp)
	movq %r14, 20(%rsp)
	movq %r13, 28(%rsp)
	movq %r12, 36(%rsp)
	movq %rbx, 44(%rsp)
.main_0:
	movl $16, %eax
	movl $26, %r9d
	cltd
	idivl %r9d
	movl %eax, 52(%rsp)
	movl $19, %eax
	movl $9, %r9d
	cltd
	idivl %r9d
	movl %edx, 56(%rsp)
	movl $21, %eax
	movl $17, %r9d
	cltd
	idivl %r9d
	movl %edx, 60(%rsp)
	movl $15, %eax
	imull $16, %eax
	movl $5, %r9d
	cltd
	idivl %r9d
	movl %edx, 64(%rsp)
	movl $18, %eax
	movl $4, %r9d
	cltd
	idivl %r9d
	movl %edx, 68(%rsp)
	movl $27, %eax
	movl $17, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
	movl $17, %eax
	imull $17, %eax
	movl $20, %r8d
	cltd
	idivl %r8d
	movl %eax, %r8d
	movl $8, %eax
	movl $30, %ecx
	cltd
	idivl %ecx
	movl %eax, %r14d
	movl $4, %eax
	movl $23, %ecx
	cltd
	idivl %ecx
	movl %eax, %r15d
	movl $14, %eax
	movl $27, %ecx
	cltd
	idivl %ecx
	movl %edx, %eax
	movl $13, %ecx
	cltd
	idivl %ecx
	movl %edx, %esi
	movl $14, %eax
	movl $15, %ecx
	cltd
	idivl %ecx
	movl %edx, %edi
	movl $21, %eax
	movl $29, %ecx
	cltd
	idivl %ecx
	movl %eax, %ebx
	movl $15, %eax
	movl $32, %ecx
	cltd
	idivl %ecx
	movl $2, %ecx
	cltd
	idivl %ecx
	movl %edx, %r12d
	movl $26, %eax
	movl $31, %ecx
	cltd
	idivl %ecx
	movl %edx, %r13d
	movl $28, %eax
	movl $6, %ecx
	cltd
	idivl %ecx
	movl %eax, %ebp
	movl $14, %eax
	movl $14, %ecx
	cltd
	idivl %ecx
	movl %edx, 72(%rsp)
	movl $20, %eax
	movl $10, %ecx
	cltd
	idivl %ecx
	movl %edx, 76(%rsp)
	movl $14, %eax
	movl $19, %ecx
	cltd
	idivl %ecx
	movl %eax, 80(%rsp)
	movl $6, %eax
	movl $19, %ecx
	cltd
	idivl %ecx
	movl %edx, 84(%rsp)
	movl $12, %ecx
	addl 52(%rsp), %ecx
	movl $32, %eax
	subl $2, %eax
	movl %ecx, %edx
	andl %eax, %edx
	movl 56(%rsp), %ecx
	subl $11, %ecx
	subl $19, %ecx
	andl $32, %ecx
	andl 60(%rsp), %ecx
	andl $31, %ecx
	andl $23, %ecx
	andl $8, %ecx
	orl %ecx, %edx
	movl $31, %ecx
	imull $7, %ecx
	addl $25, %ecx
	andl 64(%rsp), %ecx
	orl %ecx, %edx
	movl 68(%rsp), %eax
	imull $3, %eax
	movl $7, %ecx
	subl $18, %ecx
	sarl %cl, %eax
	movl $25, %ecx
	addl $12, %ecx
	subl $25, %ecx
	subl %r9d, %ecx
	movl %ecx, %r9d
	subl %r8d, %r9d
	movl %r9d, %ecx
	subl %r14d, %ecx
	movl %eax, %r9d
	sarl %cl, %r9d
	movl $22, %ecx
	addl $25, %ecx
	sarl %cl, %r9d
	movl $2, %ecx
	addl %r15d, %ecx
	sall %cl, %r9d
	movl $15, %r8d
	subl $4, %r8d
	andl %r8d, %r9d
	movl %esi, %r8d
	addl %edi, %r8d
	subl $12, %r8d
	addl $12, %r8d
	sall $9, %r8d
	sall $5, %r8d
	movl $11, %ecx
	subl %ebx, %ecx
	sarl %cl, %r8d
	andl %r8d, %r9d
	movl %r12d, %r8d
	subl $0, %r8d
	movl %r13d, %ecx
	sall %cl, %r8d
	andl %r8d, %r9d
	movl $16, %r8d
	sarl $9, %r8d
	andl %r8d, %r9d
	movl %r9d, %r8d
	andl $3, %r8d
	movl %edx, %r9d
	orl %r8d, %r9d
	movl $17, %r8d
	imull $31, %r8d
	subl $26, %r8d
	addl %ebp, %r8d
	addl $18, %r8d
	movl %r8d, %ecx
	subl $26, %ecx
	movl $14, %r8d
	sarl %cl, %r8d
	orl %r8d, %r9d
	movl $24, %r8d
	imull $4, %r8d
	addl $6, %r8d
	movl %r8d, %ecx
	subl $11, %ecx
	movl $10, %r8d
	sall %cl, %r8d
	movl $18, %ecx
	sarl $7, %ecx
	movl %ecx, %edx
	sarl $18, %edx
	movl $10, %ecx
	imull $18, %ecx
	sall %cl, %edx
	andl %edx, %r8d
	movl %r9d, %edx
	orl %r8d, %edx
	movl 72(%rsp), %r9d
	sall $8, %r9d
	movl %r9d, %r8d
	sall $4, %r8d
	movl $9, %r9d
	movl 76(%rsp), %ecx
	sall %cl, %r9d
	movl $2, %ecx
	subl $27, %ecx
	sarl %cl, %r9d
	andl %r9d, %r8d
	movl $9, %ecx
	addl $32, %ecx
	movl $22, %r9d
	sall %cl, %r9d
	movl $29, %esi
	imull $9, %esi
	movl $7, %ecx
	addl %esi, %ecx
	addl 80(%rsp), %ecx
	subl 84(%rsp), %ecx
	subl $13, %ecx
	sarl %cl, %r9d
	sall $10, %r9d
	andl %r9d, %r8d
	movl %edx, %eax
	orl %r8d, %eax
	movq 4(%rsp), %rbp
	movq 12(%rsp), %r15
	movq 20(%rsp), %r14
	movq 28(%rsp), %r13
	movq 36(%rsp), %r12
	movq 44(%rsp), %rbx
	addq $88, %rsp
	ret
.ident	"15-411 L4 reference compiler"
