.file	"../tests2/saltopus-knapsack.l3"
.globl _c0_main
_c0____:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
.____0:
	movl $2, %r8d
	movl %r8d, %eax
	cltd
	idivl %r8d
	movl %eax, %edx
	movl %r8d, %ecx
	subl %r8d, %ecx
	movl %edx, %ebx
	addl %r8d, %ebx
	movl %r8d, %r12d
	addl %r8d, %r12d
	movl %r9d, %edi
	movl %ecx, %esi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq _c0___________
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl $1, %esi
	cmpl %eax, %esi
	jnz .____2
.____1:
	movl %r12d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.____2:
	movl %r9d, %edi
	movl %edx, %esi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq _c0___________
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl $1, %esi
	cmpl %eax, %esi
	jnz .____4
.____3:
	movl %r8d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.____4:
	movl %r9d, %edi
	movl %r8d, %esi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq _c0___________
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl $1, %esi
	cmpl %eax, %esi
	jnz .____6
.____5:
	movl %r8d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.____6:
	movl %r9d, %edi
	movl %ebx, %esi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq _c0___________
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl $1, %esi
	cmpl %eax, %esi
	jnz .____8
.____7:
	movl %edx, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.____8:
	movl %r9d, %edi
	movl %r12d, %esi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	callq _c0___________
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movl $1, %esi
	cmpl %eax, %esi
	jnz .____10
.____9:
	movl %edx, %r9d
	addl %ecx, %r9d
	addl %ebx, %r9d
	addl %r8d, %r9d
	movl %r9d, %eax
	addl %r12d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.____10:
	movl %r8d, %eax
	cltd
	idivl %ecx
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0___:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movl %edi, %r9d
.___0:
	movl $2, %r8d
	movl %r8d, %eax
	cltd
	idivl %r8d
	movl %eax, %edx
	movl %r8d, %ecx
	subl %edx, %ecx
	subl %r8d, %ecx
	addl %edx, %ecx
	movl %edx, %ebx
	addl %r8d, %ebx
	movl %r8d, %r12d
	addl %r8d, %r12d
	movl %r9d, %edi
	movl %ecx, %esi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq _c0___________
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl $1, %esi
	cmpl %eax, %esi
	jnz .___2
.___1:
	movl %r8d, %r9d
	imull %ebx, %r9d
	movl %r12d, %ecx
	subl %r8d, %ecx
	movl %r9d, %eax
	imull %ecx, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.___2:
	movl %r9d, %edi
	movl %edx, %esi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq _c0___________
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl $1, %esi
	cmpl %eax, %esi
	jnz .___4
.___3:
	movl %r8d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.___4:
	movl %r9d, %edi
	movl %r8d, %esi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq _c0___________
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl $1, %esi
	cmpl %eax, %esi
	jnz .___6
.___5:
	movl %edx, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.___6:
	movl %r9d, %edi
	movl %ebx, %esi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %rbx
	callq _c0___________
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %rbx, %r9
	movl $1, %edi
	cmpl %eax, %edi
	jnz .___8
.___7:
	movl %edx, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.___8:
	movl %r9d, %edi
	movl %r12d, %esi
	movq %rcx, %r13
	movq %r8, %rbx
	callq _c0___________
	movq %r13, %rcx
	movq %rbx, %r8
	movl $1, %edx
	cmpl %eax, %edx
	jnz .___10
.___9:
	movl %r12d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.___10:
	movl %r8d, %eax
	cltd
	idivl %ecx
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
_c0______:
	addq $-8, %rsp
.______0:
	cmpl %edi, %esi
	jle .ternary_true1
	movl %esi, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl %edi, %r8d
.ternary_end2:
	movl %r8d, %eax
	addq $8, %rsp
	ret
_c0_____:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movl %esi, %r9d
._____0:
	movl %edi, %ecx
	subl $1, %ecx
	movl %ecx, %edx
	subl %edi, %edx
	movl %edx, %esi
	addl $1, %esi
	movl $1, %edx
	movl %edi, %r8d
	cmpl %esi, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz ._____3
._____1:
	movl %esi, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
._____3:
._____4:
	movl %ecx, %edi
	movl %r9d, %esi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_____
	movq %r12, %rcx
	movq %rbx, %r9
	movl %eax, %edx
	movl %ecx, %edi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0___
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r9
	movl $1, %esi
	movl %r9d, %r8d
	cmpl %eax, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %esi
	jnz ._____6
._____5:
	movl %edx, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
._____6:
	movl %ecx, %edi
	movq %rdx, %r13
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0____
	movq %r13, %rdx
	movq %r12, %rcx
	movq %rbx, %r9
	movl %eax, %r8d
	movl %ecx, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0___
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %ecx, %edi
	movl %r9d, %esi
	subl %eax, %esi
	movq %rdx, %r12
	movq %r8, %rbx
	callq _c0_____
	movq %r12, %rdx
	movq %rbx, %r8
	movl %r8d, %edi
	addl %eax, %edi
	movl %edx, %esi
	callq _c0______
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0___________:
	addq $-8, %rsp
.___________0:
	movl %edi, %eax
	cmpl %esi, %eax
	sete %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $4, %r9d
	movl %r9d, %eax
	cltd
	idivl %r9d
	movl %eax, %r8d
	movl %r9d, %eax
	cltd
	idivl %r9d
	movl %r9d, %edi
	addl %r8d, %edi
	movl %r9d, %r8d
	imull %r9d, %r8d
	movl %r8d, %esi
	subl %eax, %esi
	callq _c0_____
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
