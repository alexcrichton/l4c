.file	"../tests2/saltopus-collatz_peano2.l4"
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
_c0_C:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.C_0:
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_even
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true25
	movl $3, %edi
	movq %r9, %rbx
	callq _c0_int2nat
	movq %rbx, %r9
	movq %rax, %rdi
	movq %r9, %rsi
	movq %r9, %rbx
	callq _c0_times
	movq %rbx, %r9
	movq %rax, %rdi
	movq %r9, %rbx
	callq _c0_add1
	movq %rbx, %r9
	movq %rax, %r8
	jmp .ternary_end26
.ternary_true25:
	movl $2, %edi
	movq %r9, %rbx
	callq _c0_int2nat
	movq %rbx, %r9
	movq %r9, %rdi
	movq %rax, %rsi
	callq _c0_quotient
	movq %rax, %r8
.ternary_end26:
	movq %r8, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_count:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.count_0:
	movl $1, %edi
	movq %r9, %rbx
	callq _c0_int2nat
	movq %rbx, %r9
	movq %r9, %rdi
	movq %rax, %rsi
	movq %r9, %rbx
	callq _c0_eq
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true27
	movq %r9, %rdi
	callq _c0_C
	movq %rax, %rdi
	callq _c0_count
	movq %rax, %rdi
	callq _c0_add1
	movq %rax, %r9
	jmp .ternary_end28
.ternary_true27:
	callq _c0_get_zero
	movq %rax, %r9
.ternary_end28:
	movq %r9, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2919, %edi
	callq _c0_int2nat
	movq %rax, %rdi
	callq _c0_count
	movq %rax, %rdi
	callq _c0_nat2int
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
