.file	"../tests2/ouranosaurus-longest_subseq.l2"
.globl _c0_main
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $-264586018, %r9d
	movl %r9d, %esi
	andl $1, %esi
	movl $1, %edx
	movl $1, %ecx
	movl $1, %r8d
.main_11:
	movl %r8d, %r13d
	movl %ecx, %r12d
	movl %edx, %ebx
	movl %esi, %eax
	movl %r9d, %edi
.main_1:
	movl $1, %ecx
	movl $32, %r8d
	movl %r13d, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_9
.main_2:
	movl $1, %r8d
	movl %edi, %r9d
	andl $1, %r9d
	cmpl %eax, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_3
.main_6:
	movl %r12d, %r9d
	addl $1, %r9d
.main_15:
	movl %r9d, %esi
	movl %ebx, %edx
	movl %eax, %ecx
.main_8:
	movl %edi, %r8d
	sarl $1, %r8d
	movl %r13d, %r9d
	addl $1, %r9d
.main_10:
	movl %r9d, %r13d
	movl %esi, %r12d
	movl %edx, %ebx
	movl %ecx, %eax
	movl %r8d, %edi
	jmp .main_1
.main_3:
	movl $1, %r8d
	movl %ebx, %r9d
	cmpl %r12d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_5
.main_4:
	movl %r12d, %r9d
.main_13:
	movl %r9d, %ecx
.main_7:
	movl $1, %r8d
	movl %edi, %r9d
	andl $1, %r9d
.main_14:
	movl %r8d, %esi
	movl %ecx, %edx
	movl %r9d, %ecx
	jmp .main_8
.main_5:
.main_12:
	movl %ebx, %ecx
	jmp .main_7
.main_9:
	cmpl %r12d, %ebx
	jl .ternary_true1
	movl %ebx, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl %r12d, %r9d
.ternary_end2:
	movl %r9d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
