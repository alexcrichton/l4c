.file	"../tests1/merlin-return04.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %r9d
	movl $2, %esi
	movl $0, %edx
	movl $1, %ecx
	movl %r9d, %r8d
	cmpl %esi, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_5
.main_1:
	movl $1, %ecx
	movl %esi, %r8d
	cmpl %r9d, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %ecx
	jnz .main_3
.main_2:
	movl $2, %r9d
.main_8:
.main_4:
.main_10:
.main_6:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_3:
	movl $1, %r9d
.main_7:
	jmp .main_4
.main_5:
.main_9:
	movl %edx, %r9d
	jmp .main_6
.ident	"15-411 L4 reference compiler"
