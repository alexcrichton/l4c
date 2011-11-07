.file	"../tests1/sparrowhawk-return10.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $0, %r8d
.main_15:
	movl %r8d, %eax
	movl %r9d, %edx
.main_1:
	movl $1, %ecx
	movl $10, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_9
.main_2:
	movl $0, %r9d
.main_17:
	movl %r9d, %edi
.main_3:
	movl $1, %ecx
	movl $10, %r8d
	movl %edi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_8
.main_4:
	movl $0, %r9d
.main_19:
	movl %r9d, %esi
.main_5:
	movl $1, %ecx
	movl $10, %r8d
	movl %esi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_7
.main_6:
	movl %esi, %r8d
	addl $1, %r8d
	movl %edx, %r9d
	addl $1, %r9d
.main_18:
	movl %r8d, %esi
	movl %r9d, %edx
	jmp .main_5
.main_7:
	movl %edi, %r9d
	addl $1, %r9d
.main_16:
	movl %r9d, %edi
	jmp .main_3
.main_8:
	movl %eax, %r9d
	addl $1, %r9d
.main_14:
	movl %r9d, %eax
	jmp .main_1
.main_9:
	movl $1, %ecx
	movl $0, %r9d
	movl $0, %r8d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_11
.main_10:
	movl %edx, %eax
	addq $8, %rsp
	ret
.main_11:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
