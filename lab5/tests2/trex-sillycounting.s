.file	"../tests2/trex-sillycounting.l3"
.globl _c0_main
_c0_lesseq_than:
	addq $-8, %rsp
.lesseq_than_0:
	movl %edi, %eax
	cmpl %esi, %eax
	setle %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_greatereq_than:
	addq $-8, %rsp
.greatereq_than_0:
	movl %esi, %eax
	cmpl %edi, %eax
	setle %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_f:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %esi, %r9d
.f_0:
	movl $0, %esi
	movl $60, %r8d
	movl $101, %edx
	movl %edi, %ecx
.f_8:
	movl %esi, %ebx
.f_1:
	movl $1, %edi
	movl %ecx, %esi
	cmpl %r9d, %esi
	setle %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .f_6
.f_2:
	movl %ecx, %edi
	movl %r8d, %esi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_greatereq_than
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	cmpl $0, %eax
	jnz .ternary_true1
	movl $0, %esi
	jmp .ternary_end2
.ternary_true1:
	movl %ecx, %edi
	movl %edx, %esi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_lesseq_than
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %esi
.ternary_end2:
	movl $1, %edi
	cmpl %esi, %edi
	jnz .f_4
.f_3:
	movl %ebx, %esi
	addl $1, %esi
.f_10:
.f_5:
	addl $1, %ecx
.f_7:
	movl %esi, %ebx
	jmp .f_1
.f_4:
.f_9:
	movl %ebx, %esi
	jmp .f_5
.f_6:
	movl %ebx, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %edi
	movl $1000, %esi
	callq _c0_f
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
