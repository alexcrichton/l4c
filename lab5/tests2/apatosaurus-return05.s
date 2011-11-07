.file	"../tests2/apatosaurus-return05.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $0, %r8d
.main_10:
.main_1:
	movl $1, %esi
	movl $10, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setle %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_7
.main_2:
	movl $2, %ecx
	movl %r8d, %eax
	cltd
	idivl %ecx
	movl %edx, %ecx
	movl $1, %esi
	movl $1, %edx
	cmpl %edx, %ecx
	sete %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_5
.main_3:
	movl %r8d, %ecx
	addl $1, %ecx
	jmp .main_9
.main_5:
.main_6:
	addl %r8d, %r9d
	addl $1, %r8d
.main_8:
	jmp .main_1
.main_7:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_9:
	movl %ecx, %r8d
	jmp .main_1
.ident	"15-411 L4 reference compiler"
