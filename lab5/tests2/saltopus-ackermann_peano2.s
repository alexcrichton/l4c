.file	"../tests2/saltopus-ackermann_peano2.l4"
.globl _c0_main
_c0_get_zero:
	addq $-8, %rsp
.get_zero_0:
	movq $0, %rax
	addq $8, %rsp
	ret
_c0_add1:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.add1_0:
	movq $1, %rdi
	movq $8, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq $0, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movq %r9, (%r8)
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_sub1:
	addq $-8, %rsp
.sub1_0:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rax
	addq $8, %rsp
	ret
_c0_iszero:
	addq $-8, %rsp
.iszero_0:
	movq $0, %r8
	movq %rdi, %r9
	cmpq %r8, %r9
	sete %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_plus:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movq %rsi, %r8
.plus_0:
	movq %r9, %rdi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_iszero
	movq %r12, %r8
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true1
	movq %r9, %rdi
	movq %r8, %rbx
	callq _c0_sub1
	movq %rbx, %r8
	movq %rax, %rdi
	movq %r8, %rsi
	movq %r8, %rbx
	callq _c0_plus
	movq %rbx, %r8
	movq %rax, %rdi
	movq %r8, %rbx
	callq _c0_add1
	movq %rbx, %r8
	movq %rax, %r9
	jmp .ternary_end2
.ternary_true1:
	movq %r8, %r9
.ternary_end2:
	movq %r9, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_minus:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.minus_0:
	movq %rsi, %rdi
	movq %rsi, %r12
	movq %r9, %rbx
	callq _c0_iszero
	movq %r12, %rsi
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true3
	movq %rsi, %rdi
	movq %r9, %rbx
	callq _c0_sub1
	movq %rbx, %r9
	movq %r9, %rdi
	movq %rax, %rsi
	movq %r9, %rbx
	callq _c0_minus
	movq %rbx, %r9
	movq %rax, %rdi
	movq %r9, %rbx
	callq _c0_sub1
	movq %rbx, %r9
	movq %rax, %r8
	jmp .ternary_end4
.ternary_true3:
	movq %r9, %r8
.ternary_end4:
	movq %r8, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_times:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.times_0:
	movq %rsi, %rdi
	movq %rsi, %r12
	movq %r9, %rbx
	callq _c0_iszero
	movq %r12, %rsi
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true5
	movq %rsi, %rdi
	movq %r9, %rbx
	callq _c0_sub1
	movq %rbx, %r9
	movq %r9, %rdi
	movq %rax, %rsi
	movq %r9, %rbx
	callq _c0_times
	movq %rbx, %r9
	movq %r9, %rdi
	movq %rax, %rsi
	callq _c0_plus
	movq %rax, %r9
	jmp .ternary_end6
.ternary_true5:
	callq _c0_get_zero
	movq %rax, %r9
.ternary_end6:
	movq %r9, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_gt:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.gt_0:
	movq %r9, %rdi
	movq %rsi, %r12
	movq %r9, %rbx
	callq _c0_iszero
	movq %r12, %rsi
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true7
	movq %rsi, %rdi
	movq %rsi, %r12
	movq %r9, %rbx
	callq _c0_iszero
	movq %r12, %rsi
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true9
	movq %r9, %rdi
	movq %rsi, %rbx
	callq _c0_sub1
	movq %rbx, %rsi
	movq %rax, %r9
	movq %rsi, %rdi
	movq %r9, %rbx
	callq _c0_sub1
	movq %rbx, %r9
	movq %r9, %rdi
	movq %rax, %rsi
	callq _c0_gt
	movl %eax, %r9d
	jmp .ternary_end10
.ternary_true9:
	movl $1, %r9d
.ternary_end10:
	jmp .ternary_end8
.ternary_true7:
	movl $0, %r9d
.ternary_end8:
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_lt:
	addq $-8, %rsp
.lt_0:
	movq %rsi, %r8
	movq %rdi, %rsi
	movq %r8, %rdi
	callq _c0_gt
	addq $8, %rsp
	ret
_c0_eq:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movq %rsi, %r8
.eq_0:
	movq %r9, %rdi
	movq %r8, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_gt
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %ecx
	cmpl %eax, %ecx
	jnz .ternary_true11
	movl $0, %ecx
	jmp .ternary_end12
.ternary_true11:
	movq %r9, %rdi
	movq %r8, %rsi
	callq _c0_lt
	movl $1, %ecx
	xorl %eax, %ecx
.ternary_end12:
	movl %ecx, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_power:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.power_0:
	movq %rsi, %rdi
	movq %rsi, %r12
	movq %r9, %rbx
	callq _c0_iszero
	movq %r12, %rsi
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true13
	movq %rsi, %rdi
	movq %r9, %rbx
	callq _c0_sub1
	movq %rbx, %r9
	movq %r9, %rdi
	movq %rax, %rsi
	movq %r9, %rbx
	callq _c0_power
	movq %rbx, %r9
	movq %r9, %rdi
	movq %rax, %rsi
	callq _c0_times
	movq %rax, %r9
	jmp .ternary_end14
