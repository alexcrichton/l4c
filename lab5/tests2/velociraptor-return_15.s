.file	"../tests2/velociraptor-return_15.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r8d
.main_13:
	movl %r8d, %ecx
.main_1:
	movl $1, %edx
	movl $10, %esi
	movl %ecx, %r8d
	cmpl %esi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_16
.main_2:
	movl $2, %r8d
	movl %ecx, %eax
	cltd
	idivl %r8d
	movl %edx, %r8d
	movl $1, %edi
	movl $0, %esi
	movl %r8d, %edx
	cmpl %esi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %edi
	jnz .main_4
.main_3:
	movl %ecx, %r9d
	addl $1, %r9d
	jmp .main_14
.main_4:
	movl $2, %esi
	movl %ecx, %eax
	cltd
	idivl %esi
	movl $1, %ecx
	movl $0, %esi
	cmpl %esi, %edx
	setne %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .main_6
.main_5:
	jmp .main_15
.main_6:
	movl $100, %eax
	addq $8, %rsp
	ret
.main_16:
.main_12:
	movl $4, %eax
	addq $8, %rsp
	ret
.main_15:
	jmp .main_12
.main_14:
	movl %r9d, %ecx
	jmp .main_1
.ident	"15-411 L4 reference compiler"
