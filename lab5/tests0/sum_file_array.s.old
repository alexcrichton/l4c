.file	"../tests0/sum_file_array.l4"
.globl _c0_main
_c0_fail:
	addq $-8, %rsp
.fail_0:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $10, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r8
	movl $0, %r9d
.main_11:
.main_1:
	movl $1, %esi
	movl $10, %edx
	movl %r9d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_3
.main_2:
	movq %r8, %r12
	movq %r9, %rbx
	callq readint
	movq %r12, %r8
	movq %rbx, %r9
	movl %r9d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl %eax, (%rcx)
	addl $1, %r9d
.main_10:
	jmp .main_1
.main_3:
	movq %r8, %rbx
	callq eof
	movq %rbx, %r8
	movl $1, %ecx
	movl $1, %r9d
	xorl %eax, %r9d
	cmpl %r9d, %ecx
	jnz .main_5
.main_4:
	movq %r8, %rbx
	callq _c0_fail
	movq %rbx, %r8
.main_6:
	movl $0, %ecx
	movl $0, %r9d
.main_13:
	movl %r9d, %edi
	movl %ecx, %esi
.main_7:
	movl $1, %edx
	movl $10, %ecx
	movl %edi, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edx
	jnz .main_9
.main_8:
	movl %edi, %r9d
	imull $4, %r9d
	movslq %r9d, %rcx
	movq %r8, %r9
	addq %rcx, %r9
	movl (%r9), %ecx
	movl %esi, %r9d
	addl %ecx, %r9d
	movl %edi, %ecx
	addl $1, %ecx
.main_12:
	movl %ecx, %edi
	movl %r9d, %esi
	jmp .main_7
.main_9:
	movl %esi, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_5:
	jmp .main_6
.ident	"15-411 L4 reference compiler"
