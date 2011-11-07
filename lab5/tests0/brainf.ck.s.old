.file	"../tests0/brainf.ck.l4"
.globl _c0_main
_c0_parse:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
	movq %rsi, %r8
	movq %rdx, %r13
.parse_0:
	movl $0, %edx
	movl $0, %ecx
.parse_19:
	movl %ecx, %r12d
	movl %edx, %eax
.parse_1:
	movl $1, %esi
	movl $16384, %edx
	movl %r12d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .parse_25
.parse_2:
	movl %r12d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %edi
	movl $1, %esi
	movl $36, %edx
	movl %edi, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .parse_5
.parse_3:
	jmp .parse_24
.parse_5:
.parse_6:
	movl %r12d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl $1, %esi
	movl $91, %edx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .parse_8
.parse_7:
	movl %eax, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl %r12d, (%rcx)
	movl %eax, %ecx
	addl $1, %ecx
.parse_21:
	movl %ecx, %ebx
.parse_9:
	movl %r12d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl $1, %esi
	movl $93, %edx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .parse_15
.parse_10:
	movl $1, %esi
	movl $0, %edx
	movl %ebx, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .parse_13
.parse_11:
	movl $0, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.parse_13:
.parse_14:
	movl %ebx, %eax
	subl $1, %eax
	movl %eax, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl (%rcx), %edi
	movl %r12d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r13, %rcx
	addq %rdx, %rcx
	movl %edi, (%rcx)
	movl %eax, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl (%rcx), %esi
	movl %esi, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r13, %rcx
	addq %rdx, %rcx
	movl %r12d, (%rcx)
.parse_23:
	movl %eax, %edx
.parse_16:
	movl %r12d, %ecx
	addl $1, %ecx
.parse_18:
	movl %ecx, %r12d
	movl %edx, %eax
	jmp .parse_1
.parse_15:
.parse_22:
	movl %ebx, %edx
	jmp .parse_16
.parse_8:
.parse_20:
	movl %eax, %ebx
	jmp .parse_9
.parse_25:
.parse_17:
	movl $0, %r9d
	cmpl %r9d, %eax
	sete %al
	movzbl %al, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.parse_24:
	jmp .parse_17
_c0_main:
	addq $-248, %rsp
	movq %rbp, 16(%rsp)
	movq %r15, 24(%rsp)
	movq %r14, 32(%rsp)
	movq %r13, 40(%rsp)
	movq %r12, 48(%rsp)
	movq %rbx, 56(%rsp)
