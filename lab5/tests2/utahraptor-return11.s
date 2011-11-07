.file	"../tests2/utahraptor-return11.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %edx
	movl $1, %esi
	movl $1, %ecx
	movl $0, %r8d
	cmpl %edx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_16
.main_1:
.main_19:
.main_2:
	movl $1, %ecx
	movl $10, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_23
.main_3:
	movl %edx, %edi
	addl $1, %edi
	movl $1, %ecx
	movl $5, %r8d
	movl %edi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_13
.main_4:
	movl $1, %ecx
	movl $6, %r8d
	movl %edi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_11
.main_5:
	movl $0, %edx
.main_6:
	movl $1, %ecx
	movl $10, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_21
.main_7:
	movl %edx, %eax
	addl $1, %eax
	jmp .main_20
.main_21:
	movl %edx, %r9d
.main_9:
	jmp .main_22
.main_11:
.main_12:
.main_14:
.main_18:
	movl %edi, %edx
	jmp .main_2
.main_13:
	jmp .main_14
.main_23:
	movl %esi, %r8d
	movl %edx, %r9d
.main_15:
.main_25:
	movl %r9d, %r8d
.main_17:
	movl %r8d, %eax
	addq $8, %rsp
	ret
.main_16:
.main_24:
	movl %edx, %r8d
	jmp .main_17
.main_22:
	movl %r9d, %r8d
	movl %edi, %r9d
	jmp .main_15
.main_20:
	movl %eax, %r9d
	jmp .main_9
.ident	"15-411 L4 reference compiler"
