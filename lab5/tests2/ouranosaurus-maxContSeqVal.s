.file	"../tests2/ouranosaurus-maxContSeqVal.l4"
.globl _c0_main
_c0_maxContSeqVal:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.maxContSeqVal_0:
	movslq %r8d, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %r13
	movl $0, %r12d
	subl $-2147483648, %r12d
	movl $0, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movl $0, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r13, %rcx
	addq %rdx, %rcx
	movl %esi, (%rcx)
	movl $1, %ecx
.maxContSeqVal_14:
	movl %ecx, %ebx
.maxContSeqVal_1:
	movl $1, %edx
	movl %ebx, %ecx
	cmpl %r8d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .maxContSeqVal_6
.maxContSeqVal_2:
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %eax
	movl %ebx, %ecx
	subl $1, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r13, %rcx
	addq %rdx, %rcx
	movl (%rcx), %edi
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl $1, %esi
	movl %edi, %edx
	addl %ecx, %edx
	movl %eax, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .maxContSeqVal_4
.maxContSeqVal_3:
	movl %ebx, %ecx
	subl $1, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r13, %rcx
	addq %rdx, %rcx
	movl (%rcx), %edi
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r13, %rcx
	addq %rdx, %rcx
	movl %edi, (%rcx)
	addl %esi, (%rcx)
.maxContSeqVal_16:
.maxContSeqVal_5:
	movl %ebx, %ecx
	addl $1, %ecx
.maxContSeqVal_13:
	movl %ecx, %ebx
	jmp .maxContSeqVal_1
.maxContSeqVal_4:
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r13, %rcx
	addq %rdx, %rcx
	movl %esi, (%rcx)
.maxContSeqVal_15:
	jmp .maxContSeqVal_5
.maxContSeqVal_6:
	movl $0, %r9d
.maxContSeqVal_18:
	movl %r12d, %edi
	movl %r9d, %esi
.maxContSeqVal_7:
	movl $1, %ecx
	movl %esi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .maxContSeqVal_12
.maxContSeqVal_8:
	movl %esi, %r9d
	imull $4, %r9d
	movslq %r9d, %rcx
	movq %r13, %r9
	addq %rcx, %r9
	movl (%r9), %edx
	movl $1, %ecx
	movl %edi, %r9d
	cmpl %edx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .maxContSeqVal_10
.maxContSeqVal_9:
	movl %esi, %r9d
	imull $4, %r9d
	movslq %r9d, %rcx
	movq %r13, %r9
	addq %rcx, %r9
	movl (%r9), %ecx
	movl %ecx, %r9d
.maxContSeqVal_20:
.maxContSeqVal_11:
	movl %esi, %ecx
	addl $1, %ecx
.maxContSeqVal_17:
	movl %r9d, %edi
	movl %ecx, %esi
	jmp .maxContSeqVal_7
.maxContSeqVal_10:
.maxContSeqVal_19:
	movl %edi, %r9d
	jmp .maxContSeqVal_11
.maxContSeqVal_12:
	movl %edi, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $10, %r9d
	movslq %r9d, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $0, (%r8)
	subl $1, (%r8)
	movl $1, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %rax, %rcx
	addq %r8, %rcx
	movl $3, (%rcx)
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $0, (%r8)
	subl $9, (%r8)
	movl $3, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $10, (%r8)
	movl $4, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %rax, %rcx
	addq %r8, %rcx
	movl $3, (%rcx)
	movl $5, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $0, (%r8)
	subl $1, (%r8)
	movl $6, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $5, (%r8)
	movl $7, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $0, (%r8)
	subl $10, (%r8)
	movl $8, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $4, (%r8)
	movl $9, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl $0, (%r8)
	subl $100, (%r8)
	movq %rax, %rdi
	movl %r9d, %esi
	callq _c0_maxContSeqVal
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
