.file	"../tests2/vulcanodon-return04.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $0, %r8d
.main_14:
	movl %r8d, %eax
	movl %r9d, %edx
.main_1:
	movl $1, %ecx
	movl $11, %r8d
	movl %eax, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_12
.main_2:
	movl $1, %r9d
.main_16:
	movl %r9d, %esi
.main_3:
	movl $1, %ecx
	movl $50, %r8d
	movl %esi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_11
.main_4:
	movl %esi, %r8d
	addl $1, %r8d
	movl $1, %r9d
.main_18:
	movl %r9d, %edi
	movl %r8d, %esi
.main_5:
	movl $1, %ecx
	movl $100, %r8d
	movl %edi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_10
.main_6:
	movl $1, %ecx
	movl $8, %r8d
	movl %edi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_8
.main_7:
	movl %edx, %r8d
	addl $3, %r8d
	movl %esi, %r9d
	addl $10, %r9d
.main_20:
	movl %r9d, %ecx
.main_9:
	movl %edi, %r9d
	imull $2, %r9d
.main_17:
	movl %r9d, %edi
	movl %ecx, %esi
	movl %r8d, %edx
	jmp .main_5
.main_8:
.main_19:
	movl %esi, %ecx
	movl %edx, %r8d
	jmp .main_9
.main_10:
.main_15:
	jmp .main_3
.main_11:
	movl $18, %r9d
	subl %eax, %r9d
	movl %edx, %r8d
	subl %r9d, %r8d
	movl %eax, %r9d
	addl $1, %r9d
.main_13:
	movl %r9d, %eax
	movl %r8d, %edx
	jmp .main_1
.main_12:
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
