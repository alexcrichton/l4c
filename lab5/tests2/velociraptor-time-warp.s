.file	"../tests2/velociraptor-time-warp.l4"
.globl _c0_main
_c0_jump_to_the_left:
	addq $-8, %rsp
	movq %rdi, %r9
	movq %rsi, %r8
	movl %edx, %eax
.jump_to_the_left_0:
	movl $0, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %ecx, %esi
	movl $1, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %ecx, %edi
	subl $2, %esi
	movl $0, %ecx
	cmpl %ecx, %esi
	jl .ternary_true1
	movl %eax, %edx
	cmpl %esi, %edx
	setle %dl
	movzbl %dl, %edx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %edx
.ternary_end2:
	movl $1, %ecx
	cmpl %edx, %ecx
	jnz .jump_to_the_left_3
.jump_to_the_left_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.jump_to_the_left_3:
.jump_to_the_left_4:
	movl $0, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	addq %rcx, %r8
	movl %esi, (%r8)
	movl %edi, %r8d
	imull $8, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movq (%r9), %rdx
	movl %esi, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %rdx, %rcx
	addq %r9, %rcx
	movl %esi, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, (%rcx)
	addl $1, (%rcx)
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_step_to_the_right:
	addq $-8, %rsp
	movq %rdi, %r9
	movq %rsi, %r8
	movl %edx, %eax
.step_to_the_right_0:
	movl $0, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %ecx, %esi
	movl $1, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %ecx, %edi
	addl $1, %esi
	movl $0, %ecx
	cmpl %ecx, %esi
	jl .ternary_true3
	movl %eax, %edx
	cmpl %esi, %edx
	setle %dl
	movzbl %dl, %edx
	jmp .ternary_end4
.ternary_true3:
	movl $1, %edx
.ternary_end4:
	movl $1, %ecx
	cmpl %edx, %ecx
	jnz .step_to_the_right_3
.step_to_the_right_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.step_to_the_right_3:
.step_to_the_right_4:
	movl $0, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	addq %rcx, %r8
	movl %esi, (%r8)
	movl %edi, %r8d
	imull $8, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movq (%r9), %rdx
	movl %esi, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %rdx, %rcx
	addq %r9, %rcx
	movl %esi, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rdx, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, (%rcx)
	addl $1, (%rcx)
	movl $1, %eax
	addq $8, %rsp
	ret
_c0_hands_on_your_hips_knees_in_tight:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movq %rsi, %r8
	movl %edx, %r12d
.hands_on_your_hips_knees_in_tight_0:
	movl $0, %ecx
.hands_on_your_hips_knees_in_tight_5:
	movl %ecx, %ebx
.hands_on_your_hips_knees_in_tight_1:
	movl $1, %edx
	movl %ebx, %ecx
	cmpl %r12d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .hands_on_your_hips_knees_in_tight_3
.hands_on_your_hips_knees_in_tight_2:
	movl $1, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	imull $8, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movq (%rcx), %rax
	movl $1, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl (%rcx), %edi
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	movq %rax, %rsi
	addq %rcx, %rsi
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rax, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %ecx, (%rsi)
	addl %edi, (%rsi)
	movl %ebx, %ecx
	addl $1, %ecx
.hands_on_your_hips_knees_in_tight_4:
	movl %ecx, %ebx
	jmp .hands_on_your_hips_knees_in_tight_1
.hands_on_your_hips_knees_in_tight_3:
	movl $1, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_pelvic_thrust:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movl %edx, %eax
.pelvic_thrust_0:
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %rdx
	movq %rsi, %r8
	addq %rdx, %r8
	movl (%r8), %r8d
	movl $1, %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq %rsi, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %ecx, %esi
	movl $0, %edi
	movl %esi, %edx
	subl $1, %edx
	movl $0, %ecx
	cmpl %ecx, %edx
	jl .ternary_true5
	movl %esi, %ecx
	addl $1, %ecx
	movl %eax, %edx
	cmpl %ecx, %edx
	setle %dl
	movzbl %dl, %edx
	jmp .ternary_end6
.ternary_true5:
	movl $1, %edx
.ternary_end6:
	movl $1, %ecx
	cmpl %edx, %ecx
	jnz .pelvic_thrust_3
.pelvic_thrust_1:
	movl $0, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.pelvic_thrust_3:
.pelvic_thrust_4:
.pelvic_thrust_12:
	movl %edi, %ecx
.pelvic_thrust_5:
	movl $1, %eax
	movl $10, %edi
	movl %ecx, %edx
	cmpl %edi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .pelvic_thrust_10
.pelvic_thrust_6:
	movl $2, %edi
	movl %ecx, %eax
	cltd
	idivl %edi
	movl $1, %eax
	movl $0, %edi
	cmpl %edi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .pelvic_thrust_8
