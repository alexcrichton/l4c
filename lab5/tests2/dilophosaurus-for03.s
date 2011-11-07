.file	"../tests2/dilophosaurus-for03.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $21, %r9d
	movl $0, %ecx
	movl $2, %r8d
.main_13:
.main_1:
	movl $1, %esi
	movl %r8d, %edx
	cmpl %r9d, %edx
	setl %dl
	movzbl %dl, %edx
	cmpl %edx, %esi
	jnz .main_15
.main_2:
	addl %r8d, %ecx
	movl $17, %esi
	movl %r8d, %eax
	cltd
	idivl %esi
	movl $1, %eax
	movl $0, %edi
	movl %edx, %esi
	cmpl %edi, %esi
	sete %sil
	movzbl %sil, %esi
	cmpl %esi, %eax
	jnz .main_5
.main_3:
	jmp .main_14
.main_5:
	movl $1, %esi
.main_6:
	movl $1, %edx
	andl $31, %r8d
	addl %esi, %r8d
	addl %edx, %r8d
	andl $255, %r8d
.main_12:
	jmp .main_1
.main_15:
	movl %ecx, %r9d
.main_7:
	movl $17, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl %edx, %r8d
	movl $1, %edx
	movl $0, %ecx
	cmpl %ecx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_9
.main_8:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_9:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_14:
	movl %ecx, %r9d
	jmp .main_7
.ident	"15-411 L4 reference compiler"
