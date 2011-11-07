.file	"../tests1/merlin-return06.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $10, %r9d
	movl $10, %eax
	movl $0, %ecx
	movl $0, %r8d
.main_22:
	movl %ecx, %edx
	movl %r8d, %edi
.main_1:
	movl $1, %ecx
	movl %edi, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_10
.main_2:
	movl $0, %r8d
.main_25:
	movl %r8d, %esi
.main_3:
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %eax, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_9
.main_4:
	movl $1, %ecx
	movl %edi, %r8d
	cmpl %esi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_5
.main_6:
	movl %edx, %ecx
	addl $1, %ecx
.main_8:
	movl %esi, %r8d
	addl $1, %r8d
.main_23:
	movl %r8d, %esi
	movl %ecx, %edx
	jmp .main_3
.main_5:
	movl %esi, %r8d
	addl $1, %r8d
	jmp .main_24
.main_9:
	movl %edx, %ecx
	addl $1, %ecx
	movl %edi, %r8d
	addl $1, %r8d
.main_21:
	movl %ecx, %edx
	movl %r8d, %edi
	jmp .main_1
.main_10:
.main_27:
	movl %edx, %ecx
	movl %r9d, %esi
.main_11:
	movl $1, %r8d
	movl $0, %r9d
	cmpl %esi, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_20
.main_12:
	movl $0, %r9d
.main_29:
	movl %r9d, %edx
.main_13:
	movl $1, %r8d
	movl %edx, %r9d
	cmpl %eax, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_19
.main_14:
	movl $1, %r8d
	movl $5, %r9d
	cmpl %edx, %r9d
	setle %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_17
.main_15:
	jmp .main_19
.main_17:
	movl %ecx, %r8d
	addl $1, %r8d
.main_18:
	movl %edx, %r9d
	addl $1, %r9d
.main_28:
	movl %r9d, %edx
	movl %r8d, %ecx
	jmp .main_13
.main_19:
	movl %ecx, %r8d
	addl $1, %r8d
	movl %esi, %r9d
	subl $1, %r9d
.main_26:
	movl %r8d, %ecx
	movl %r9d, %esi
	jmp .main_11
.main_20:
	movl %ecx, %eax
	addq $8, %rsp
	ret
	jmp .main_19
.main_24:
	movl %r8d, %esi
	jmp .main_3
.ident	"15-411 L4 reference compiler"