.pelvic_thrust_7:
	movl %esi, %edx
	subl $1, %edx
	imull $8, %edx
	movslq %edx, %rdi
	movq %r9, %rdx
	addq %rdi, %rdx
	movq (%rdx), %rbx
	movl %r8d, %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq %rbx, %rax
	addq %rdx, %rax
	movl %r8d, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %rbx, %rdx
	addq %rdi, %rdx
	movl (%rdx), %edx
	movl %edx, (%rax)
	addl $1, (%rax)
.pelvic_thrust_14:
.pelvic_thrust_9:
	addl $1, %ecx
.pelvic_thrust_11:
	jmp .pelvic_thrust_5
.pelvic_thrust_8:
	movl %esi, %edx
	addl $1, %edx
	imull $8, %edx
	movslq %edx, %rdi
	movq %r9, %rdx
	addq %rdi, %rdx
	movq (%rdx), %rax
	movl %r8d, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %rax, %rdx
	addq %rdi, %rdx
	movl %r8d, %edi
	imull $4, %edi
	movslq %edi, %rbx
	movq %rax, %rdi
	addq %rbx, %rdi
	movl (%rdi), %edi
	movl %edi, (%rdx)
	addl $1, (%rdx)
.pelvic_thrust_13:
	jmp .pelvic_thrust_9
.pelvic_thrust_10:
	movl $1, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_main:
	addq $-56, %rsp
	movq %rbp, 8(%rsp)
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
.main_0:
	movl $5, %r9d
	movl $0, %r8d
	movl $1, %edx
	movq $2, %rdi
	movq $4, %rsi
	movq %rdx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r13, %rdx
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rbx
	movl $0, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	movq %rbx, %rsi
	addq %rcx, %rsi
	movl $2, (%rsi)
	movl $1, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	movq %rbx, %rsi
	addq %rcx, %rsi
	movl $2, (%rsi)
	movslq %r9d, %rdi
	movq $8, %rsi
	movq %rdx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq calloc
	movq %r14, %rdx
	movq %r13, %r8
	movq %r12, %r9
	movq %rax, %r12
.main_8:
.main_1:
	movl $1, %esi
	movl %r8d, %ecx
	cmpl %r9d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_3
.main_2:
	movl %r8d, %ecx
	imull $8, %ecx
	movslq %ecx, %rsi
	movq %r12, %rcx
	addq %rsi, %rcx
	movslq %r9d, %rdi
	movq $4, %rsi
	movq %rdx, %rbp
	movq %rcx, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq calloc
	movq %rbp, %rdx
	movq %r15, %rcx
	movq %r14, %r8
	movq %r13, %r9
	movq %rax, (%rcx)
	addl $1, %r8d
.main_7:
	jmp .main_1
.main_3:
.main_10:
	movl %edx, %ecx
.main_4:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .main_6
.main_5:
	movq %r12, %rdi
	movq %rbx, %rsi
	movl %r9d, %edx
	movq %r9, %r13
	callq _c0_jump_to_the_left
	movq %r13, %r9
	movl %eax, %r13d
	movq %r12, %rdi
	movq %rbx, %rsi
	movl %r9d, %edx
	movq %r9, %r14
	callq _c0_step_to_the_right
	movq %r14, %r9
	movl %eax, %r8d
	movq %r12, %rdi
	movq %rbx, %rsi
	movl %r9d, %edx
	movq %r8, %r15
	movq %r9, %r14
	callq _c0_hands_on_your_hips_knees_in_tight
	movq %r15, %r8
	movq %r14, %r9
	movl %eax, %ecx
	movq %r12, %rdi
	movq %rbx, %rsi
	movl %r9d, %edx
	movq %rcx, %rbp
	movq %r8, %r15
	movq %r9, %r14
	callq _c0_pelvic_thrust
	movq %rbp, %rcx
	movq %r15, %r8
	movq %r14, %r9
	movl %eax, %esi
	cmpl $0, %r13d
	jnz .ternary_true11
	movl $0, %edx
	jmp .ternary_end12
.ternary_true11:
	movl %r8d, %edx
.ternary_end12:
	cmpl $0, %edx
	jnz .ternary_true9
	movl $0, %r8d
	jmp .ternary_end10
.ternary_true9:
	movl %ecx, %r8d
.ternary_end10:
	cmpl $0, %r8d
	jnz .ternary_true7
	movl $0, %r8d
	jmp .ternary_end8
.ternary_true7:
	movl %esi, %r8d
.ternary_end8:
.main_9:
	movl %r8d, %ecx
	jmp .main_4
.main_6:
	movl $1, %r9d
	imull $8, %r9d
	movslq %r9d, %r8
	movq %r12, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movl $2, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	movq 8(%rsp), %rbp
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.ident	"15-411 L4 reference compiler"
