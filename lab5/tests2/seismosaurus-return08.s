.file	"../tests2/seismosaurus-return08.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r8d
	movl $0, %r9d
.main_14:
.main_1:
	movl $1, %esi
	movl $50, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_16
.main_2:
	addl $1, %r8d
	movl $2, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl %edx, %edi
	movl $1, %esi
	movl $0, %edx
	movl %edi, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_5
.main_3:
	jmp .main_13
.main_5:
.main_6:
	movl $1, %esi
	movl $47, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_9
.main_7:
	jmp .main_15
.main_9:
.main_10:
	addl %r8d, %r9d
.main_12:
	jmp .main_1
.main_16:
	movl %r8d, %ecx
.main_11:
	movl %ecx, %eax
	addq $8, %rsp
	ret
.main_15:
	movl %r8d, %ecx
	jmp .main_11
.main_13:
	jmp .main_1
.ident	"15-411 L4 reference compiler"
