.file	"../tests1/hobby-dangling.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $4, %r9d
	movl $8, %edi
	movl $0, %esi
	movl $1, %edx
	movl $3, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_5
.main_1:
	movl $1, %ecx
	movl $4, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_3
.main_2:
	movl %esi, %r9d
	addl $1, %r9d
.main_14:
.main_4:
.main_16:
	movl %r9d, %edx
.main_6:
	movl $1, %r8d
	movl $6, %r9d
	cmpl %edi, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_11
.main_7:
	movl $1, %ecx
	movl $8, %r8d
	movl %edi, %r9d
	cmpl %r8d, %r9d
	setle %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_9
.main_8:
	movl %edx, %r9d
	addl $4, %r9d
.main_18:
.main_10:
.main_20:
.main_12:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_9:
	movl %edx, %r9d
	addl $8, %r9d
.main_17:
	jmp .main_10
.main_11:
.main_19:
	movl %edx, %r9d
	jmp .main_12
.main_3:
	movl %esi, %r9d
	addl $2, %r9d
.main_13:
	jmp .main_4
.main_5:
.main_15:
	movl %esi, %edx
	jmp .main_6
.ident	"15-411 L4 reference compiler"
