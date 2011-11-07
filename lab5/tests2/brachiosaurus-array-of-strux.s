.file	"../tests2/brachiosaurus-array-of-strux.l4"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $64, %r9d
	movslq %r9d, %rdi
	movq $16, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movl $0, %ecx
	imull $16, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq $0, %rdx
	addq %rdx, %rcx
	movq $0, %rdx
	addq %rdx, %rcx
	movl $0, (%rcx)
	movl $0, %ecx
	imull $16, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq $8, %rdx
	addq %rdx, %rcx
	movq $4, %rdx
	addq %rdx, %rcx
	movl $1, (%rcx)
	movl $1, %ecx
.main_5:
	movl %ecx, %edi
.main_1:
	movl $1, %edx
	movl %edi, %ecx
	cmpl %r9d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_3
.main_2:
	movl %edi, %ecx
	subl $1, %ecx
	imull $16, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq $8, %rdx
	addq %rdx, %rcx
	movq $4, %rdx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movl %edi, %ecx
	imull $16, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq $0, %rdx
	addq %rdx, %rcx
	movq $0, %rdx
	addq %rdx, %rcx
	movl $2, (%rcx)
	movl (%rcx), %r11d
	imull %esi, %r11d
	movl %r11d, (%rcx)
	movl %edi, %ecx
	subl $1, %ecx
	imull $16, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq $0, %rdx
	addq %rdx, %rcx
	movq $0, %rdx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movl %edi, %ecx
	imull $16, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq $8, %rdx
	addq %rdx, %rcx
	movq $4, %rdx
	addq %rdx, %rcx
	movl $1, (%rcx)
	addl %esi, (%rcx)
	movl %edi, %ecx
	addl $1, %ecx
.main_4:
	movl %ecx, %edi
	jmp .main_1
.main_3:
	movl $2, %ecx
	movl %r9d, %eax
	cltd
	idivl %ecx
	movl %eax, %r9d
	imull $16, %r9d
	movslq %r9d, %r9
	addq %r9, %r8
	movq $8, %r9
	addq %r9, %r8
	movq $4, %r9
	addq %r9, %r8
	movl (%r8), %r9d
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
