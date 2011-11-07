.file	"../tests2/apatosaurus-ffi02.l3"
.globl _c0_main
_c0_f:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.f_0:
	movl $1, %r9d
	movl $2, %r8d
	movl $3, %ebx
	movl $4, %ecx
	movl $5, %edx
	movl $6, %r12d
	movl %edx, %edi
	movl %r12d, %esi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq fadd
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movl $1, %esi
	cmpl %esi, %r9d
	jz .ternary_true9
	movl $0, %esi
	jmp .ternary_end10
.ternary_true9:
	movl $2, %r9d
	movl %r8d, %esi
	cmpl %r9d, %esi
	sete %sil
	movzbl %sil, %esi
.ternary_end10:
	cmpl $0, %esi
	jnz .ternary_true7
	movl $0, %r8d
	jmp .ternary_end8
.ternary_true7:
	movl $3, %r9d
	movl %ebx, %r8d
	cmpl %r9d, %r8d
	sete %r8b
	movzbl %r8b, %r8d
.ternary_end8:
	cmpl $0, %r8d
	jnz .ternary_true5
	movl $0, %r8d
	jmp .ternary_end6
.ternary_true5:
	movl $4, %r9d
	movl %ecx, %r8d
	cmpl %r9d, %r8d
	sete %r8b
	movzbl %r8b, %r8d
.ternary_end6:
	cmpl $0, %r8d
	jnz .ternary_true3
	movl $0, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl $5, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
.ternary_end4:
	cmpl $0, %r9d
	jnz .ternary_true1
	movl $0, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl $6, %r9d
	movl %r12d, %r8d
	cmpl %r9d, %r8d
	sete %r8b
	movzbl %r8b, %r8d
.ternary_end2:
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .f_2
.f_1:
	movl $1, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.f_2:
	movl $0, %eax
	subl $1, %eax
	movq 8(%rsp), %rbp
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
	callq _c0_f
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
