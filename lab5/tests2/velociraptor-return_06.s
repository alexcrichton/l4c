.file	"../tests2/velociraptor-return_06.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %ecx
	movl $1, %r8d
.main_14:
	movl %ecx, %edi
.main_1:
	movl $1, %esi
	movl $33, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_12
.main_2:
.main_16:
.main_3:
	movl $1, %esi
	movl $10, %edx
	movl %edi, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_11
.main_4:
	movl $0, %ecx
.main_18:
	movl %r9d, %esi
	movl %ecx, %eax
.main_5:
	movl $1, %edx
	movl $2, %ecx
	movl %eax, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %edx
	jnz .main_10
.main_6:
	movl $5, %r9d
.main_20:
	movl %r9d, %esi
	movl %edi, %edx
.main_7:
	movl $1, %ecx
	movl $0, %r9d
	cmpl %esi, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_9
.main_8:
	movl %edx, %ecx
	imull %esi, %ecx
	movl %esi, %r9d
	subl $1, %r9d
.main_19:
	movl %r9d, %esi
	movl %ecx, %edx
	jmp .main_7
.main_9:
	movl %eax, %r9d
	addl $1, %r9d
.main_17:
	movl %r9d, %eax
	movl %edx, %edi
	jmp .main_5
.main_10:
.main_15:
	movl %esi, %r9d
	jmp .main_3
.main_11:
	movl %edi, %eax
	cltd
	idivl %r8d
	movl %eax, %ecx
	imull $2, %r8d
.main_13:
	movl %ecx, %edi
	jmp .main_1
.main_12:
	movl %r8d, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
