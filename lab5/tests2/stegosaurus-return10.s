.file	"../tests2/stegosaurus-return10.l2"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %r12, 8(%rsp)
	movq %rbx, 16(%rsp)
.main_0:
	movl $22000, %r8d
	movl $0, %ecx
	movl $0, %edx
	movl $1, %edi
.main_11:
	movl %edx, %esi
	movl %ecx, %ebx
	movl %edi, %ecx
.main_1:
	movl $1, %edi
	movl %ecx, %edx
	cmpl %r8d, %edx
	setle %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_9
.main_2:
	movl $1, %eax
	movl $0, %edx
	movl %ebx, %edi
	cmpl %edx, %edi
	sete %dil
	movzbl %dil, %edi
	cmpl %edi, %eax
	jnz .main_3
.main_6:
	movl $1, %edx
.main_15:
	movl %edx, %eax
.main_8:
	cltd
	idivl %ecx
	movl %edx, %eax
	movl %eax, %edi
	movl %esi, %edx
	addl %eax, %edx
	addl $1, %ecx
.main_10:
	movl %edx, %esi
	movl %edi, %ebx
	jmp .main_1
.main_3:
	movl $1, %edi
	movl $0, %edx
.main_13:
	movl %edi, %r12d
	movl %edx, %edi
.main_4:
	movl $1, %eax
	movl %edi, %edx
	cmpl %ebx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_7
.main_5:
	movl %r12d, %eax
	imull $2, %eax
	cltd
	idivl %ecx
	movl %edx, %r9d
	movl %r9d, %edx
	addl $1, %edi
.main_12:
	movl %edx, %r12d
	jmp .main_4
.main_7:
	movl %r12d, %edx
.main_14:
	movl %edx, %eax
	jmp .main_8
.main_9:
	movl %esi, %eax
	movq 8(%rsp), %r12
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.ident	"15-411 L4 reference compiler"
