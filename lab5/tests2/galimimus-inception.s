.file	"../tests2/galimimus-inception.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r8d
	movl $0, %r9d
.main_15:
	movl %r8d, %edx
.main_1:
	movl $1, %ecx
	movl $10, %esi
	movl %r9d, %r8d
	cmpl %esi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_13
.main_2:
	movl %r9d, %ecx
.main_18:
	movl %edx, %r8d
.main_3:
	movl $1, %edi
	movl $10, %esi
	movl %ecx, %edx
	cmpl %esi, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_12
.main_4:
	movl $2, %esi
	movl %r9d, %eax
	cltd
	idivl %esi
	movl %edx, %eax
	movl $1, %edi
	movl $0, %esi
	movl %eax, %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_6
.main_5:
	movl %ecx, %edx
	addl $1, %edx
	jmp .main_17
.main_6:
	movl $0, %edx
.main_20:
	movl %edx, %edi
	movl %r8d, %esi
.main_7:
	movl $1, %edx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_10
.main_8:
	movl $1, %edx
	xorl %esi, %edx
	movl %edi, %r8d
	addl $1, %r8d
.main_19:
	movl %r8d, %edi
	movl %edx, %esi
	jmp .main_7
.main_10:
.main_11:
	addl $1, %ecx
.main_16:
	movl %esi, %r8d
	jmp .main_3
.main_12:
	addl $1, %r9d
.main_14:
	movl %r8d, %edx
	jmp .main_1
.main_13:
	cmpl $0, %edx
	jnz .ternary_true1
	movl $0, %r9d
	jmp .ternary_end2
.ternary_true1:
	movl $1, %r9d
.ternary_end2:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_17:
	movl %edx, %ecx
	jmp .main_3
.ident	"15-411 L4 reference compiler"
