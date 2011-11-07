.file	"../tests2/styracosaurus-mersenne-twister.l4"
.globl _c0_main
_c0_init:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
	movl %edi, %r9d
.init_0:
	movq $624, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movl $0, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %rax, %r8
	addq %rcx, %r8
	movl %r9d, (%r8)
	movl $1, %r9d
.init_5:
	movl %r9d, %edx
.init_1:
	movl $1, %ecx
	movl $624, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .init_3
.init_2:
	movl %edx, %r9d
	subl $1, %r9d
	imull $4, %r9d
	movslq %r9d, %r8
	movq %rax, %r9
	addq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %r8d
	movl %edx, %r9d
	imull $4, %r9d
	movslq %r9d, %r9
	movq %rax, %rcx
	addq %r9, %rcx
	movl %r8d, %r9d
	sarl $30, %r9d
	xorl %r9d, %r8d
	movl $1812433253, %r9d
	imull %r8d, %r9d
	addl %edx, %r9d
	movl %r9d, (%rcx)
	andl $-1, (%rcx)
	movl %edx, %r9d
	addl $1, %r9d
.init_4:
	movl %r9d, %edx
	jmp .init_1
.init_3:
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
_c0_generateNumbers:
	addq $-8, %rsp
	movq %rdi, %r9
.generateNumbers_0:
	movl $0, %r8d
.generateNumbers_8:
	movl %r8d, %esi
.generateNumbers_1:
	movl $1, %edx
	movl $624, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .generateNumbers_6
.generateNumbers_2:
	movl %esi, %r8d
	imull $4, %r8d
	movslq %r8d, %r8
	movq %r9, %rcx
	addq %r8, %rcx
	movl (%rcx), %r8d
	movl $1, %ecx
	sall $31, %ecx
	andl %ecx, %r8d
	movl %esi, %eax
	addl $1, %eax
	movl $624, %ecx
	cltd
	idivl %ecx
	movl %edx, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %ecx
	andl $2147483647, %ecx
	addl %ecx, %r8d
	movl %esi, %eax
	addl $397, %eax
	movl $624, %ecx
	cltd
	idivl %ecx
	movl %edx, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl (%rcx), %edi
	movl %esi, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	movq %r9, %rdx
	addq %rcx, %rdx
	movl %r8d, %ecx
	sarl $1, %ecx
	movl %edi, (%rdx)
	xorl %ecx, (%rdx)
	movl $2, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl %edx, %r8d
	movl $1, %edx
	movl $1, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .generateNumbers_4
.generateNumbers_3:
	movl %esi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movl %esi, %r8d
	imull $4, %r8d
	movslq %r8d, %rdx
	movq %r9, %r8
	addq %rdx, %r8
	movl $1, %edx
	sall $31, %edx
	movl $419999967, %edi
	addl %edx, %edi
	movl %ecx, (%r8)
	xorl %edi, (%r8)
.generateNumbers_10:
.generateNumbers_5:
	movl %esi, %r8d
	addl $1, %r8d
.generateNumbers_7:
	movl %r8d, %esi
	jmp .generateNumbers_1
.generateNumbers_4:
.generateNumbers_9:
	jmp .generateNumbers_5
.generateNumbers_6:
	movl $0, %eax
	addq $8, %rsp
	ret
_c0_nextInt:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
	movq %rdi, %r9
	movq %rsi, %r8
.nextInt_0:
	movq %r8, %rcx
	movl (%rcx), %ecx
	movl $1, %esi
	movl $0, %edx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .nextInt_2
.nextInt_1:
	movq %r9, %rdi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_generateNumbers
	movq %r12, %r8
	movq %rbx, %r9
.nextInt_3:
	movq %r8, %rcx
	movl (%rcx), %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	addq %rcx, %r9
	movl (%r9), %r9d
	movl %r9d, %ecx
	movl %ecx, %r9d
	sarl $11, %r9d
	movl %ecx, %esi
	xorl %r9d, %esi
	movl %esi, %edx
	sall $7, %edx
	movl $1, %r9d
	sall $31, %r9d
	movl $489444992, %ecx
	addl %r9d, %ecx
	movl %edx, %r9d
	andl %ecx, %r9d
	xorl %r9d, %esi
	movl %esi, %edx
	sall $15, %edx
	movl $1, %r9d
	sall $31, %r9d
	movl $1875247104, %ecx
	addl %r9d, %ecx
	movl %edx, %r9d
	andl %ecx, %r9d
	movl %esi, %ecx
	xorl %r9d, %ecx
	movl %ecx, %r9d
	sarl $18, %r9d
	xorl %r9d, %ecx
	movq %r8, %r9
	movl (%r9), %r9d
	movl %r9d, %eax
	addl $1, %eax
	movl $624, %r9d
	cltd
	idivl %r9d
	movl %edx, (%r8)
	movl %ecx, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.nextInt_2:
	jmp .nextInt_3
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $1234, %r9d
	movl %r9d, %edi
	callq _c0_init
	movq %rax, %r9
	movq $1, %rdi
	movq $4, %rsi
	movq %r9, %rbx
	callq calloc
	movq %rbx, %r9
	movq %rax, %r8
	movl $0, (%r8)
	movq %r9, %rdi
	movq %rax, %rsi
	callq _c0_nextInt
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
