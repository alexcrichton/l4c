.file	"../tests2/saltopus-collatz_peano.l3"
.globl _c0_main
_c0_add1:
	addq $-8, %rsp
.add1_0:
	movl %edi, %eax
	addl $1, %eax
	addq $8, %rsp
	ret
_c0_sub1:
	addq $-8, %rsp
.sub1_0:
	movl $0, %r8d
	cmpl %r8d, %edi
	jz .ternary_true1
	movl %edi, %r8d
	subl $1, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl %edi, %eax
	cltd
	idivl %edi
	movl %eax, %r8d
.ternary_end2:
	movl %r8d, %eax
	addq $8, %rsp
	ret
_c0_iszero:
	addq $-8, %rsp
.iszero_0:
	movl $0, %r8d
	movl %edi, %eax
	cmpl %r8d, %eax
	sete %al
	movzbl %al, %eax
	addq $8, %rsp
	ret
_c0_plus:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
.plus_0:
	movl %r9d, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_iszero
	movq %r12, %r8
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true3
	movl %r9d, %edi
	movq %r8, %rbx
	callq _c0_sub1
	movq %rbx, %r8
	movl %eax, %edi
	movl %r8d, %esi
	movq %r8, %rbx
	callq _c0_plus
	movq %rbx, %r8
	movl %eax, %edi
	movq %r8, %rbx
	callq _c0_add1
	movq %rbx, %r8
	movl %eax, %r9d
	jmp .ternary_end4
.ternary_true3:
	movl %r8d, %r9d
.ternary_end4:
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_minus:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.minus_0:
	movl %esi, %edi
	movq %rsi, %r12
	movq %r9, %rbx
	callq _c0_iszero
	movq %r12, %rsi
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true5
	movl %esi, %edi
	movq %r9, %rbx
	callq _c0_sub1
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	movq %r9, %rbx
	callq _c0_minus
	movq %rbx, %r9
	movl %eax, %edi
	movq %r9, %rbx
	callq _c0_sub1
	movq %rbx, %r9
	movl %eax, %r8d
	jmp .ternary_end6
.ternary_true5:
	movl %r9d, %r8d
.ternary_end6:
	movl %r8d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_times:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.times_0:
	movl %esi, %edi
	movq %rsi, %r12
	movq %r9, %rbx
	callq _c0_iszero
	movq %r12, %rsi
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true7
	movl %esi, %edi
	movq %r9, %rbx
	callq _c0_sub1
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	movq %r9, %rbx
	callq _c0_times
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	callq _c0_plus
	movl %eax, %r9d
	jmp .ternary_end8
.ternary_true7:
	movl $0, %r9d
.ternary_end8:
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_gt:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.gt_0:
	movl %r9d, %edi
	movq %rsi, %r12
	movq %r9, %rbx
	callq _c0_iszero
	movq %r12, %rsi
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true9
	movl %esi, %edi
	movq %rsi, %r12
	movq %r9, %rbx
	callq _c0_iszero
	movq %r12, %rsi
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true11
	movl %r9d, %edi
	movq %rsi, %rbx
	callq _c0_sub1
	movq %rbx, %rsi
	movl %eax, %r9d
	movl %esi, %edi
	movq %r9, %rbx
	callq _c0_sub1
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	callq _c0_gt
	movl %eax, %r9d
	jmp .ternary_end12
.ternary_true11:
	movl $1, %r9d
.ternary_end12:
	jmp .ternary_end10
.ternary_true9:
	movl $0, %r9d
.ternary_end10:
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_lt:
	addq $-8, %rsp
.lt_0:
	movl %esi, %r8d
	movl %edi, %esi
	movl %r8d, %edi
	callq _c0_gt
	addq $8, %rsp
	ret
_c0_eq:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
.eq_0:
	movl %r9d, %edi
	movl %r8d, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_gt
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %ecx
	cmpl %eax, %ecx
	jnz .ternary_true13
	movl $0, %ecx
	jmp .ternary_end14
.ternary_true13:
	movl %r9d, %edi
	movl %r8d, %esi
	callq _c0_lt
	movl $1, %ecx
	xorl %eax, %ecx
.ternary_end14:
	movl %ecx, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_power:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.power_0:
	movl %esi, %edi
	movq %rsi, %r12
	movq %r9, %rbx
	callq _c0_iszero
	movq %r12, %rsi
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true15
	movl %esi, %edi
	movq %r9, %rbx
	callq _c0_sub1
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	movq %r9, %rbx
	callq _c0_power
	movq %rbx, %r9
	movl %r9d, %edi
	movl %eax, %esi
	callq _c0_times
	movl %eax, %r9d
	jmp .ternary_end16
.ternary_true15:
	movl $1, %r9d
.ternary_end16:
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_quotient:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
	movl %esi, %r8d
.quotient_0:
	movl %r9d, %edi
	movl %r8d, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_lt
	movq %r12, %r8
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true17
	movl %r9d, %edi
	movl %r8d, %esi
	movq %r8, %rbx
	callq _c0_minus
	movq %rbx, %r8
	movl %eax, %edi
	movl %r8d, %esi
	callq _c0_quotient
	movl %eax, %edi
	callq _c0_add1
	movl %eax, %r9d
	jmp .ternary_end18
.ternary_true17:
	movl $0, %r9d
.ternary_end18:
	movl %r9d, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_even:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.even_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_iszero
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true19
	movl %r9d, %edi
	callq _c0_sub1
	movl %eax, %edi
	callq _c0_odd
	movl %eax, %r9d
	jmp .ternary_end20
.ternary_true19:
	movl $1, %r9d
.ternary_end20:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_odd:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.odd_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_iszero
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true21
	movl %r9d, %edi
	callq _c0_sub1
	movl %eax, %edi
	callq _c0_even
	movl %eax, %r9d
	jmp .ternary_end22
.ternary_true21:
	movl $0, %r9d
.ternary_end22:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_C:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.C_0:
	movl %r9d, %edi
	movq %r9, %rbx
	callq _c0_even
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true23
	movl $3, %edi
	movl %r9d, %esi
	movq %r9, %rbx
	callq _c0_times
	movq %rbx, %r9
	movl %eax, %edi
	movq %r9, %rbx
	callq _c0_add1
	movq %rbx, %r9
	movl %eax, %r8d
	jmp .ternary_end24
.ternary_true23:
	movl %r9d, %edi
	movl $2, %esi
	callq _c0_quotient
	movl %eax, %r8d
.ternary_end24:
	movl %r8d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_count:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.count_0:
	movl %r9d, %edi
	movl $1, %esi
	movq %r9, %rbx
	callq _c0_eq
	movq %rbx, %r9
	cmpl $0, %eax
	jnz .ternary_true25
	movl %r9d, %edi
	callq _c0_C
	movl %eax, %edi
	callq _c0_count
	movl %eax, %edi
	callq _c0_add1
	movl %eax, %r9d
	jmp .ternary_end26
.ternary_true25:
	movl $0, %r9d
.ternary_end26:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2919, %edi
	callq _c0_count
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
