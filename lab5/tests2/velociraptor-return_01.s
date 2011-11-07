.file	"../tests2/velociraptor-return_01.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r8d
	movl $7, %r9d
	movl $0, %esi
	movl %r8d, %edx
	movl %r9d, %ecx
	sall %cl, %edx
.main_11:
	movl %r9d, %r8d
.main_1:
	movl $1, %r9d
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %r9d
	jnz .main_3
.main_2:
	movl %r8d, %r9d
	imull $2, %r9d
.main_10:
	movl %r9d, %r8d
	jmp .main_1
.main_3:
	movl %r8d, %ecx
	sarl %cl, %edx
.main_13:
	movl %esi, %r9d
	movl %edx, %esi
.main_4:
	movl $1, %edi
	movl $3, %edx
	movl %r9d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %edi
	jnz .main_9
.main_5:
	movl $2, %ecx
	movl %r9d, %eax
	cltd
	idivl %ecx
	movl $1, %ecx
	movl $0, %edi
	cmpl %edi, %edx
	sete %dl
	movzbl %dl, %edx
	cmpl %edx, %ecx
	jnz .main_7
.main_6:
	subl %esi, %r8d
.main_15:
	movl %r8d, %ecx
	movl %esi, %edx
.main_8:
	addl $1, %r9d
.main_12:
	movl %ecx, %r8d
	movl %edx, %esi
	jmp .main_4
.main_7:
	movl %esi, %edx
	subl %r8d, %edx
.main_14:
	movl %r8d, %ecx
	jmp .main_8
.main_9:
	movl %r8d, %eax
	subl %esi, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
