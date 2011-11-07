.file	"../tests2/stegosaurus-mazegen.l4"
.globl _c0_main
_c0_generateNumbers:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.generateNumbers_0:
	movq $0, %r8
	movq %rdi, %r9
	addq %r8, %r9
	movq (%r9), %r9
	movl $0, %r8d
.generateNumbers_8:
	movl %r8d, %ecx
.generateNumbers_1:
	movl $1, %r8d
	movl $624, %esi
	movl %ecx, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %r8d
	jnz .generateNumbers_6
.generateNumbers_2:
	movl %ecx, %r8d
	imull $4, %r8d
	movslq %r8d, %rdx
	movq %r9, %r8
	addq %rdx, %r8
	movl (%r8), %esi
	movl %ecx, %eax
	addl $1, %eax
	movl $624, %r8d
	cltd
	idivl %r8d
	movl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %rdx
	movq %r9, %r8
	addq %rdx, %r8
	movl (%r8), %edx
	movl %esi, %r8d
	andl $-2147483648, %r8d
	andl $2147483647, %edx
	addl %edx, %r8d
	movl %ecx, %eax
	addl $397, %eax
	movl $624, %esi
	cltd
	idivl %esi
	imull $4, %edx
	movslq %edx, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movl (%rdx), %ebx
	movl %ecx, %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq %r9, %rax
	addq %rdx, %rax
	movl %r8d, %edi
	sarl $1, %edi
	movl $0, %edx
	subl $1, %edx
	sall $31, %edx
	movl $-1, %esi
	xorl %edx, %esi
	movl %edi, %edx
	andl %esi, %edx
	movl %ebx, (%rax)
	xorl %edx, (%rax)
	movl $1, %esi
	andl $1, %r8d
	movl $1, %edx
	cmpl %edx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %esi
	jnz .generateNumbers_4
.generateNumbers_3:
	movl %ecx, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %r9, %rdx
	addq %r8, %rdx
	movl %ecx, %r8d
	imull $4, %r8d
	movslq %r8d, %rsi
	movq %r9, %r8
	addq %rsi, %r8
	movl (%r8), %r8d
	movl %r8d, (%rdx)
	xorl $-1727483681, (%rdx)
.generateNumbers_5:
	movl %ecx, %r8d
	addl $1, %r8d
.generateNumbers_7:
	movl %r8d, %ecx
	jmp .generateNumbers_1
.generateNumbers_4:
	jmp .generateNumbers_5
.generateNumbers_6:
	movl $4, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_init_rand:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.init_rand_0:
	movq $1, %rdi
	movq $12, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movq $624, %rdi
	movq $4, %rsi
	movq %r8, %r12
	movq %r9, %rbx
	callq calloc
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rbx
	movq $0, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movq %rbx, (%rcx)
	movq $8, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $0, (%rcx)
	movl $0, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %rbx, %rcx
	addq %rdx, %rcx
	movl %r9d, (%rcx)
	movl $1, %r9d
.init_rand_5:
	movl %r9d, %eax
.init_rand_1:
	movl $1, %edx
	movl $624, %ecx
	movl %eax, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edx
	jnz .init_rand_3
.init_rand_2:
	movl %eax, %r9d
	subl $1, %r9d
	imull $4, %r9d
	movslq %r9d, %rcx
	movq %rbx, %r9
	addq %rcx, %r9
	movl (%r9), %edi
	movl %eax, %r9d
	subl $1, %r9d
	imull $4, %r9d
	movslq %r9d, %rcx
	movq %rbx, %r9
	addq %rcx, %r9
	movl (%r9), %ecx
	movl %eax, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %rbx, %rsi
	addq %r9, %rsi
	movl %ecx, %edx
	sarl $30, %edx
	movl $0, %r9d
	subl $1, %r9d
	movl %r9d, %ecx
	sall $2, %ecx
	movl $-1, %r9d
	xorl %ecx, %r9d
	movl %edx, %ecx
	andl %r9d, %ecx
	movl %edi, %r9d
	xorl %ecx, %r9d
	movl $1812433253, %ecx
	imull %r9d, %ecx
	movl %ecx, (%rsi)
	addl %eax, (%rsi)
	movl %eax, %r9d
	addl $1, %r9d
.init_rand_4:
	movl %r9d, %eax
	jmp .init_rand_1
.init_rand_3:
	movq %r8, %rax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_rand:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
.rand_0:
	movq $8, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl (%rcx), %ecx
	movl $1, %r8d
	movl $0, %edx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .rand_2
.rand_1:
	movq %r9, %rdi
	movq %r9, %rbx
	callq _c0_generateNumbers
	movq %rbx, %r9
