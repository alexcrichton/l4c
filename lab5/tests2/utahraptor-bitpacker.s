.file	"../tests2/utahraptor-bitpacker.l4"
.globl _c0_main
_c0_bitstoint:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
.bitstoint_0:
	movl $0, %r8d
	movl %esi, %ecx
	subl $1, %ecx
.bitstoint_5:
.bitstoint_1:
	movl $1, %esi
	movl $0, %edx
	cmpl %ecx, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .bitstoint_3
.bitstoint_2:
	sall $1, %r8d
	movl %ecx, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movl (%rdx), %edx
	movl %edx, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq booltoint
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl $1, %edx
	andl %eax, %edx
	addl %edx, %r8d
	subl $1, %ecx
.bitstoint_4:
	jmp .bitstoint_1
.bitstoint_3:
	movl %r8d, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_inttobits:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
	movq %rdi, %r9
.inttobits_0:
	movl $0, %r8d
.inttobits_8:
	movl %esi, %ecx
.inttobits_1:
	movl $1, %edi
	movl $0, %esi
	movl %ecx, %edx
	cmpl %esi, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .inttobits_3
.inttobits_2:
	movl %ecx, %edi
	andl $1, %edi
	movq %rcx, %r13
	movq %r8, %r12
	movq %r9, %rbx
	callq inttobool
	movq %r13, %rcx
	movq %r12, %r8
	movq %rbx, %r9
	movl %r8d, %edx
	imull $4, %edx
	movslq %edx, %rsi
	movq %r9, %rdx
	addq %rsi, %rdx
	movl %eax, (%rdx)
	sarl $1, %ecx
	addl $1, %r8d
.inttobits_7:
	jmp .inttobits_1
.inttobits_3:
.inttobits_10:
	movl %r8d, %esi
.inttobits_4:
	movl $1, %edx
	movl $32, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .inttobits_6
.inttobits_5:
	movl %esi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl $0, (%r8)
	movl %esi, %r8d
	addl $1, %r8d
.inttobits_9:
	movl %r8d, %esi
	jmp .inttobits_4
.inttobits_6:
	movl $0, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movq $10, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r8
	movq $32, %rdi
	movq $4, %rsi
	movq %r8, %rbx
	callq calloc
	movq %rbx, %r8
	movq %rax, %r9
	movl $0, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $0, (%rcx)
	movl $1, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $1, (%rcx)
	movl $2, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	movq %r8, %rdx
	addq %rcx, %rdx
	movl $0, (%rdx)
	movl $3, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $0, (%rcx)
	movl $4, %ecx
	imull $4, %ecx
	movslq %ecx, %rcx
	movq %r8, %rdx
	addq %rcx, %rdx
	movl $1, (%rdx)
	movl $5, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $0, (%rcx)
	movl $6, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $1, (%rcx)
	movl $7, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $1, (%rcx)
	movl $8, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $1, (%rcx)
	movl $9, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r8, %rcx
	addq %rdx, %rcx
	movl $1, (%rcx)
	movq %r8, %rdi
	movl $10, %esi
	movq %r9, %rbx
	callq _c0_bitstoint
	movq %rbx, %r9
	movl %eax, %r8d
	movl $1, %esi
	movl $978, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_2
.main_1:
	movl $1, %eax
	movl $0, %ecx
	cltd
	idivl %ecx
.main_3:
	movq %r9, %rdi
	movl %r8d, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_inttobits
	movq %r12, %r8
	movq %rbx, %r9
	movq %r9, %rdi
	movl $32, %esi
	movq %r8, %r12
	movq %r9, %rbx
	callq _c0_bitstoint
	movq %r12, %r8
	movq %rbx, %r9
	movl %eax, %edx
	movl $1, %ecx
	movl $978, %esi
	cmpl %esi, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .main_5
.main_4:
	movl $1, %eax
	movl $0, %r9d
	cltd
	idivl %r9d
.main_6:
	movl $0, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_5:
	jmp .main_6
.main_2:
	jmp .main_3
.ident	"15-411 L4 reference compiler"
