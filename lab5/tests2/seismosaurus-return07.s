.file	"../tests2/seismosaurus-return07.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $34900000, %r9d
	movl $0, %r8d
.main_9:
.main_1:
	movl $1, %esi
	movl $32, %edx
	movl %r8d, %ecx
	cmpl %edx, %ecx
	setl %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_7
.main_2:
	movl $1, %edx
	movl %r8d, %ecx
	sall %cl, %edx
	movl $1, %esi
	movl %r9d, %ecx
	andl %edx, %ecx
	movl $0, %edx
	cmpl %edx, %ecx
	setne %cl
	movzbl %cl, %ecx
	cmpl %ecx, %esi
	jnz .main_5
.main_3:
	movl %r8d, %eax
	addq $8, %rsp
	ret
.main_5:
.main_6:
	addl $1, %r8d
.main_8:
	jmp .main_1
.main_7:
	movl $0, %eax
	subl $1, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
