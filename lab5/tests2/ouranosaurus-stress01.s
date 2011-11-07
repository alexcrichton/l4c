.file	"../tests2/ouranosaurus-stress01.l2"
.globl _c0_main
_c0_main:
	addq $-40, %rsp
	movq %r13, 16(%rsp)
	movq %r12, 24(%rsp)
	movq %rbx, 32(%rsp)
.main_0:
	movl $40, %r13d
	movl $0, %ecx
	movl $0, %r8d
.main_17:
	movl %r8d, %r12d
	movl %ecx, %edx
.main_1:
	movl $1, %ecx
	movl %r12d, %r8d
	cmpl %r13d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_15
.main_2:
	movl $0, %r8d
.main_19:
	movl %r8d, %ebx
	movl %edx, %esi
.main_3:
	movl $1, %ecx
	movl %ebx, %r8d
	cmpl %r13d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_14
.main_4:
	movl $0, %r8d
.main_21:
	movl %r9d, %edx
	movl %r8d, %edi
	movl %esi, %ecx
.main_5:
	movl $1, %r8d
	movl %edi, %r9d
	cmpl %r13d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_13
.main_6:
	movl $0, %r9d
.main_23:
	movl %eax, %edx
	movl %r9d, %esi
.main_7:
	movl $1, %r8d
	movl %esi, %r9d
	cmpl %r13d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_12
.main_8:
	movl $0, %r9d
.main_25:
	movl %r9d, %edx
.main_9:
	movl $1, %r8d
	movl %edx, %r9d
	cmpl %r13d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_11
.main_10:
	movl %ecx, %r8d
	addl $1, %r8d
	movl %edx, %r9d
	addl $1, %r9d
.main_24:
	movl %r9d, %edx
	movl %r8d, %ecx
	jmp .main_9
.main_11:
	movl %esi, %r9d
	addl $1, %r9d
.main_22:
	movl %r9d, %esi
	jmp .main_7
.main_12:
	movl %edi, %r9d
	addl $1, %r9d
.main_20:
	movl %edx, %eax
	movl %esi, %edx
	movl %r9d, %edi
	jmp .main_5
.main_13:
	movl %ebx, %r8d
	addl $1, %r8d
.main_18:
	movl %edx, %r9d
	movl %r8d, %ebx
	movl %ecx, %esi
	jmp .main_3
.main_14:
	movl %r12d, %r8d
	addl $1, %r8d
.main_16:
	movl %r8d, %r12d
	movl %esi, %edx
	jmp .main_1
.main_15:
	movl %edx, %eax
	movq 16(%rsp), %r13
	movq 24(%rsp), %r12
	movq 32(%rsp), %rbx
	addq $40, %rsp
	ret
.ident	"15-411 L4 reference compiler"
