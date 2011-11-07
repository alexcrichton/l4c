.file	"../tests2/diplodocus-bits.l2"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $0, %r9d
	subl $1, %r9d
	movl $1, %r8d
	movl $1, %edi
	movl $255, %ebx
	movl %r8d, %esi
	sall $2, %esi
	movl $1, %edx
	movl %edi, %ecx
	sall $2, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_7
.main_1:
	movl %edi, %eax
	sall $2, %eax
	movl %esi, %edi
	xorl %ebx, %edi
	movl $1, %edx
	movl %eax, %ecx
	xorl %ebx, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_6
.main_2:
	movl %eax, %r8d
	andl %ebx, %r8d
	movl %r8d, %esi
	orl %ebx, %esi
	movl $1, %edx
	movl %eax, %r8d
	andl %ebx, %r8d
	movl %r8d, %ecx
	orl %ebx, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_4
.main_3:
	movl $1337, %r9d
.main_12:
	movl %r9d, %r8d
.main_5:
.main_14:
	movl %r8d, %r9d
.main_8:
.main_10:
	movl %r9d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_4:
.main_11:
	movl %r9d, %r8d
	jmp .main_5
.main_6:
.main_13:
	jmp .main_8
.main_7:
	movl $0, %eax
	subl $111, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
