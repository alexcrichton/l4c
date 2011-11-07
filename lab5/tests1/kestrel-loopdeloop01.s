.file	"../tests1/kestrel-loopdeloop01.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $24, %r8d
.main_8:
	movl %r9d, %edx
	movl %r8d, %esi
.main_1:
	movl $1, %r8d
	movl $0, %r9d
	cmpl %esi, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_6
.main_2:
	movl %esi, %r9d
.main_10:
	movl %r9d, %ecx
.main_3:
	movl $1, %r8d
	movl $0, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_5
.main_4:
	sarl $1, %ecx
	movl %ecx, %r8d
	andl $1, %r8d
	movl %edx, %r9d
	addl %r8d, %r9d
.main_9:
	movl %r9d, %edx
	jmp .main_3
.main_5:
	movl %esi, %r9d
	subl $1, %r9d
.main_7:
	movl %r9d, %esi
	jmp .main_1
.main_6:
	movl %edx, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