.rand_3:
	movq $0, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movq (%r8), %r8
	movq %r8, %rdx
	movq $8, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdx, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, %esi
	movl %esi, %r8d
	sarl $11, %r8d
	movl $0, %ecx
	subl $1, %ecx
	movl %ecx, %edx
	sall $21, %edx
	movl $-1, %ecx
	xorl %edx, %ecx
	andl %ecx, %r8d
	movl %esi, %ecx
	xorl %r8d, %ecx
	movl %ecx, %r8d
	sall $7, %r8d
	andl $-1658038656, %r8d
	xorl %r8d, %ecx
	movl %ecx, %r8d
	sall $15, %r8d
	andl $-272236544, %r8d
	movl %ecx, %esi
	xorl %r8d, %esi
	movl %esi, %edx
	sarl $18, %edx
	movl $0, %r8d
	subl $1, %r8d
	movl %r8d, %ecx
	sall $14, %ecx
	movl $-1, %r8d
	xorl %ecx, %r8d
	movl %edx, %ecx
	andl %r8d, %ecx
	movl %esi, %r8d
	xorl %ecx, %r8d
	movq $8, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %ecx, %eax
	addl $1, %eax
	movl $624, %ecx
	cltd
	idivl %ecx
	movq $8, %rcx
	addq %rcx, %r9
	movl %edx, (%r9)
	movl %r8d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.rand_2:
	jmp .rand_3
_c0_shuffle:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.shuffle_0:
	movl $1234567890, %edi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_init_rand
	movq %r12, %r8
	movq %rbx, %r9
	movq %rax, %rcx
	movl $0, %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq %r9, %rsi
	addq %rdx, %rsi
	movl $0, (%rsi)
	movl $1, %edx
.shuffle_8:
	movl %edx, %esi
.shuffle_1:
	movl $1, %edi
	movl %esi, %edx
	cmpl %r8d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .shuffle_6
.shuffle_2:
	movq %rcx, %rdi
	movq %rsi, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_rand
	movq %r14, %rsi
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %esi, %edi
	addl $1, %edi
	cltd
	idivl %edi
	movl %edx, %r12d
	movl $1, %eax
	movl $0, %edi
	movl %r12d, %edx
	cmpl %edi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .shuffle_4
.shuffle_3:
	movl %esi, %edi
	addl $1, %edi
	movl %r12d, %edx
	addl %edi, %edx
.shuffle_10:
	movl %edx, %ebx
.shuffle_5:
	movl %ebx, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r9, %rdx
	addq %rdi, %rdx
	movl (%rdx), %eax
	movl %esi, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r9, %rdx
	addq %rdi, %rdx
	movl %eax, (%rdx)
	movl %ebx, %edx
	imull $4, %edx
	movslq %edx, %rdi
	movq %r9, %rdx
	addq %rdi, %rdx
	movl %esi, (%rdx)
	movl %esi, %edx
	addl $1, %edx
.shuffle_7:
	movl %edx, %esi
	jmp .shuffle_1
.shuffle_4:
.shuffle_9:
	movl %r12d, %ebx
	jmp .shuffle_5
.shuffle_6:
	movq %rcx, %rdi
	callq _c0_rand
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_get_comp:
	addq $-8, %rsp
.get_comp_0:
	movl %esi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
.get_comp_5:
	movl %r8d, %esi
.get_comp_1:
	movl %esi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %edx
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %edx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .get_comp_3
.get_comp_2:
	movl %esi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rdi, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
.get_comp_4:
	movl %r8d, %esi
	jmp .get_comp_1
.get_comp_3:
	movl %esi, %eax
	addq $8, %rsp
	ret
_c0_one_comp:
	addq $-40, %rsp
	movq %r14, 8(%rsp)
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
	movl %esi, %r8d
.one_comp_0:
	movq %r9, %rdi
	movl $0, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_get_comp
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl $1, %ecx
.one_comp_9:
.one_comp_1:
	movl $1, %edi
	movl %ecx, %esi
	cmpl %r8d, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .one_comp_7
.one_comp_2:
	movq %r9, %rdi
	movl %ecx, %esi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_get_comp
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edi
	movl %eax, %esi
	cmpl %edx, %esi
	setne %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .one_comp_5
.one_comp_3:
	movl $0, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.one_comp_5:
.one_comp_6:
	addl $1, %ecx
.one_comp_8:
	jmp .one_comp_1
.one_comp_7:
	movl $1, %eax
	movq 8(%rsp), %r14
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_join:
	addq $-56, %rsp
	movq %r15, 16(%rsp)
	movq %r14, 24(%rsp)
	movq %r13, 32(%rsp)
	movq %r12, 40(%rsp)
	movq %rbx, 48(%rsp)
	movq %rdi, %r9
	movq %rsi, %r8
.join_0:
	movq %r9, %rdi
	movl %edx, %esi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_get_comp
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %ebx
	movq %r9, %rdi
	movl %ecx, %esi
	movq %rdx, %r15
	movq %rcx, %r14
	movq %r8, %r13
	movq %r9, %r12
	callq _c0_get_comp
	movq %r15, %rdx
	movq %r14, %rcx
	movq %r13, %r8
	movq %r12, %r9
	movl %eax, %r13d
	movl $1, %edi
	movl %ebx, %esi
	cmpl %r13d, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .join_3
