.file	"../tests1/hobby-no-mem.l4"
.globl _c0_main
_c0_insert:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rsi, %r9
.insert_0:
	movq $1, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq $0, (%r8)
	movq $8, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq %r9, (%r8)
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_insert_end:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.insert_end_0:
	movl $1, %edx
	movl $0, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .insert_end_3
.insert_end_1:
	movq %rdi, %r9
	movl %esi, %r8d
	addl $1, %r8d
	movslq %r8d, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %rsi
	movq %r9, %rdi
	callq _c0_insert
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.insert_end_3:
.insert_end_4:
	addl $1, %esi
	callq _c0_insert_end
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $0, %r9
	movq %r9, %rdi
	movl $1, %esi
	callq _c0_insert_end
	movq %rax, %r9
	movq $8, %r8
	addq %r8, %r9
	movq (%r9), %rcx
	movl $0, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
