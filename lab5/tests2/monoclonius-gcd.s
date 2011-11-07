.file	"../tests2/monoclonius-gcd.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $35, %r8d
	movl $168, %r9d
.main_13:
.main_1:
	movl $1, %ecx
	movl $1, %edx
	cmpl %edx, %ecx
	jnz .main_16
.main_2:
	movl $1, %esi
	movl $0, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_5
.main_3:
	jmp .main_14
.main_5:
.main_6:
	movl %r9d, %eax
	cltd
	idivl %r8d
	movl %edx, %eax
	movl %eax, %ecx
	movl $1, %edi
	movl $0, %esi
	movl %ecx, %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_9
.main_7:
	jmp .main_15
.main_9:
.main_10:
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl %edx, %r8d
.main_12:
	movl %ecx, %r9d
	jmp .main_1
.main_16:
	movl %r9d, %ecx
.main_11:
	movl %r8d, %eax
	orl %ecx, %eax
	addq $8, %rsp
	ret
.main_15:
	jmp .main_11
.main_14:
	movl %r9d, %ecx
	jmp .main_11
.ident	"15-411 L4 reference compiler"
