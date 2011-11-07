.file	"../tests2/monoclonius-val04.l3"
.globl _c0_main
_c0_makechange:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %edi, %r9d
.makechange_0:
	movl $1, %ecx
	movl $0, %r8d
	movl %r9d, %edx
	cmpl %r8d, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .makechange_3
.makechange_1:
	movl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.makechange_3:
.makechange_4:
	movl $0, %ecx
	movl $1, %edx
	movl $1, %r8d
	cmpl %r9d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .makechange_6
.makechange_5:
	movl %r9d, %edi
	subl $1, %edi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_makechange
	movq %r12, %rcx
	movq %rbx, %r9
	movl %ecx, %r8d
	addl %eax, %r8d
.makechange_18:
	movl %r8d, %edx
.makechange_7:
	movl $1, %esi
	movl $5, %r8d
	cmpl %r9d, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %esi
	jnz .makechange_9
.makechange_8:
	movl %r9d, %edi
	subl $5, %edi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_makechange
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r9
	movl %edx, %r8d
	addl %eax, %r8d
.makechange_20:
.makechange_10:
	movl $1, %edi
	movl $10, %esi
	cmpl %r9d, %esi
	setle %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .makechange_12
.makechange_11:
	movl %r9d, %edi
	subl $10, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_makechange
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %r8d, %esi
	addl %eax, %esi
.makechange_22:
.makechange_13:
	movl $1, %eax
	movl $25, %edi
	cmpl %r9d, %edi
	setle %dil
	movzbl %dil, %edi
	cmpl %edi, %eax
	jnz .makechange_15
.makechange_14:
	movl %r9d, %edi
	subl $25, %edi
	movq %rsi, %rbx
	callq _c0_makechange
	movq %rbx, %rsi
	movl %esi, %r9d
	addl %eax, %r9d
.makechange_24:
	movl %r9d, %esi
.makechange_16:
	movl %esi, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.makechange_15:
.makechange_23:
	jmp .makechange_16
.makechange_12:
.makechange_21:
	movl %r8d, %esi
	jmp .makechange_13
.makechange_9:
.makechange_19:
	movl %edx, %r8d
	jmp .makechange_10
.makechange_6:
.makechange_17:
	movl %ecx, %edx
	jmp .makechange_7
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $37, %edi
	callq _c0_makechange
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
