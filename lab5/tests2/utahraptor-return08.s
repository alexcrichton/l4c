.file	"../tests2/utahraptor-return08.l2"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $2, %ecx
	movl $1, %r8d
.main_15:
.main_1:
	movl $1, %edi
	movl $100, %esi
	movl %ecx, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_13
.main_2:
	movl $2, %edx
.main_17:
	movl %edx, %esi
.main_3:
	movl $1, %edi
	movl %esi, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_19
.main_4:
	movl %ecx, %eax
	cltd
	idivl %esi
	movl %edx, %ebx
	movl $1, %eax
	movl $0, %edi
	movl %ebx, %edx
	cmpl %edi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_7
.main_5:
	jmp .main_18
.main_7:
.main_8:
	movl %esi, %edx
	addl $1, %edx
.main_16:
	movl %ebx, %r9d
	movl %edx, %esi
	jmp .main_3
.main_19:
.main_9:
	movl $1, %edi
	movl %esi, %edx
	cmpl %ecx, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_11
.main_10:
	movl %ecx, %r8d
.main_21:
	movl %r8d, %edx
.main_12:
	addl $1, %ecx
.main_14:
	movl %edx, %r8d
	jmp .main_1
.main_11:
.main_20:
	movl %r8d, %edx
	jmp .main_12
.main_13:
	movl %r8d, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_18:
	jmp .main_9
.ident	"15-411 L4 reference compiler"
