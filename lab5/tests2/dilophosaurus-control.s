.file	"../tests2/dilophosaurus-control.l3"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $100, %r8d
	movl $0, %edx
	movl $0, %ecx
.main_14:
	movl %edx, %esi
	movl %ecx, %edi
.main_1:
	movl $1, %edx
	movl %edi, %ecx
	cmpl %r8d, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edx
	jnz .main_16
.main_2:
	movl $2, %ecx
	movl %edi, %eax
	cltd
	idivl %ecx
	movl %edx, %ebx
	movl $1, %eax
	movl $0, %edx
	movl %ebx, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %eax
	jnz .main_5
.main_3:
	movl %edi, %r9d
	addl $1, %r9d
	jmp .main_13
.main_5:
.main_6:
	movl $1, %eax
	movl %edi, %edx
	imull $2, %edx
	movl $42, %ecx
	cmpl %ecx, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_9
.main_7:
	jmp .main_15
.main_9:
.main_10:
	movl %esi, %edx
	addl $5, %edx
	movl %edi, %ecx
	addl $1, %ecx
.main_12:
	movl %edx, %esi
	movl %ecx, %edi
	jmp .main_1
.main_16:
.main_11:
	movl %esi, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_15:
	jmp .main_11
.main_13:
	movl %r9d, %edi
	jmp .main_1
.ident	"15-411 L4 reference compiler"
