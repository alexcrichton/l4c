.file	"../tests2/microceratops-return06.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $0, %r8d
.main_9:
	movl %r8d, %esi
	movl %r9d, %edx
.main_1:
	movl $1, %ecx
	movl $100, %r8d
	movl %esi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_7
.main_2:
	movl $1, %ecx
	movl $50, %r8d
	movl %esi, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_5
.main_3:
	jmp .main_7
.main_5:
.main_6:
	movl %esi, %r8d
	movl %esi, %r9d
	addl $1, %r9d
.main_8:
	movl %r9d, %esi
	movl %r8d, %edx
	jmp .main_1
.main_7:
	movl %edx, %eax
	addq $8, %rsp
	ret
	jmp .main_7
.ident	"15-411 L4 reference compiler"
