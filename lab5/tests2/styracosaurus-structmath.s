.file	"../tests2/styracosaurus-structmath.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $1, %rdi
	movq $36, %rsi
	callq calloc
	movq %rax, %r9
	movq $32, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $15, (%r8)
	movq $32, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movq $32, %rdx
	movq %r9, %r8
	addq %rdx, %r8
	movl (%r8), %eax
	movl $16, %r8d
	cltd
	idivl %r8d
	movl %edx, (%rcx)
	movq $32, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movq $32, %rdx
	movq %r9, %r8
	addq %rdx, %r8
	movl (%r8), %eax
	movl $3, %r8d
	cltd
	idivl %r8d
	movl %eax, (%rcx)
	movq $16, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl $24, (%rcx)
	movq $16, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq $16, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %eax
	movl $6, %ecx
	cltd
	idivl %ecx
	movl %eax, (%r8)
	movq $32, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movq $16, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq $16, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %ecx, (%r8)
	movl %esi, %ecx
	sall %cl, (%r8)
	movq $16, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %eax
	movq $32, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	cltd
	idivl %r9d
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
