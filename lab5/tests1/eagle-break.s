.file	"../tests1/eagle-break.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %edx
.main_1:
	movl $1, %ecx
	movl $1, %r8d
	cmpl %r8d, %ecx
	jnz .main_30
.main_2:
.main_3:
	movl $1, %ecx
	movl $1, %r8d
	cmpl %r8d, %ecx
	jnz .main_28
.main_4:
.main_5:
	movl $1, %r8d
	movl $1, %r9d
	cmpl %r9d, %r8d
	jnz .main_26
.main_6:
.main_7:
	movl $1, %r8d
	movl $1, %r9d
	cmpl %r9d, %r8d
	jnz .main_24
.main_8:
.main_9:
	movl $1, %r8d
	movl $1, %r9d
	cmpl %r9d, %r8d
	jnz .main_22
.main_10:
	movl $2, %esi
	jmp .main_21
.main_22:
	movl %edx, %r9d
.main_12:
	movl %r9d, %edi
	imull $3, %edi
	jmp .main_23
.main_24:
	movl %edx, %r9d
.main_14:
	movl %r9d, %eax
	imull $5, %eax
	jmp .main_25
.main_26:
	movl %edx, %r9d
.main_16:
	imull $7, %r9d
	jmp .main_27
.main_28:
	movl %edx, %r8d
.main_18:
	imull $11, %r8d
	jmp .main_29
.main_30:
	movl %edx, %r8d
.main_20:
	movl %r8d, %eax
	addq $8, %rsp
	ret
.main_29:
	jmp .main_20
.main_27:
	movl %r9d, %r8d
	jmp .main_18
.main_25:
	movl %eax, %r9d
	jmp .main_16
.main_23:
	movl %edi, %r9d
	jmp .main_14
.main_21:
	movl %esi, %r9d
	jmp .main_12
.ident	"15-411 L4 reference compiler"
