.file	"../tests2/triceratops-ret01.l4"
.globl _c0_main
_c0_a:
	addq $-8, %rsp
.a_0:
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $0, (%r8)
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $1, (%r8)
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $2, (%r8)
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl $3, (%r8)
	callq _c0_b
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_b:
	addq $-8, %rsp
.b_0:
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %rdi, %rdx
	addq %r8, %rdx
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, (%rdx)
	addl $1, (%rdx)
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %rdi, %rdx
	addq %r8, %rdx
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, (%rdx)
	addl $1, (%rdx)
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %rdi, %rdx
	addq %r8, %rdx
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, (%rdx)
	addl $1, (%rdx)
	callq _c0_c
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_c:
	addq $-8, %rsp
.c_0:
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %rdi, %rdx
	addq %r8, %rdx
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, (%rdx)
	addl $1, (%rdx)
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %rdi, %rdx
	addq %r8, %rdx
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, (%rdx)
	addl $1, (%rdx)
	callq _c0_d
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_d:
	addq $-8, %rsp
.d_0:
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %rdi, %rcx
	addq %r8, %rcx
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, (%rcx)
	addl $1, (%rcx)
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $4, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_a
	movq %rbx, %r9
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %esi
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movl (%r9), %r8d
	movl %esi, %r9d
	addl %edx, %r9d
	addl %ecx, %r9d
	movl %r9d, %eax
	addl %r8d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
