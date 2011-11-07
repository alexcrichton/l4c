.file	"../tests2/velociraptor-optimizing-much.l4"
.globl _c0_main
_c0_average:
	addq $-8, %rsp
	movq %rdi, %r8
	movl %esi, %eax
.average_0:
	movl $1, %edx
	movl $0, %r9d
	movl $0, %ecx
.average_5:
	movl %ecx, %edi
	movl %r9d, %esi
	movl %edx, %r9d
.average_1:
	movl $1, %edx
	movl %esi, %ecx
	cmpl %eax, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .average_3
.average_2:
	movl %eax, %edx
	movl %esi, %r9d
	imull $4, %r9d
	movslq %r9d, %rcx
	movq %r8, %r9
	addq %rcx, %r9
	movl (%r9), %r9d
	movl %edi, %ecx
	addl %r9d, %ecx
	movl %esi, %r9d
	addl $1, %r9d
.average_4:
	movl %ecx, %edi
	movl %r9d, %esi
	movl %edx, %r9d
	jmp .average_1
.average_3:
	movl %edi, %eax
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $5, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movq $0, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movl $0, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl $6, (%rcx)
	movl $1, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	movq %r9, %rdx
	addq %rcx, %rdx
	movl $1, (%rdx)
	movl $2, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl $9, (%rcx)
	movl $3, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl $43, (%rcx)
	movl $4, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl $2, (%rcx)
	movq %r9, %rdi
	movl $5, %esi
	movq %r8, %rbx
	callq _c0_average
	movq %rbx, %r8
	movq %r8, %rdi
	movl $0, %esi
	callq _c0_average
	movl %eax, %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
