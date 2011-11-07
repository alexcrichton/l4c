.file	"../tests2/ouranosaurus-nested_for.l2"
.globl _c0_main
_c0_main:
	addq $-24, %rsp
	movq %rbx, 16(%rsp)
.main_0:
	movl $1, %r8d
	movl $0, %ecx
.main_12:
	movl %r8d, %edi
	movl %ecx, %r8d
.main_1:
	movl $1, %esi
	movl $10, %ecx
	movl %r8d, %edx
	cmpl %ecx, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_10
.main_2:
	movl $0, %edx
.main_14:
	movl %edi, %ecx
	movl %edx, %esi
.main_3:
	movl $1, %eax
	movl $10, %edi
	movl %esi, %edx
	cmpl %edi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %eax
	jnz .main_16
.main_4:
	movl $7, %edi
	movl %ecx, %eax
	cltd
	idivl %edi
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
	jmp .main_15
.main_7:
.main_8:
	addl $1, %ecx
	movl %esi, %edx
	addl $1, %edx
.main_13:
	movl %ebx, %r9d
	movl %edx, %esi
	jmp .main_3
.main_16:
.main_9:
	addl $1, %ecx
	addl $1, %r8d
.main_11:
	movl %ecx, %edi
	jmp .main_1
.main_10:
	movl %edi, %eax
	movq 16(%rsp), %rbx
	addq $24, %rsp
	ret
.main_15:
	jmp .main_9
.ident	"15-411 L4 reference compiler"