.main_0:
	movl $2, %edx
	imull $16384, %edx
	movslq %edx, %rdi
	movq $4, %rsi
	movq %rcx, 64(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, %r13
	callq calloc
	movq 64(%rsp), %rcx
	movq 72(%rsp), %r8
	movq %r13, %r9
	movq %rax, 80(%rsp)
	movq $16384, %rdi
	movq $4, %rsi
	movq %rcx, 64(%rsp)
	movq %r8, 72(%rsp)
	movq %r9, %r13
	callq calloc
	movq 64(%rsp), %rcx
	movq 72(%rsp), %r8
	movq %r13, %r9
	movq %rax, %r13
	movq $16384, %rdi
	movq $4, %rsi
	movq %rcx, 88(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 72(%rsp)
	callq calloc
	movq 88(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 72(%rsp), %r9
	movq %rax, %rdx
	movq $16384, %rdi
	movq $4, %rsi
	movq %rdx, 96(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 64(%rsp)
	movq %r9, 72(%rsp)
	callq calloc
	movq 96(%rsp), %rdx
	movq 88(%rsp), %rcx
	movq 64(%rsp), %r8
	movq 72(%rsp), %r9
	movq %rax, 72(%rsp)
	movl $0, 152(%rsp)
	movq %r13, %rdi
	movq %rdx, 104(%rsp)
	movq %rcx, 112(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 88(%rsp)
	callq _c0_initialize_program
	movq 104(%rsp), %rdx
	movq 112(%rsp), %rcx
	movq 96(%rsp), %r8
	movq 88(%rsp), %r9
	movq %r13, %rdi
	movq %rdx, %rsi
	movq 72(%rsp), %rdx
	movq %rcx, 112(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 88(%rsp)
	callq _c0_parse
	movq 112(%rsp), %rcx
	movq 96(%rsp), %r8
	movq 88(%rsp), %r9
	movl $1, %edx
	movl $1, %esi
	xorl %eax, %esi
	cmpl %esi, %edx
	jnz .main_3
.main_1:
	movl $0, %eax
	subl $1, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $248, %rsp
	ret
.main_3:
.main_4:
	movl $0, %edx
.main_59:
	movl 152(%rsp), %r10d
	movl %r10d, 156(%rsp)
	movl %edx, 160(%rsp)
.main_5:
	movl $1, %edi
	movl $16384, %esi
	movl 160(%rsp), %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_65
.main_6:
	movl 160(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r13, %rdx
	addq %rsi, %rdx
	movl (%rdx), %edx
	movl $1, %eax
	movl $43, %edi
	movl %edx, %esi
	cmpl %edi, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %eax
	jnz .main_9
.main_7:
	movl 156(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rsi
	movq 80(%rsp), %rax
	addq %rsi, %rax
	movl 156(%rsp), %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq 80(%rsp), %rsi
	addq %rdi, %rsi
	movl (%rsi), %esi
	movl %esi, (%rax)
	addl $1, (%rax)
	movl 160(%rsp), %r10d
	movl %r10d, 164(%rsp)
	addl $1, 164(%rsp)
	jmp .main_58
.main_9:
.main_10:
	movl 160(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %rsi
	movq %r13, %r9
	addq %rsi, %r9
	movl (%r9), %esi
	movl $1, %edi
	movl $45, %eax
	movl %esi, %r9d
	cmpl %eax, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edi
	jnz .main_13
.main_11:
	movl 156(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq 80(%rsp), %rax
	addq %r9, %rax
	movl 156(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %rdi
	movq 80(%rsp), %r9
	addq %rdi, %r9
	movl (%r9), %r9d
	movl %r9d, (%rax)
	subl $1, (%rax)
	movl 160(%rsp), %r10d
	movl %r10d, 168(%rsp)
	addl $1, 168(%rsp)
	jmp .main_57
.main_13:
.main_14:
	movl 160(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r13, %r9
	addq %r8, %r9
	movl (%r9), %r10d
	movl %r10d, 152(%rsp)
	movl $1, %edi
	movl $62, %r8d
	movl 152(%rsp), %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edi
	jnz .main_17
.main_15:
	movl 156(%rsp), %r10d
	movl %r10d, 172(%rsp)
	addl $1, 172(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 176(%rsp)
	addl $1, 176(%rsp)
	jmp .main_56
.main_17:
.main_18:
	movl 160(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r13, %r9
	addq %r8, %r9
	movl (%r9), %r10d
	movl %r10d, 180(%rsp)
	movl $1, %edi
	movl $60, %r8d
	movl 180(%rsp), %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edi
	jnz .main_21
.main_19:
	movl 156(%rsp), %r10d
	movl %r10d, 184(%rsp)
	subl $1, 184(%rsp)
	movl 160(%rsp), %r10d
	movl %r10d, 188(%rsp)
	addl $1, 188(%rsp)
	jmp .main_55
.main_21:
.main_22:
	movl 160(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r13, %r9
	addq %r8, %r9
	movl (%r9), %r10d
	movl %r10d, 192(%rsp)
	movl $1, %ecx
	movl $46, %r8d
	movl 192(%rsp), %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_25
.main_23:
	movl 156(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq 80(%rsp), %r9
	addq %r8, %r9
	movl (%r9), %r10d
	movl %r10d, 196(%rsp)
	movl 196(%rsp), %edi
	movq %rsi, %r14
	movq %rdx, %r12
	callq printchar
	movq %r14, %rsi
	movq %r12, %rdx
	movl %eax, %ebp
	movslq %ebp, %r14
	movl 160(%rsp), %r12d
	addl $1, %r12d
	jmp .main_54
.main_25:
.main_26:
	movl 160(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r13, %r9
	addq %r8, %r9
	movl (%r9), %r10d
	movl %r10d, 200(%rsp)
	movl $1, %ecx
	movl $91, %r8d
	movl 200(%rsp), %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_32
.main_27:
	movl 156(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq 80(%rsp), %r9
	addq %r8, %r9
	movl (%r9), %r10d
	movl %r10d, 204(%rsp)
	movl $1, %ecx
	movl $0, %r8d
	movl 204(%rsp), %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_29
.main_28:
	movl 160(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq 72(%rsp), %r9
	addq %r8, %r9
	movl (%r9), %r8d
	movl %r8d, %r9d
.main_61:
	movl %r8d, 208(%rsp)
.main_30:
	movl %r9d, 212(%rsp)
	addl $1, 212(%rsp)
	jmp .main_53
.main_29:
.main_60:
	movl 216(%rsp), %r10d
	movl %r10d, 208(%rsp)
	movl 160(%rsp), %r9d
	jmp .main_30
.main_32:
.main_33:
	movl 160(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r13, %r9
	addq %r8, %r9
	movl (%r9), %edi
	movl $1, %ecx
	movl $93, %r8d
	movl %edi, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_39
.main_34:
	movl 156(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq 80(%rsp), %r8
	addq %r9, %r8
	movl (%r8), %r10d
	movl %r10d, 220(%rsp)
	movl $1, %r8d
	movl $0, %ecx
	movl 220(%rsp), %r9d
	cmpl %ecx, %r9d
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_36
.main_35:
	movl 160(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq 72(%rsp), %r8
	addq %r9, %r8
	movl (%r8), %r8d
	movl %r8d, %r9d
.main_63:
	movl %r8d, 224(%rsp)
.main_37:
	movl %r9d, %r15d
	addl $1, %r15d
	jmp .main_52
.main_36:
.main_62:
	movl %ebx, 224(%rsp)
	movl 160(%rsp), %r9d
	jmp .main_37
.main_39:
.main_40:
	movl 160(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %r13, %r8
	addq %r9, %r8
	movl (%r8), %r10d
	movl %r10d, 228(%rsp)
	movl $1, %r8d
	movl $36, %r9d
	movl 228(%rsp), %ecx
	cmpl %r9d, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .main_43
.main_41:
	jmp .main_64
.main_43:
.main_44:
	movl 160(%rsp), %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %r13, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl $1, %ecx
	movl $44, %eax
	movl %r9d, %r8d
	cmpl %eax, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_47
.main_45:
	movq %rdi, 120(%rsp)
	movq %rsi, 128(%rsp)
	movq %rdx, 136(%rsp)
	movq %r9, 144(%rsp)
	callq readchar
	movq 120(%rsp), %rdi
	movq 128(%rsp), %rsi
	movq 136(%rsp), %rdx
	movq 144(%rsp), %r9
	movl %eax, %ecx
	movl 156(%rsp), %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq 80(%rsp), %rax
	addq %r8, %rax
	movl %ecx, (%rax)
	movl 160(%rsp), %eax
	addl $1, %eax
	jmp .main_51
.main_47:
.main_48:
	movl $42, %eax
	movl $0, %r8d
	cltd
	idivl %r8d
	movslq %eax, %r8
	movl 160(%rsp), %edx
	addl $1, %edx
.main_50:
	movl 228(%rsp), %r10d
	movl %r10d, 232(%rsp)
	movl %edi, 236(%rsp)
	movl 200(%rsp), %r10d
	movl %r10d, 240(%rsp)
	movl 192(%rsp), %ecx
	movl 180(%rsp), %r10d
	movl %r10d, 244(%rsp)
	movl 152(%rsp), %r8d
	movl %esi, %r9d
	movl %edx, 160(%rsp)
	jmp .main_5
.main_65:
.main_49:
	movl $0, %eax
	movq 16(%rsp), %rbp
	movq 24(%rsp), %r15
	movq 32(%rsp), %r14
	movq 40(%rsp), %r13
	movq 48(%rsp), %r12
	movq 56(%rsp), %rbx
	addq $248, %rsp
	ret
.main_51:
	movl 228(%rsp), %r10d
	movl %r10d, 232(%rsp)
	movl %edi, 236(%rsp)
	movl 200(%rsp), %r10d
	movl %r10d, 240(%rsp)
	movl 192(%rsp), %ecx
	movl 180(%rsp), %r10d
	movl %r10d, 244(%rsp)
	movl 152(%rsp), %r8d
	movl %esi, %r9d
	movl %eax, 160(%rsp)
	jmp .main_5
.main_64:
	jmp .main_49
.main_52:
	movl 224(%rsp), %ebx
	movl %edi, 236(%rsp)
	movl 200(%rsp), %r10d
	movl %r10d, 240(%rsp)
	movl 192(%rsp), %ecx
	movl 180(%rsp), %r10d
	movl %r10d, 244(%rsp)
	movl 152(%rsp), %r8d
	movl %esi, %r9d
	movl %r15d, 160(%rsp)
	jmp .main_5
.main_53:
	movl 208(%rsp), %r10d
	movl %r10d, 216(%rsp)
	movl 200(%rsp), %r10d
	movl %r10d, 240(%rsp)
	movl 192(%rsp), %ecx
	movl 180(%rsp), %r10d
	movl %r10d, 244(%rsp)
	movl 152(%rsp), %r8d
	movl %esi, %r9d
	movl 212(%rsp), %r10d
	movl %r10d, 160(%rsp)
	jmp .main_5
.main_54:
	movl 192(%rsp), %ecx
	movl 180(%rsp), %r10d
	movl %r10d, 244(%rsp)
	movl 152(%rsp), %r8d
	movl %esi, %r9d
	movl %r12d, 160(%rsp)
	jmp .main_5
.main_55:
	movl 180(%rsp), %r10d
	movl %r10d, 244(%rsp)
	movl 152(%rsp), %r8d
	movl %esi, %r9d
	movl 184(%rsp), %r10d
	movl %r10d, 156(%rsp)
	movl 188(%rsp), %r10d
	movl %r10d, 160(%rsp)
	jmp .main_5
.main_56:
	movl 152(%rsp), %r8d
	movl %esi, %r9d
	movl 172(%rsp), %r10d
	movl %r10d, 156(%rsp)
	movl 176(%rsp), %r10d
	movl %r10d, 160(%rsp)
	jmp .main_5
.main_57:
	movl %esi, %r9d
	movl 168(%rsp), %r10d
	movl %r10d, 160(%rsp)
	jmp .main_5
.main_58:
	movl 164(%rsp), %r10d
	movl %r10d, 160(%rsp)
	jmp .main_5
_c0_initialize_program:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.initialize_program_0:
	movl $0, %r8d
.initialize_program_9:
.initialize_program_1:
	movl $1, %edx
	movl $1, %ecx
	cmpl %ecx, %edx
	jnz .initialize_program_11
.initialize_program_2:
	movq %r8, %r12
	movq %r9, %rbx
	callq readchar
	movq %r12, %r8
	movq %rbx, %r9
	movl %r8d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl %eax, (%rcx)
	movl %r8d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %edi
	movl $1, %esi
	movl $36, %edx
	movl %edi, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .initialize_program_5
.initialize_program_3:
	jmp .initialize_program_10
.initialize_program_5:
.initialize_program_6:
	addl $1, %r8d
.initialize_program_8:
	jmp .initialize_program_1
.initialize_program_11:
.initialize_program_7:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.initialize_program_10:
	jmp .initialize_program_7
.ident	"15-411 L4 reference compiler"
