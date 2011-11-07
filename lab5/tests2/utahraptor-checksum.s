.file	"../tests2/utahraptor-checksum.l4"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movq $10, %rdi
	movq $4, %rsi
	callq calloc
	movq %rax, %r9
	movl $0, %r8d
	movl $0, %ecx
.main_8:
	movl %ecx, %esi
.main_1:
	movl $1, %edi
	movl $10, %edx
	movl %esi, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edi
	jnz .main_3
.main_2:
	movl %esi, %eax
	imull $53, %eax
	movl $13, %ecx
	cltd
	idivl %ecx
	movl %edx, %edi
	movl %esi, %ecx
	imull $4, %ecx
	movslq %ecx, %rdx
	movq %r9, %rcx
	addq %rdx, %rcx
	movl %edi, (%rcx)
	movl %esi, %ecx
	addl $1, %ecx
.main_7:
	movl %ecx, %esi
	jmp .main_1
.main_3:
	movl $0, %ecx
.main_10:
	movl %r8d, %edi
	movl %ecx, %esi
.main_4:
	movl $1, %edx
	movl $10, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_6
.main_5:
	movl %esi, %r8d
	imull $4, %r8d
	movslq %r8d, %rcx
	movq %r9, %r8
	addq %rcx, %r8
	movl (%r8), %ecx
	movl %edi, %r8d
	xorl %ecx, %r8d
	movl %esi, %ecx
	addl $1, %ecx
.main_9:
	movl %r8d, %edi
	movl %ecx, %esi
	jmp .main_4
.main_6:
	movl %edi, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
