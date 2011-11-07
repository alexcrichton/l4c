.file	"../tests2/saltopus-reverse-a-bunch.l4"
.globl _c0_main
_c0_insert_front:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.insert_front_0:
	movq $1, %rdi
	movq $16, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq $0, %rdx
	movq %rax, %rcx
	addq %rdx, %rcx
	movl %r8d, (%rcx)
	movq $8, %r8
	movq %rax, %rcx
	addq %r8, %rcx
	movq %r9, (%rcx)
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_reverse:
	addq $-8, %rsp
	movq %rdi, %r9
.reverse_0:
	movq $0, %r8
.reverse_5:
	movq %r8, %rdi
	movq %r9, %rsi
.reverse_1:
	movl $1, %ecx
	movq $0, %r8
	movq %rsi, %r9
	cmpq %r8, %r9
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .reverse_3
.reverse_2:
	movq %rsi, %rdx
	movq $8, %r8
	movq %rsi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %rcx
	movq $8, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movq %rdi, (%r9)
	movq %rdx, %r9
.reverse_4:
	movq %r9, %rdi
	movq %rcx, %rsi
	jmp .reverse_1
.reverse_3:
	movq %rdi, %rax
	addq $8, %rsp
	ret
_c0_reverse_badly:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.reverse_badly_0:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movl $1, %edx
	movq $0, %rcx
	cmpq %rcx, %r8
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .reverse_badly_2
.reverse_badly_1:
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdi
	movq %r9, %rbx
	callq _c0_reverse
	movq %rbx, %r9
	movq %rax, %rdx
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq $8, %rcx
	addq %rcx, %r8
	movq %r9, (%r8)
	movq $8, %r8
	addq %r8, %r9
	movq $0, (%r9)
.reverse_badly_5:
	movq %rdx, %r9
.reverse_badly_3:
	movq %r9, %rax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.reverse_badly_2:
.reverse_badly_4:
	jmp .reverse_badly_3
_c0_verify1:
	addq $-8, %rsp
.verify1_0:
	movl $65536, %r8d
	subl $1, %r8d
.verify1_9:
	movl %r8d, %edx
	movq %rdi, %rcx
.verify1_1:
	movl $1, %r8d
	movl $0, %r9d
	cmpl %edx, %r9d
	setle %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .verify1_7
.verify1_2:
	movq $0, %r9
	cmpq %r9, %rcx
	jz .ternary_true1
	movq $0, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %r8d
	cmpl %edx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r8d
.ternary_end2:
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .verify1_5
.verify1_3:
	movl $0, %eax
	addq $8, %rsp
	ret
.verify1_5:
.verify1_6:
	movq $8, %r8
	movq %rcx, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %r8
	movl %edx, %r9d
	subl $1, %r9d
.verify1_8:
	movl %r9d, %edx
	movq %r8, %rcx
	jmp .verify1_1
.verify1_7:
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_verify2:
	addq $-8, %rsp
.verify2_0:
	movl $0, %r8d
.verify2_9:
	movl %r8d, %esi
	movq %rdi, %rdx
.verify2_1:
	movl $1, %ecx
	movl $65536, %r8d
	movl %esi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .verify2_7
.verify2_2:
	movq $0, %r9
	cmpq %r9, %rdx
	jz .ternary_true3
	movq $0, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %r8d
	cmpl %esi, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	jmp .ternary_end4
.ternary_true3:
	movl $1, %r8d
.ternary_end4:
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .verify2_5
.verify2_3:
	movl $0, %eax
	addq $8, %rsp
	ret
.verify2_5:
.verify2_6:
	movq $8, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movq %r9, %r8
	movl %esi, %r9d
	addl $1, %r9d
.verify2_8:
	movl %r9d, %esi
	movq %r8, %rdx
	jmp .verify2_1
.verify2_7:
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movq $0, %r8
	movl $0, %r9d
.main_33:
.main_1:
	movl $1, %esi
	movl $65536, %edx
	movl %r9d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_3
.main_2:
	movq %r8, %rdi
	movl %r9d, %esi
	movq %r9, %rbx
	callq _c0_insert_front
	movq %rbx, %r9
	movq %rax, %r8
	addl $1, %r9d
.main_32:
	jmp .main_1
.main_3:
	movq %r8, %rdi
	movq %r8, %rbx
	callq _c0_verify1
	movq %rbx, %r8
	movl $1, %r9d
	movl $1, %edx
	xorl %eax, %edx
	cmpl %edx, %r9d
	jnz .main_6
.main_4:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_6:
.main_7:
	movq %r8, %rdi
	callq _c0_reverse
	movq %rax, %r9
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_verify2
	movq %rbx, %r9
	movl $1, %edx
	movl $1, %ecx
	xorl %eax, %ecx
	cmpl %ecx, %edx
	jnz .main_10
.main_8:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_10:
.main_11:
	movq %r9, %rdi
	callq _c0_reverse
	movq %rax, %r9
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_verify1
	movq %rbx, %r9
	movl $1, %edx
	movl $1, %ecx
	xorl %eax, %ecx
	cmpl %ecx, %edx
	jnz .main_14
.main_12:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_14:
.main_15:
	movq %r9, %rdi
	callq _c0_reverse
	movq %rax, %r9
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_verify2
	movq %rbx, %r9
	movl $1, %ecx
	movl $1, %r8d
	xorl %eax, %r8d
	cmpl %r8d, %ecx
	jnz .main_18
.main_16:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_18:
.main_19:
	movq %r9, %rdi
	callq _c0_reverse
	movq %rax, %r9
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_verify1
	movq %rbx, %r9
	movl $1, %ecx
	movl $1, %r8d
	xorl %eax, %r8d
	cmpl %r8d, %ecx
	jnz .main_22
.main_20:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_22:
.main_23:
	movq %r9, %rdi
	callq _c0_reverse
	movq %rax, %r9
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_verify2
	movq %rbx, %r9
	movl $1, %ecx
	movl $1, %r8d
	xorl %eax, %r8d
	cmpl %r8d, %ecx
	jnz .main_26
.main_24:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_26:
.main_27:
	movq %r9, %rdi
	callq _c0_reverse
	movq %rax, %r9
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_verify1
	movq %rbx, %r9
	movl $1, %r8d
	movl $1, %ecx
	xorl %eax, %ecx
	cmpl %ecx, %r8d
	jnz .main_30
.main_28:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_30:
.main_31:
	movq %r9, %rdi
	callq _c0_reverse_badly
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
