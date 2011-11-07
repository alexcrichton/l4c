.file	"../tests2/saltopus-8queens.l3"
.globl _c0_main
_c0_abs:
	addq $-8, %rsp
.abs_0:
	movl $1, %ecx
	movl $0, %r8d
	cmpl %edi, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .abs_3
.abs_1:
	movl %edi, %eax
	addq $8, %rsp
	ret
.abs_3:
.abs_4:
	movl $0, %eax
	subl %edi, %eax
	addq $8, %rsp
	ret
_c0_safe:
	addq $-88, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
	movl %edi, %ebx
	movl %r9d, %r13d
	movl 96(%rsp), %r14d
	movl 104(%rsp), %r9d
	movl 112(%rsp), %r12d
.safe_0:
.safe_1:
	movl $1, %eax
	movl $1, %edi
	cmpl %edi, %eax
	jnz .safe_68
.safe_2:
	movl $1, %r15d
	movl $0, %eax
	movl %esi, %edi
	cmpl %eax, %edi
	setle %dil
	movzbl %dil, %edi
	cmpl %edi, %r15d
	jnz .safe_5
.safe_3:
	jmp .safe_68
.safe_5:
.safe_6:
	cmpl %ebx, %edx
	jz .ternary_true1
	movl %edx, %edi
	subl %ebx, %edi
	movq %rsi, 64(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, %rbp
	movq %r9, %r15
	callq _c0_abs
	movq 64(%rsp), %rsi
	movq 72(%rsp), %rcx
	movq %rbp, %r8
	movq %r15, %r9
	movl %eax, %edx
	movl $0, %edi
	subl %esi, %edi
	movq %rsi, 80(%rsp)
	movq %rdx, 64(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, %rbp
	movq %r9, %r15
	callq _c0_abs
	movq 80(%rsp), %rsi
	movq 64(%rsp), %rdx
	movq 72(%rsp), %rcx
	movq %rbp, %r8
	movq %r15, %r9
	cmpl %eax, %edx
	sete %dl
	movzbl %dl, %edx
	jmp .ternary_end2
.ternary_true1:
	movl $1, %edx
.ternary_end2:
	movl $1, %edi
	cmpl %edx, %edi
	jnz .safe_9
.safe_7:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $88, %rsp
	ret
.safe_9:
.safe_10:
	movl $1, %eax
	movl $1, %edx
	movl %esi, %edi
	cmpl %edx, %edi
	setle %dil
	movzbl %dil, %edi
	cmpl %edi, %eax
	jnz .safe_13
.safe_11:
	jmp .safe_68
.safe_13:
.safe_14:
	cmpl %ebx, %ecx
	jz .ternary_true3
	movl %ecx, %edi
	subl %ebx, %edi
	movq %rsi, 72(%rsp)
	movq %r8, %rbp
	movq %r9, %r15
	callq _c0_abs
	movq 72(%rsp), %rsi
	movq %rbp, %r8
	movq %r15, %r9
	movl %eax, %ecx
	movl $1, %edi
	subl %esi, %edi
	movq %rsi, 64(%rsp)
	movq %rcx, 72(%rsp)
	movq %r8, %rbp
	movq %r9, %r15
	callq _c0_abs
	movq 64(%rsp), %rsi
	movq 72(%rsp), %rcx
	movq %rbp, %r8
	movq %r15, %r9
	movl %ecx, %edi
	cmpl %eax, %edi
	sete %dil
	movzbl %dil, %edi
	jmp .ternary_end4
.ternary_true3:
	movl $1, %edi
.ternary_end4:
	movl $1, %ecx
	cmpl %edi, %ecx
	jnz .safe_17
.safe_15:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $88, %rsp
	ret
.safe_17:
.safe_18:
	movl $1, %edi
	movl $2, %ecx
	movl %esi, %edx
	cmpl %ecx, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .safe_21
.safe_19:
	jmp .safe_68
.safe_21:
.safe_22:
	cmpl %ebx, %r8d
	jz .ternary_true5
	movl %r8d, %edi
	subl %ebx, %edi
	movq %rsi, %rbp
	movq %r9, %r15
	callq _c0_abs
	movq %rbp, %rsi
	movq %r15, %r9
	movl %eax, %r8d
	movl $2, %edi
	subl %esi, %edi
	movq %rsi, 72(%rsp)
	movq %r8, %rbp
	movq %r9, %r15
	callq _c0_abs
	movq 72(%rsp), %rsi
	movq %rbp, %r8
	movq %r15, %r9
	movl %r8d, %edx
	cmpl %eax, %edx
	sete %dl
	movzbl %dl, %edx
	jmp .ternary_end6
.ternary_true5:
	movl $1, %edx
.ternary_end6:
	movl $1, %r8d
	cmpl %edx, %r8d
	jnz .safe_25
.safe_23:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $88, %rsp
	ret
.safe_25:
.safe_26:
	movl $1, %ecx
	movl $3, %edx
	movl %esi, %r8d
	cmpl %edx, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .safe_29
.safe_27:
	jmp .safe_68
.safe_29:
.safe_30:
	cmpl %ebx, %r13d
	jz .ternary_true7
	movl %r13d, %edi
	subl %ebx, %edi
	movq %rsi, %r15
	movq %r9, %r13
	callq _c0_abs
	movq %r15, %rsi
	movq %r13, %r9
	movl %eax, %r8d
	movl $3, %edi
	subl %esi, %edi
	movq %rsi, %rbp
	movq %r8, %r15
	movq %r9, %r13
	callq _c0_abs
	movq %rbp, %rsi
	movq %r15, %r8
	movq %r13, %r9
	movl %r8d, %ecx
	cmpl %eax, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end8
.ternary_true7:
	movl $1, %ecx
.ternary_end8:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .safe_33
.safe_31:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $88, %rsp
	ret
.safe_33:
.safe_34:
	movl $1, %edx
	movl $4, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .safe_37
.safe_35:
	jmp .safe_68
.safe_37:
.safe_38:
	cmpl %ebx, %r14d
	jz .ternary_true9
	movl %r14d, %edi
	subl %ebx, %edi
	movq %rsi, %r14
	movq %r9, %r13
	callq _c0_abs
	movq %r14, %rsi
	movq %r13, %r9
	movl %eax, %r8d
	movl $4, %edi
	subl %esi, %edi
	movq %rsi, %r15
	movq %r8, %r14
	movq %r9, %r13
	callq _c0_abs
	movq %r15, %rsi
	movq %r14, %r8
	movq %r13, %r9
	movl %r8d, %ecx
	cmpl %eax, %ecx
	sete %cl
	movzbl %cl, %ecx
	jmp .ternary_end10
.ternary_true9:
	movl $1, %ecx
.ternary_end10:
	movl $1, %r8d
	cmpl %ecx, %r8d
	jnz .safe_41
.safe_39:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $88, %rsp
	ret
.safe_41:
.safe_42:
	movl $1, %edx
	movl $5, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	setle %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .safe_45
.safe_43:
	jmp .safe_68
.safe_45:
.safe_46:
	cmpl %ebx, %r9d
	jz .ternary_true11
	movl %r9d, %edi
	subl %ebx, %edi
	movq %rsi, %r13
	callq _c0_abs
	movq %r13, %rsi
	movl %eax, %r9d
	movl $5, %edi
	subl %esi, %edi
	movq %rsi, %r14
	movq %r9, %r13
	callq _c0_abs
	movq %r14, %rsi
	movq %r13, %r9
	movl %r9d, %r8d
	cmpl %eax, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	jmp .ternary_end12
.ternary_true11:
	movl $1, %r8d
.ternary_end12:
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .safe_49
.safe_47:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $88, %rsp
	ret
.safe_49:
.safe_50:
	movl $1, %ecx
	movl $6, %r8d
	movl %esi, %r9d
	cmpl %r8d, %r9d
	setle %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .safe_53
.safe_51:
	jmp .safe_68
.safe_53:
.safe_54:
	cmpl %ebx, %r12d
	jz .ternary_true13
	movl %r12d, %edi
	subl %ebx, %edi
	movq %rsi, %r13
	callq _c0_abs
	movq %r13, %rsi
	movl %eax, %r9d
	movl $6, %edi
	subl %esi, %edi
	movq %rsi, %r14
	movq %r9, %r13
	callq _c0_abs
	movq %r14, %rsi
	movq %r13, %r9
	cmpl %eax, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	jmp .ternary_end14
.ternary_true13:
	movl $1, %r9d
.ternary_end14:
	movl $1, %r8d
	cmpl %r9d, %r8d
	jnz .safe_57
.safe_55:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $88, %rsp
	ret
.safe_57:
.safe_58:
	movl $1, %r8d
	movl $7, %r9d
	movl %esi, %ecx
	cmpl %r9d, %ecx
	setle %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .safe_61
.safe_59:
	jmp .safe_68
.safe_61:
.safe_62:
	cmpl %ebx, %r12d
	jz .ternary_true15
	movl %r12d, %edi
	subl %ebx, %edi
	movq %rsi, %rbx
	callq _c0_abs
	movq %rbx, %rsi
	movl %eax, %r9d
	movl $7, %edi
	subl %esi, %edi
	movq %r9, %rbx
	callq _c0_abs
	movq %rbx, %r9
	movl %r9d, %r8d
	cmpl %eax, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	jmp .ternary_end16
.ternary_true15:
	movl $1, %r8d
.ternary_end16:
	movl $1, %r9d
	cmpl %r8d, %r9d
	jnz .safe_65
.safe_63:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $88, %rsp
	ret
.safe_65:
.safe_66:
	jmp .safe_68
.safe_68:
	movl $1, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $88, %rsp
	ret
	jmp .safe_68
	jmp .safe_68
	jmp .safe_68
	jmp .safe_68
	jmp .safe_68
	jmp .safe_68
	jmp .safe_68
	jmp .safe_68
	jmp .safe_68
_c0_try:
	addq $-248, %rsp
	movq %rbp, 36(%rsp)
	movq %r15, 44(%rsp)
	movq %r14, 52(%rsp)
	movq %r13, 60(%rsp)
	movq %r12, 68(%rsp)
	movq %rbx, 76(%rsp)
	movl %edi, 84(%rsp)
	movl %esi, 88(%rsp)
	movl %edx, 92(%rsp)
	movl %ecx, 96(%rsp)
	movl %r8d, 100(%rsp)
	movl %r9d, 104(%rsp)
	movl 256(%rsp), %r10d
	movl %r10d, 108(%rsp)
	movl 264(%rsp), %r10d
	movl %r10d, 112(%rsp)
	movl 272(%rsp), %r10d
	movl %r10d, 116(%rsp)
.try_0:
	movl $0, %r8d
	movl $1, %r9d
	movl $8, %ecx
	movl 84(%rsp), %edx
	cmpl %ecx, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %r9d
	jnz .try_3
.try_1:
	movl $1, %eax
	movq 36(%rsp), %rbp
	movq 44(%rsp), %r15
	movq 52(%rsp), %r14
	movq 60(%rsp), %r13
	movq 68(%rsp), %r12
	movq 76(%rsp), %rbx
	addq $248, %rsp
	ret
.try_3:
.try_4:
	movl $0, %r9d
.try_36:
	movl %r8d, 120(%rsp)
	movl %r9d, 124(%rsp)
.try_5:
	movl $1, %ecx
	movl $8, %r9d
	movl 124(%rsp), %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .try_34
.try_6:
	movl 124(%rsp), %edi
	movl 84(%rsp), %esi
	movl 88(%rsp), %edx
	movl 92(%rsp), %ecx
	movl 96(%rsp), %r8d
	movl 100(%rsp), %r9d
	movl 104(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl 108(%rsp), %r10d
	movl %r10d, 8(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 16(%rsp)
	movl 116(%rsp), %r10d
	movl %r10d, 24(%rsp)
	callq _c0_safe
	movl $1, %r9d
	cmpl %eax, %r9d
	jnz .try_32
.try_7:
	movl $1, %r9d
	movl $0, %r8d
	movl 84(%rsp), %ecx
	cmpl %r8d, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r9d
	jnz .try_8
.try_29:
	movl 84(%rsp), %edi
	addl $1, %edi
	movl 124(%rsp), %esi
	movl 92(%rsp), %edx
	movl 96(%rsp), %ecx
	movl 100(%rsp), %r8d
	movl 104(%rsp), %r9d
	movl 108(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 8(%rsp)
	movl 116(%rsp), %r10d
	movl %r10d, 16(%rsp)
	callq _c0_try
	movl 120(%rsp), %r9d
	addl %eax, %r9d
.try_52:
	movl %eax, 128(%rsp)
.try_31:
.try_54:
.try_33:
	movl 124(%rsp), %r8d
	addl $1, %r8d
.try_35:
	movl %r9d, 120(%rsp)
	movl %r8d, 124(%rsp)
	jmp .try_5
.try_8:
	movl $1, %r9d
	movl $1, %r8d
	movl 84(%rsp), %ecx
	cmpl %r8d, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r9d
	jnz .try_9
.try_27:
	movl 84(%rsp), %edi
	addl $1, %edi
	movl 88(%rsp), %esi
	movl 124(%rsp), %edx
	movl 96(%rsp), %ecx
	movl 100(%rsp), %r8d
	movl 104(%rsp), %r9d
	movl 108(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 8(%rsp)
	movl 116(%rsp), %r10d
	movl %r10d, 16(%rsp)
	callq _c0_try
	movl 120(%rsp), %r9d
	addl %eax, %r9d
.try_50:
	movl %eax, 132(%rsp)
.try_30:
.try_51:
	movl 136(%rsp), %r10d
	movl %r10d, 140(%rsp)
	movl 144(%rsp), %r10d
	movl %r10d, 148(%rsp)
	movl 152(%rsp), %r10d
	movl %r10d, 156(%rsp)
	movl 160(%rsp), %ebp
	movl 164(%rsp), %r10d
	movl %r10d, 168(%rsp)
	movl 172(%rsp), %r10d
	movl %r10d, 176(%rsp)
	movl 132(%rsp), %r10d
	movl %r10d, 180(%rsp)
	jmp .try_31
.try_9:
	movl $1, %ecx
	movl $2, %r9d
	movl 84(%rsp), %r8d
	cmpl %r9d, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .try_10
.try_25:
	movl 84(%rsp), %edi
	addl $1, %edi
	movl 88(%rsp), %esi
	movl 92(%rsp), %edx
	movl 124(%rsp), %ecx
	movl 100(%rsp), %r8d
	movl 104(%rsp), %r9d
	movl 108(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 8(%rsp)
	movl 116(%rsp), %r10d
	movl %r10d, 16(%rsp)
	callq _c0_try
	movl 120(%rsp), %r9d
	addl %eax, %r9d
.try_48:
	movl %eax, 184(%rsp)
.try_28:
.try_49:
	movl 188(%rsp), %r10d
	movl %r10d, 136(%rsp)
	movl 192(%rsp), %r10d
	movl %r10d, 144(%rsp)
	movl 196(%rsp), %r10d
	movl %r10d, 152(%rsp)
	movl 200(%rsp), %r10d
	movl %r10d, 160(%rsp)
	movl %r15d, 164(%rsp)
	movl 184(%rsp), %r10d
	movl %r10d, 172(%rsp)
	jmp .try_30
.try_10:
	movl $1, %ecx
	movl $3, %r8d
	movl 84(%rsp), %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .try_11
.try_23:
	movl 84(%rsp), %edi
	addl $1, %edi
	movl 88(%rsp), %esi
	movl 92(%rsp), %edx
	movl 96(%rsp), %ecx
	movl 124(%rsp), %r8d
	movl 104(%rsp), %r9d
	movl 108(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 8(%rsp)
	movl 116(%rsp), %r10d
	movl %r10d, 16(%rsp)
	callq _c0_try
	movl 120(%rsp), %r9d
	addl %eax, %r9d
.try_46:
	movl %eax, 204(%rsp)
.try_26:
.try_47:
	movl 208(%rsp), %r10d
	movl %r10d, 188(%rsp)
	movl 212(%rsp), %r10d
	movl %r10d, 192(%rsp)
	movl 216(%rsp), %r10d
	movl %r10d, 196(%rsp)
	movl 220(%rsp), %r10d
	movl %r10d, 200(%rsp)
	movl 204(%rsp), %r15d
	jmp .try_28
.try_11:
	movl $1, %r8d
	movl $4, %r9d
	movl 84(%rsp), %ecx
	cmpl %r9d, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .try_12
.try_21:
	movl 84(%rsp), %edi
	addl $1, %edi
	movl 88(%rsp), %esi
	movl 92(%rsp), %edx
	movl 96(%rsp), %ecx
	movl 100(%rsp), %r8d
	movl 124(%rsp), %r9d
	movl 108(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 8(%rsp)
	movl 116(%rsp), %r10d
	movl %r10d, 16(%rsp)
	callq _c0_try
	movl 120(%rsp), %r8d
	addl %eax, %r8d
.try_44:
	movl %eax, 224(%rsp)
	movl %r8d, %r9d
.try_24:
.try_45:
	movl 228(%rsp), %r10d
	movl %r10d, 208(%rsp)
	movl %r14d, 212(%rsp)
	movl 232(%rsp), %r10d
	movl %r10d, 216(%rsp)
	movl 224(%rsp), %r10d
	movl %r10d, 220(%rsp)
	jmp .try_26
.try_12:
	movl $1, %r8d
	movl $5, %r9d
	movl 84(%rsp), %ecx
	cmpl %r9d, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .try_13
.try_19:
	movl 84(%rsp), %edi
	addl $1, %edi
	movl 88(%rsp), %esi
	movl 92(%rsp), %edx
	movl 96(%rsp), %ecx
	movl 100(%rsp), %r8d
	movl 104(%rsp), %r9d
	movl 124(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 8(%rsp)
	movl 116(%rsp), %r10d
	movl %r10d, 16(%rsp)
	callq _c0_try
	movl 120(%rsp), %r9d
	addl %eax, %r9d
.try_42:
	movl %eax, 236(%rsp)
.try_22:
.try_43:
	movl 240(%rsp), %r10d
	movl %r10d, 228(%rsp)
	movl %r13d, %r14d
	movl 236(%rsp), %r10d
	movl %r10d, 232(%rsp)
	jmp .try_24
.try_13:
	movl $1, %ecx
	movl $6, %r9d
	movl 84(%rsp), %r8d
	cmpl %r9d, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .try_14
.try_17:
	movl 84(%rsp), %edi
	addl $1, %edi
	movl 88(%rsp), %esi
	movl 92(%rsp), %edx
	movl 96(%rsp), %ecx
	movl 100(%rsp), %r8d
	movl 104(%rsp), %r9d
	movl 108(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl 124(%rsp), %r10d
	movl %r10d, 8(%rsp)
	movl 116(%rsp), %r10d
	movl %r10d, 16(%rsp)
	callq _c0_try
	movl 120(%rsp), %r8d
	addl %eax, %r8d
.try_40:
	movl %eax, 244(%rsp)
	movl %r8d, %r9d
.try_20:
.try_41:
	movl %r12d, 240(%rsp)
	movl 244(%rsp), %r13d
	jmp .try_22
.try_14:
	movl $1, %r9d
	movl $7, %ecx
	movl 84(%rsp), %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %r9d
	jnz .try_16
.try_15:
	movl 84(%rsp), %edi
	addl $1, %edi
	movl 88(%rsp), %esi
	movl 92(%rsp), %edx
	movl 96(%rsp), %ecx
	movl 100(%rsp), %r8d
	movl 104(%rsp), %r9d
	movl 108(%rsp), %r10d
	movl %r10d, 0(%rsp)
	movl 112(%rsp), %r10d
	movl %r10d, 8(%rsp)
	movl 124(%rsp), %r10d
	movl %r10d, 16(%rsp)
	callq _c0_try
	movl 120(%rsp), %r8d
	addl %eax, %r8d
.try_38:
	movl %eax, %ebx
	movl %r8d, %r9d
.try_18:
.try_39:
	movl %ebx, %r12d
	jmp .try_20
.try_16:
.try_37:
	movl 120(%rsp), %r9d
	jmp .try_18
.try_32:
.try_53:
	movl 120(%rsp), %r9d
	jmp .try_33
.try_34:
	movl 120(%rsp), %eax
	movq 36(%rsp), %rbp
	movq 44(%rsp), %r15
	movq 52(%rsp), %r14
	movq 60(%rsp), %r13
	movq 68(%rsp), %r12
	movq 76(%rsp), %rbx
	addq $248, %rsp
	ret
_c0_t:
	addq $-40, %rsp
.t_0:
	movl $0, %esi
	subl $1, %esi
	movl $0, %edx
	subl $1, %edx
	movl $0, %ecx
	subl $1, %ecx
	movl $0, %r8d
	subl $1, %r8d
	movl $0, %r9d
	subl $1, %r9d
	movl $0, 0(%rsp)
	subl $1, 0(%rsp)
	movl $0, 8(%rsp)
	subl $1, 8(%rsp)
	movl $0, 16(%rsp)
	subl $1, 16(%rsp)
	callq _c0_try
	addq $40, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl %r9d, %edi
	callq _c0_t
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
