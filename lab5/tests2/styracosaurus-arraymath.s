.file	"../tests2/styracosaurus-arraymath.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $7, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $15, (%r8)
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $3, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	movq %r9, %rdx
	addq %rcx, %rdx
	movl (%rdx), %eax
	movl $16, %ecx
	cltd
	idivl %ecx
	movl %edx, (%r8)
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $3, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %eax
	movl $3, %ecx
	cltd
	idivl %ecx
	movl %eax, (%r8)
	movl $5, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $24, (%r8)
	movl $5, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl $5, %r8d
	imull $4, %r8d
	movslq %r8d, %rdx
	movq %r9, %r8
	addq %rdx, %r8
	movl (%r8), %eax
	movl $6, %r8d
	cltd
	idivl %r8d
	movl %eax, (%rcx)
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movl $5, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $5, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %ecx, (%r8)
	movl %esi, %ecx
	sall %cl, (%r8)
	movl $5, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl (%rcx), %eax
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	cltd
	idivl %r9d
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