.join_1:
	movl $0, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.join_3:
.join_4:
	movl %r13d, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %r8, %rsi
	addq %rdi, %rsi
	movl (%rsi), %r12d
	movl %ebx, %esi
	imull $4, %esi
	movslq %esi, %rdi
	movq %r8, %rsi
	addq %rdi, %rsi
	movl (%rsi), %eax
	movl $1, %edi
	movl %r12d, %esi
	cmpl %eax, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edi
	jnz .join_8
.join_5:
	movl %r13d, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r8, %rdx
	addq %rsi, %rdx
	movl (%rdx), %edi
	movl %ebx, %edx
	imull $4, %edx
	movslq %edx, %rdx
	movq %r8, %rsi
	addq %rdx, %rsi
	movl %ebx, %edx
	imull $4, %edx
	movslq %edx, %rdx
	addq %rdx, %r8
	movl (%r8), %r8d
	movl %r8d, (%rsi)
	addl %edi, (%rsi)
	movl %r13d, %r8d
	imull $4, %r8d
	movslq %r8d, %rdx
	movq %r9, %r8
	addq %rdx, %r8
	movl %ebx, (%r8)
	movl %ecx, %r8d
.join_15:
	movl %r8d, %edx
.join_6:
	movl $1, %ecx
	movl %edx, %r8d
	cmpl %ebx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .join_11
.join_7:
	movl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, %edx
	movl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl %ebx, (%r8)
.join_14:
	jmp .join_6
.join_11:
.join_19:
.join_13:
	movl $1, %eax
	movq 16(%rsp), %r15
	movq 24(%rsp), %r14
	movq 32(%rsp), %r13
	movq 40(%rsp), %r12
	movq 48(%rsp), %rbx
	addq $56, %rsp
	ret
.join_8:
	movl %ebx, %ecx
	imull $4, %ecx
	movslq %ecx, %rsi
	movq %r8, %rcx
	addq %rsi, %rcx
	movl (%rcx), %edi
	movl %r13d, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	movq %r8, %rsi
	addq %rcx, %rsi
	movl %r13d, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	addq %rcx, %r8
	movl (%r8), %r8d
	movl %r8d, (%rsi)
	addl %edi, (%rsi)
	movl %ebx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl %r13d, (%r8)
	movl %edx, %r8d
.join_17:
	movl %r8d, %edx
.join_9:
	movl $1, %ecx
	movl %edx, %r8d
	cmpl %r13d, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .join_12
.join_10:
	movl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl (%rcx), %r8d
	movl %r8d, %edx
	movl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl %r13d, (%r8)
.join_16:
	jmp .join_9
.join_12:
.join_18:
	jmp .join_13
_c0_adler:
	addq $-8, %rsp
	movl %edx, %ecx
.adler_0:
	movq %rdi, %rdx
	movl (%rdx), %edx
	movl %edx, %eax
	addl %ecx, %eax
	movl $65521, %ecx
	cltd
	idivl %ecx
	movq %rdi, %rcx
	movl %edx, (%rcx)
	movq %rsi, %rcx
	movl (%rcx), %ecx
	movq %rdi, %r9
	movl (%r9), %r9d
	movl %ecx, %eax
	addl %r9d, %eax
	movl $65521, %r9d
	cltd
	idivl %r9d
	movq %rsi, %r9
	movl %edx, (%r9)
	movl $5, %eax
	addq $8, %rsp
	ret
_c0_print_maze:
	addq $-264, %rsp
	movq %rbp, 12(%rsp)
	movq %r15, 20(%rsp)
	movq %r14, 28(%rsp)
	movq %r13, 36(%rsp)
	movq %r12, 44(%rsp)
	movq %rbx, 52(%rsp)
	movq %rdi, %r14
	movq %rsi, %rbp
	movl %edx, 212(%rsp)
