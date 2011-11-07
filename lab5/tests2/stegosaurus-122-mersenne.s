.file	"../tests2/stegosaurus-122-mersenne.l4"
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
	movl $0, %eax
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
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $1234567890, %edi
	callq _c0_init_rand
	movq %rax, %r9
	movl $0, %r8d
.main_5:
.main_1:
	movl $1, %esi
	movl $10000, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_3
.main_2:
	movq %r9, %rdi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_rand
	movq %r12, %r8
	movq %rbx, %r9
	addl $1, %r8d
.main_4:
	jmp .main_1
.main_3:
	movq %r9, %rdi
	callq _c0_rand
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