.ternary_true13:
	callq _c0_get_zero
	movq %rax, %rdi
	callq _c0_add1
	movq %rax, %r9
.ternary_end14:
	movq %r9, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_quotient:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movq %rsi, %r8
.quotient_0:
	movq %r9, %rdi
	movq %r8, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_lt
	movq %r12, %r8
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true15
	movq %r9, %rdi
	movq %r8, %rsi
	movq %r8, %rbx
	callq _c0_minus
	movq %rbx, %r8
	movq %rax, %rdi
	movq %r8, %rsi
	callq _c0_quotient
	movq %rax, %rdi
	callq _c0_add1
	movq %rax, %r9
	jmp .ternary_end16
.ternary_true15:
	callq _c0_get_zero
	movq %rax, %r9
.ternary_end16:
	movq %r9, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_even:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.even_0:
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_iszero
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true17
	movq %r9, %rdi
	callq _c0_sub1
	movq %rax, %rdi
	callq _c0_odd
	movl %eax, %r9d
	jmp .ternary_end18
.ternary_true17:
	movl $1, %r9d
.ternary_end18:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_odd:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.odd_0:
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_iszero
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true19
	movq %r9, %rdi
	callq _c0_sub1
	movq %rax, %rdi
	callq _c0_even
	movl %eax, %r9d
	jmp .ternary_end20
.ternary_true19:
	movl $0, %r9d
.ternary_end20:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_int2nat:
	addq $-8, %rsp
.int2nat_0:
	movl $0, %r8d
	cmpl %r8d, %edi
	jz .ternary_true21
	subl $1, %edi
	callq _c0_int2nat
	movq %rax, %rdi
	callq _c0_add1
	movq %rax, %r9
	jmp .ternary_end22
.ternary_true21:
	callq _c0_get_zero
	movq %rax, %r9
.ternary_end22:
	movq %r9, %rax
	addq $8, %rsp
	ret
_c0_nat2int:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.nat2int_0:
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_iszero
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true23
	movq %r9, %rdi
	callq _c0_sub1
	movq %rax, %rdi
	callq _c0_nat2int
	movl %eax, %r9d
	addl $1, %r9d
	jmp .ternary_end24
.ternary_true23:
	movl $0, %r9d
.ternary_end24:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_A:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
	movq %rsi, %r8
.A_0:
	movq %r9, %rdi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_iszero
	movq %r12, %r8
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true25
	movq %r8, %rdi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_iszero
	movq %r12, %r8
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true27
	movq %r9, %rdi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_sub1
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movq %r8, %rdi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_sub1
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movq %rax, %rsi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_A
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rcx, %rdi
	movq %rax, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_A
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	jmp .ternary_end28
.ternary_true27:
	movq %r9, %rdi
	movq %r8, %rbx
	callq _c0_sub1
	movq %rbx, %r8
	movq %rax, %r9
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_get_zero
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rdi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_add1
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movq %rax, %rsi
	movq %r8, %rbx
	callq _c0_A
	movq %rbx, %r8
	movq %rax, %rcx
.ternary_end28:
	movq %rcx, %r9
	jmp .ternary_end26
.ternary_true25:
	movq %r8, %rdi
	callq _c0_add1
	movq %rax, %r9
.ternary_end26:
	movq %r9, %rax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	callq _c0_get_zero
	movq %rax, %rcx
	movl $2, %edi
	movq %rcx, %rbx
	callq _c0_int2nat
	movq %rbx, %rcx
	movq %rax, %r9
	movl $3, %edi
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_int2nat
	movq %r12, %rcx
	movq %rbx, %r9
	movq %rax, %r8
	movl $0, %esi
.main_9:
	movq %rcx, %rdx
	movl %esi, %ebx
.main_1:
	movl $1, %edi
	movl $10, %ecx
	movl %ebx, %esi
	cmpl %ecx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .main_7
.main_2:
	movq %r8, %rdi
	movq %rdx, %rsi
	movq %rdx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_A
	movq %r14, %rdx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, %rcx
	movq %rdx, %rdi
	movq %r8, %rsi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_plus
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movq %r9, %rdi
	movq %rax, %rsi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_power
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, %rdi
	movq %r8, %rsi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_minus
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, %rdi
	movq %rcx, %rsi
	movq %rdi, %rcx
	movq %rsi, %rdi
	movq %rcx, %rsi
	movq %rdx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_eq
	movq %r14, %rdx
	movq %r13, %r8
	movq %r12, %r9
	movl $1, %edi
	movl $1, %esi
	xorl %eax, %esi
	cmpl %esi, %edi
	jnz .main_5
.main_3:
	movl $0, %eax
	subl %ebx, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.main_5:
.main_6:
	movq %rdx, %rdi
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_add1
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, %rdx
	movl %ebx, %ecx
	addl $1, %ecx
.main_8:
	movl %ecx, %ebx
	jmp .main_1
.main_7:
	movl $0, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.ident	"15-411 L4 reference compiler"
