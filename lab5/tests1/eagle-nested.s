.file	"../tests1/eagle-nested.l4"
.globl _c0_main
_c0_dist_squared:
	addq $-8, %rsp
.dist_squared_0:
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq $0, %rcx
	addq %rcx, %r8
	movl (%r8), %edx
	movq $0, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq $0, %rcx
	addq %rcx, %r8
	movl (%r8), %r8d
	subl %r8d, %edx
	movq $8, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movq $4, %rcx
	addq %rcx, %r8
	movl (%r8), %ecx
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq $4, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	subl %r9d, %ecx
	movl %edx, %r9d
	imull %edx, %r9d
	movl %ecx, %r8d
	imull %ecx, %r8d
	movl %r9d, %eax
	addl %r8d, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $1, %rdi
	movq $16, %rsi
	callq calloc
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq $0, %r8
	addq %r8, %r9
	movl $2, (%r9)
	movq $0, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq $4, %r8
	addq %r8, %r9
	movl $0, (%r9)
	subl $1, (%r9)
	movq $8, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq $0, %r8
	addq %r8, %r9
	movl $5, (%r9)
	movq $8, %r8
	movq %rax, %r9
	addq %r8, %r9
	movq $4, %r8
	addq %r8, %r9
	movl $3, (%r9)
	movq %rax, %rdi
	callq _c0_dist_squared
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