.print_maze_0:
	movq $1, %rdi
	movq $4, %rsi
	movq %rcx, 60(%rsp)
	movq %r8, 68(%rsp)
	movq %r9, 76(%rsp)
	callq calloc
	movq 60(%rsp), %rcx
	movq 68(%rsp), %r8
	movq 76(%rsp), %r9
	movq %rax, 68(%rsp)
	movq $1, %rdi
	movq $4, %rsi
	movq %rcx, 84(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, 76(%rsp)
	callq calloc
	movq 84(%rsp), %rcx
	movq 60(%rsp), %r8
	movq 76(%rsp), %r9
	movq %rax, 84(%rsp)
	movq 68(%rsp), %rdx
	movl $1, (%rdx)
	movl $10, %edi
	movq %rcx, 92(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, 76(%rsp)
	callq printchar
	movq 92(%rsp), %rcx
	movq 60(%rsp), %r8
	movq 76(%rsp), %r9
	movl $0, %edx
.print_maze_29:
.print_maze_1:
	movl $1, %esi
	movl %edx, %edi
	cmpl 212(%rsp), %edi
	setl %dil
	movzbl %dil, %edi
	cmpl %edi, %esi
	jnz .print_maze_3
.print_maze_2:
	movl $43, %edi
	movq %rdx, 100(%rsp)
	movq %rcx, 92(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, 76(%rsp)
	callq printchar
	movq 100(%rsp), %rdx
	movq 92(%rsp), %rcx
	movq 60(%rsp), %r8
	movq 76(%rsp), %r9
	movl $45, %edi
	movq %rdx, 100(%rsp)
	movq %rcx, 92(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, 76(%rsp)
	callq printchar
	movq 100(%rsp), %rdx
	movq 92(%rsp), %rcx
	movq 60(%rsp), %r8
	movq 76(%rsp), %r9
	addl $1, %edx
.print_maze_28:
	jmp .print_maze_1
.print_maze_3:
	movl $43, %edi
	movq %rcx, 92(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, 76(%rsp)
	callq printchar
	movq 92(%rsp), %rcx
	movq 60(%rsp), %r8
	movq 76(%rsp), %r9
	movl $10, %edi
	movq %rcx, 92(%rsp)
	movq %r8, 60(%rsp)
	movq %r9, 76(%rsp)
	callq printchar
	movq 92(%rsp), %rcx
	movq 60(%rsp), %r8
	movq 76(%rsp), %r9
	movl $0, %edx
.print_maze_31:
	movl %edx, 216(%rsp)
.print_maze_4:
	movl $1, %esi
	movl %ecx, %edi
	subl $1, %edi
	movl 216(%rsp), %edx
	cmpl %edi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .print_maze_18
.print_maze_5:
	movl $124, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 60(%rsp)
	callq printchar
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 60(%rsp), %r9
	movl $32, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 60(%rsp)
	callq printchar
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 60(%rsp), %r9
	movl $0, %edx
.print_maze_33:
	movl %edx, 220(%rsp)
.print_maze_6:
	movl $1, %edx
	movl 212(%rsp), %edi
	subl $1, %edi
	movl 220(%rsp), %esi
	cmpl %edi, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .print_maze_11
.print_maze_7:
	movl 220(%rsp), %edx
	imull %ecx, %edx
	addl 216(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %rbp, %rdx
	addq %rsi, %rdx
	movl (%rdx), %r10d
	movl %r10d, 224(%rsp)
	movl $1, %esi
	movl $0, %edx
	cmpl 224(%rsp), %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .print_maze_9
.print_maze_8:
	movq 68(%rsp), %rdi
	movq 84(%rsp), %rsi
	movl $124, %edx
	movq %rcx, 108(%rsp)
	movq %r8, 116(%rsp)
	movq %r9, %r15
	callq _c0_adler
	movq 108(%rsp), %rcx
	movq 116(%rsp), %r8
	movq %r15, %r9
	movl %eax, %edx
	movslq %edx, %rsi
	movl $124, %edi
	movq %rsi, 100(%rsp)
	movq %rdx, 124(%rsp)
	movq %rcx, 108(%rsp)
	movq %r8, 116(%rsp)
	movq %r9, %r15
	callq printchar
	movq 100(%rsp), %rsi
	movq 124(%rsp), %rdx
	movq 108(%rsp), %rcx
	movq 116(%rsp), %r8
	movq %r15, %r9
	movslq %eax, %rdi
.print_maze_35:
	movl %r13d, 228(%rsp)
	movq 132(%rsp), %r10
	movq %r10, 140(%rsp)
	movl 232(%rsp), %r10d
	movl %r10d, 236(%rsp)
	movq 148(%rsp), %r10
	movq %r10, 156(%rsp)
	movl %eax, 240(%rsp)
	movq %rdi, 164(%rsp)
.print_maze_10:
	movl $32, %edi
	movq %rsi, 124(%rsp)
	movq %rdx, 108(%rsp)
	movq %rcx, 116(%rsp)
	movq %r8, %r15
	movq %r9, %r13
	callq printchar
	movq 124(%rsp), %rsi
	movq 108(%rsp), %rdx
	movq 116(%rsp), %rcx
	movq %r15, %r8
	movq %r13, %r9
	movl %eax, %r13d
	movslq %r13d, %rax
	movl 220(%rsp), %edi
	addl $1, %edi
.print_maze_32:
	movl 228(%rsp), %r13d
	movq 140(%rsp), %r10
	movq %r10, 132(%rsp)
	movl 236(%rsp), %r10d
	movl %r10d, 232(%rsp)
	movq 156(%rsp), %r10
	movq %r10, 148(%rsp)
	movl 240(%rsp), %r10d
	movl %r10d, 244(%rsp)
	movq 164(%rsp), %r10
	movq %r10, 108(%rsp)
	movl %edx, 248(%rsp)
	movq %rsi, %r15
	movl %edi, 220(%rsp)
	jmp .print_maze_6
.print_maze_9:
	movq 68(%rsp), %rdi
	movq 84(%rsp), %rsi
	movl $32, %edx
	movq %rcx, 172(%rsp)
	movq %r8, 140(%rsp)
	movq %r9, 100(%rsp)
	callq _c0_adler
	movq 172(%rsp), %rcx
	movq 140(%rsp), %r8
	movq 100(%rsp), %r9
	movl %eax, %edx
	movslq %edx, %rsi
	movl $32, %edi
	movq %rsi, 180(%rsp)
	movq %rdx, 156(%rsp)
	movq %rcx, 172(%rsp)
	movq %r8, 140(%rsp)
	movq %r9, 100(%rsp)
	callq printchar
	movq 180(%rsp), %rsi
	movq 156(%rsp), %rdx
	movq 172(%rsp), %rcx
	movq 140(%rsp), %r8
	movq 100(%rsp), %r9
	movslq %eax, %rdi
.print_maze_34:
	movl %eax, 228(%rsp)
	movq %rdi, 140(%rsp)
	movl %edx, 236(%rsp)
	movq %rsi, 156(%rsp)
	movl 244(%rsp), %r10d
	movl %r10d, 240(%rsp)
	movq 108(%rsp), %r10
	movq %r10, 164(%rsp)
	movl 248(%rsp), %edx
	movq %r15, %rsi
	jmp .print_maze_10
.print_maze_11:
	movl $124, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 60(%rsp)
	callq printchar
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 60(%rsp), %r9
	movl $10, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 60(%rsp)
	callq printchar
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 60(%rsp), %r9
	movl $43, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 60(%rsp)
	callq printchar
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 60(%rsp), %r9
	movl $0, %edx
.print_maze_37:
	movl %edx, 220(%rsp)
.print_maze_12:
	movl $1, %esi
	movl 220(%rsp), %edx
	cmpl 212(%rsp), %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .print_maze_17
.print_maze_13:
	movl 216(%rsp), %edx
	imull 212(%rsp), %edx
	addl 220(%rsp), %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r14, %rdx
	addq %rsi, %rdx
	movl (%rdx), %r10d
	movl %r10d, 224(%rsp)
	movl $1, %esi
	movl $0, %edx
	cmpl 224(%rsp), %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .print_maze_15
.print_maze_14:
	movq 68(%rsp), %rdi
	movq 84(%rsp), %rsi
	movl $45, %edx
	movq %rcx, %rbx
	callq _c0_adler
	movq %rbx, %rcx
	movl %eax, %r9d
	movslq %r9d, %r8
	movl $45, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 188(%rsp)
	movq %r9, %rbx
	callq printchar
	movq 100(%rsp), %rcx
	movq 188(%rsp), %r8
	movq %rbx, %r9
	movslq %eax, %rdx
.print_maze_39:
	movl %r12d, 228(%rsp)
	movq 196(%rsp), %r10
	movq %r10, 140(%rsp)
	movl 252(%rsp), %r10d
	movl %r10d, 236(%rsp)
	movq 204(%rsp), %rsi
	movl %eax, 256(%rsp)
	movq %rdx, 180(%rsp)
	movl %r9d, 260(%rsp)
	movq %r8, %rdx
.print_maze_16:
	movl $43, %edi
	movq %rsi, 204(%rsp)
	movq %rdx, %r12
	movq %rcx, %rbx
	callq printchar
	movq 204(%rsp), %rsi
	movq %r12, %rdx
	movq %rbx, %rcx
	movslq %eax, %r9
	movl 220(%rsp), %edi
	addl $1, %edi
.print_maze_36:
	movl 228(%rsp), %r12d
	movq 140(%rsp), %r10
	movq %r10, 196(%rsp)
	movl 236(%rsp), %r10d
	movl %r10d, 252(%rsp)
	movq %rsi, 204(%rsp)
	movl 256(%rsp), %ebx
	movq 180(%rsp), %r10
	movq %r10, 188(%rsp)
	movl 260(%rsp), %r8d
	movq %rdx, %r9
	movl %edi, 220(%rsp)
	jmp .print_maze_12
.print_maze_15:
	movq 68(%rsp), %rdi
	movq 84(%rsp), %rsi
	movl $32, %edx
	movq %rcx, 172(%rsp)
	movq %r8, 140(%rsp)
	movq %r9, 100(%rsp)
	callq _c0_adler
	movq 172(%rsp), %rcx
	movq 140(%rsp), %r8
	movq 100(%rsp), %r9
	movl %eax, %edx
	movslq %edx, %rsi
	movl $32, %edi
	movq %rsi, 180(%rsp)
	movq %rdx, 156(%rsp)
	movq %rcx, 172(%rsp)
	movq %r8, 140(%rsp)
	movq %r9, 100(%rsp)
	callq printchar
	movq 180(%rsp), %rsi
	movq 156(%rsp), %rdx
	movq 172(%rsp), %rcx
	movq 140(%rsp), %r8
	movq 100(%rsp), %r9
	movslq %eax, %rdi
.print_maze_38:
	movl %eax, 228(%rsp)
	movq %rdi, 140(%rsp)
	movl %edx, 236(%rsp)
	movl %ebx, 256(%rsp)
	movq 188(%rsp), %r10
	movq %r10, 180(%rsp)
	movl %r8d, 260(%rsp)
	movq %r9, %rdx
	jmp .print_maze_16
.print_maze_17:
	movl $10, %edi
	movq %rcx, 100(%rsp)
	movq %r8, 92(%rsp)
	movq %r9, 60(%rsp)
	callq printchar
	movq 100(%rsp), %rcx
	movq 92(%rsp), %r8
	movq 60(%rsp), %r9
	movl 216(%rsp), %edx
	addl $1, %edx
.print_maze_30:
	movl %edx, 216(%rsp)
	jmp .print_maze_4
.print_maze_18:
	movl $124, %edi
	movq %rcx, %rbx
	callq printchar
	movq %rbx, %rcx
	movl $32, %edi
	movq %rcx, %rbx
	callq printchar
	movq %rbx, %rcx
	movl $0, %r9d
.print_maze_41:
.print_maze_19:
	movl $1, %edx
	movl 212(%rsp), %r8d
	subl $1, %r8d
	movl %r9d, %esi
	cmpl %r8d, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .print_maze_24
.print_maze_20:
	movl %r9d, %r8d
	imull %ecx, %r8d
	movl %ecx, %edx
	subl $1, %edx
	addl %edx, %r8d
	imull $4, %r8d
	movslq %r8d, %rdx
	movq %rbp, %r8
	addq %rdx, %r8
	movl (%r8), %esi
	movl $1, %edx
	movl $0, %r8d
	cmpl %esi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .print_maze_22
.print_maze_21:
	movq 68(%rsp), %rdi
	movq 84(%rsp), %rsi
	movl $124, %edx
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_adler
	movq %r12, %rcx
	movq %rbx, %r9
	movl %eax, %r8d
	movslq %r8d, %rdx
	movl $124, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movslq %eax, %rsi
.print_maze_43:
.print_maze_23:
	movl $32, %edi
	movq %rcx, %r12
	movq %r9, %rbx
	callq printchar
	movq %r12, %rcx
	movq %rbx, %r9
	addl $1, %r9d
.print_maze_40:
	jmp .print_maze_19
.print_maze_22:
	movq 68(%rsp), %rdi
	movq 84(%rsp), %rsi
	movl $32, %edx
	movq %rcx, %r12
	movq %r9, %rbx
	callq _c0_adler
	movq %r12, %rcx
	movq %rbx, %r9
	movl %eax, %r8d
	movslq %r8d, %rdx
	movl $32, %edi
	movq %rdx, %r14
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq printchar
	movq %r14, %rdx
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movslq %eax, %rsi
.print_maze_42:
	jmp .print_maze_23
.print_maze_24:
	movl $124, %edi
	callq printchar
	movl $10, %edi
	callq printchar
	movl $43, %edi
	callq printchar
	movl $0, %r9d
.print_maze_45:
.print_maze_25:
	movl $1, %r8d
	movl %r9d, %ecx
	cmpl 212(%rsp), %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r8d
	jnz .print_maze_27
.print_maze_26:
	movl $45, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	movl $43, %edi
	movq %r9, %rbx
	callq printchar
	movq %rbx, %r9
	addl $1, %r9d
.print_maze_44:
	jmp .print_maze_25
.print_maze_27:
	movl $10, %edi
	callq printchar
	movq 84(%rsp), %r9
	movl (%r9), %r9d
	movq 68(%rsp), %r8
	movl (%r8), %r8d
	sall $16, %r9d
	movl %r9d, %eax
	addl %r8d, %eax
	movq 12(%rsp), %rbp
	movq 20(%rsp), %r15
	movq 28(%rsp), %r14
	movq 36(%rsp), %r13
	movq 44(%rsp), %r12
	movq 52(%rsp), %rbx
	addq $264, %rsp
	ret
_c0_maze_maker:
	addq $-152, %rsp
	movq %rbp, 12(%rsp)
	movq %r15, 20(%rsp)
	movq %r14, 28(%rsp)
	movq %r13, 36(%rsp)
	movq %r12, 44(%rsp)
	movq %rbx, 52(%rsp)
	movl %edi, 116(%rsp)
	movl %esi, %r12d
.maze_maker_0:
	movl 116(%rsp), %ecx
	imull %r12d, %ecx
	movslq %ecx, %rdi
	movq $4, %rsi
	movq %r8, %r14
	movq %r9, %r13
	callq calloc
	movq %r14, %r8
	movq %r13, %r9
	movq %rax, 60(%rsp)
	movl 116(%rsp), %ecx
	imull %r12d, %ecx
	movslq %ecx, %rdi
	movq $4, %rsi
	movq %r8, %r14
	movq %r9, %r13
	callq calloc
	movq %r14, %r8
	movq %r13, %r9
	movq %rax, %r13
	movl %r12d, %ecx
	subl $1, %ecx
	movl 116(%rsp), %edx
	imull %ecx, %edx
	movl 116(%rsp), %ecx
	subl $1, %ecx
	movl %r12d, %esi
	imull %ecx, %esi
	movl %edx, %ecx
	addl %esi, %ecx
	movslq %ecx, %rdi
	movq $4, %rsi
	movq %r8, %r15
	movq %r9, %r14
	callq calloc
	movq %r15, %r8
	movq %r14, %r9
	movq %rax, 68(%rsp)
	movl %r12d, %edx
	subl $1, %edx
	movl 116(%rsp), %ecx
	imull %edx, %ecx
	movslq %ecx, %rdi
	movq $4, %rsi
	movq %r8, %r15
	movq %r9, %r14
	callq calloc
	movq %r15, %r8
	movq %r14, %r9
	movq %rax, 76(%rsp)
	movl 116(%rsp), %edx
	subl $1, %edx
	movl %r12d, %ecx
	imull %edx, %ecx
	movslq %ecx, %rdi
	movq $4, %rsi
	movq %r8, %r15
	movq %r9, %r14
	callq calloc
	movq %r15, %r8
	movq %r14, %r9
	movq %rax, %r14
	movl $0, %ecx
.maze_maker_29:
	movl %ecx, %edi
.maze_maker_1:
	movl $1, %edx
	movl 116(%rsp), %ecx
	imull %r12d, %ecx
	movl %edi, %esi
	cmpl %ecx, %esi
	setl %sil
	movzbl %sil, %esi
	cmpl %esi, %edx
	jnz .maze_maker_3
.maze_maker_2:
	movl %edi, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq 60(%rsp), %rcx
	addq %rdx, %rcx
	movl %edi, (%rcx)
	movl %edi, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r13, %rcx
	addq %rdx, %rcx
	movl $1, (%rcx)
	movl %edi, %ecx
	addl $1, %ecx
.maze_maker_28:
	movl %ecx, %edi
	jmp .maze_maker_1
.maze_maker_3:
	movq 68(%rsp), %rdx
	movl %r12d, %ecx
	subl $1, %ecx
	movl 116(%rsp), %edi
	imull %ecx, %edi
	movl 116(%rsp), %ecx
	subl $1, %ecx
	movl %r12d, %esi
	imull %ecx, %esi
	movl %edi, %ecx
	addl %esi, %ecx
	movq %rdx, %rdi
	movl %ecx, %esi
	movq %r8, 84(%rsp)
	movq %r9, %r15
	callq _c0_shuffle
	movq 84(%rsp), %r8
	movq %r15, %r9
	movl $0, %ecx
.maze_maker_31:
	movl %ecx, %edi
.maze_maker_4:
	movl $1, %esi
	movl %r12d, %ecx
	subl $1, %ecx
	movl 116(%rsp), %edx
	imull %ecx, %edx
	movl %edi, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .maze_maker_6
.maze_maker_5:
	movl %edi, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq 76(%rsp), %rcx
	addq %rdx, %rcx
	movl $1, (%rcx)
	movl %edi, %ecx
	addl $1, %ecx
.maze_maker_30:
	movl %ecx, %edi
	jmp .maze_maker_4
.maze_maker_6:
	movl $0, %ecx
.maze_maker_33:
	movl %ecx, %esi
.maze_maker_7:
	movl $1, %edx
	movl 116(%rsp), %ecx
	subl $1, %ecx
	movl %r12d, %edi
	imull %ecx, %edi
	movl %esi, %ecx
	cmpl %edi, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .maze_maker_9
.maze_maker_8:
	movl %esi, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r14, %rcx
	addq %rdx, %rcx
	movl $1, (%rcx)
	movl %esi, %ecx
	addl $1, %ecx
.maze_maker_32:
	movl %ecx, %esi
	jmp .maze_maker_7
.maze_maker_9:
	movl $0, %ecx
.maze_maker_35:
	movl %ecx, %r15d
.maze_maker_10:
	movq 60(%rsp), %rdi
	movl 116(%rsp), %esi
	imull %r12d, %esi
	movq %r8, 92(%rsp)
	movq %r9, 84(%rsp)
	callq _c0_one_comp
	movq 92(%rsp), %r8
	movq 84(%rsp), %r9
	movl $1, %edx
	movl $1, %ecx
	xorl %eax, %ecx
	cmpl %ecx, %edx
	jnz .maze_maker_27
.maze_maker_11:
	movl %r15d, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq 68(%rsp), %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	movl %ecx, 120(%rsp)
	movl $1, %esi
	movl %r12d, %ecx
	subl $1, %ecx
	movl 116(%rsp), %edx
	imull %ecx, %edx
	movl 120(%rsp), %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .maze_maker_18
.maze_maker_12:
	movl 120(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %eax, 124(%rsp)
	movl 124(%rsp), %ebp
	movl 120(%rsp), %eax
	cltd
	idivl 116(%rsp)
	movl %edx, %ebx
	movl %ebx, 128(%rsp)
	movl $1, %edx
	movl $0, %ecx
	movl 128(%rsp), %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .maze_maker_14
.maze_maker_13:
	movl 128(%rsp), %r9d
	addl 116(%rsp), %r9d
.maze_maker_37:
	movl %r9d, %r8d
.maze_maker_15:
	movq 60(%rsp), %rdi
	movq %r13, %rsi
	movl %ebp, %r9d
	imull 116(%rsp), %r9d
	movl %r9d, %edx
	addl %r8d, %edx
	movl %ebp, %r9d
	addl $1, %r9d
	imull 116(%rsp), %r9d
	movl %r9d, %ecx
	addl %r8d, %ecx
	movq %r8, 92(%rsp)
	callq _c0_join
	movq 92(%rsp), %r8
	movl %eax, %r9d
	movl $1, %ecx
	cmpl %r9d, %ecx
	jnz .maze_maker_17
.maze_maker_16:
	movl 120(%rsp), %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq 76(%rsp), %rcx
	addq %rdx, %rcx
	movl $0, (%rcx)
.maze_maker_24:
.maze_maker_41:
.maze_maker_26:
	movl %r15d, %ecx
	addl $1, %ecx
.maze_maker_34:
	movl %ecx, %r15d
	jmp .maze_maker_10
.maze_maker_17:
	jmp .maze_maker_24
.maze_maker_14:
.maze_maker_36:
	movl 128(%rsp), %r8d
	jmp .maze_maker_15
.maze_maker_18:
	movl %r12d, %ecx
	subl $1, %ecx
	movl 116(%rsp), %edx
	imull %ecx, %edx
	movl 120(%rsp), %eax
	subl %edx, %eax
	cltd
	idivl %r12d
	movl %edx, 132(%rsp)
	movl 132(%rsp), %r10d
	movl %r10d, 136(%rsp)
	movl %r12d, %ecx
	subl $1, %ecx
	movl 116(%rsp), %edx
	imull %ecx, %edx
	movl 120(%rsp), %eax
	subl %edx, %eax
	cltd
	idivl %r12d
	movl %eax, 140(%rsp)
	movl 140(%rsp), %r10d
	movl %r10d, 144(%rsp)
	movl $1, %edx
	movl $0, %esi
	movl 136(%rsp), %ecx
	cmpl %esi, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .maze_maker_20
.maze_maker_19:
	movl 136(%rsp), %ecx
	addl %r12d, %ecx
.maze_maker_39:
	movl %ecx, 148(%rsp)
.maze_maker_21:
	movq 60(%rsp), %rdi
	movq %r13, %rsi
	movl 148(%rsp), %ecx
	imull 116(%rsp), %ecx
	movl %ecx, %edx
	addl 144(%rsp), %edx
	movl 148(%rsp), %ecx
	imull 116(%rsp), %ecx
	addl 144(%rsp), %ecx
	addl $1, %ecx
	movq %r8, 100(%rsp)
	movq %r9, 108(%rsp)
	callq _c0_join
	movq 100(%rsp), %r8
	movq 108(%rsp), %r9
	movl $1, %edx
	cmpl %eax, %edx
	jnz .maze_maker_23
.maze_maker_22:
	movl %r12d, %esi
	subl $1, %esi
	movl 116(%rsp), %edx
	imull %esi, %edx
	movl 120(%rsp), %esi
	subl %edx, %esi
	movl %esi, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r14, %rdx
	addq %rsi, %rdx
	movl $0, (%rdx)
.maze_maker_25:
.maze_maker_40:
	jmp .maze_maker_26
.maze_maker_23:
	jmp .maze_maker_25
.maze_maker_20:
.maze_maker_38:
	movl 136(%rsp), %r10d
	movl %r10d, 148(%rsp)
	jmp .maze_maker_21
.maze_maker_27:
	movq 76(%rsp), %rdi
	movq %r14, %rsi
	movl 116(%rsp), %edx
	movl %r12d, %ecx
	callq _c0_print_maze
	movq 12(%rsp), %rbp
	movq 20(%rsp), %r15
	movq 28(%rsp), %r14
	movq 36(%rsp), %r13
	movq 44(%rsp), %r12
	movq 52(%rsp), %rbx
	addq $152, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $40, %r8d
	movl $490, %r9d
	movl %r8d, %edi
	movl %r9d, %esi
	callq _c0_maze_maker
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
