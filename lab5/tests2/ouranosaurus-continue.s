.file	"../tests2/ouranosaurus-continue.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $0, %r8d
.main_10:
	movl %r9d, %esi
	movl %r8d, %edx
.main_1:
	movl $1, %ecx
	movl $10, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_7
.main_2:
	movl $1, %r8d
	movl $1, %r9d
	cmpl %r9d, %r8d
	jnz .main_5
.main_3:
	movl %edx, %r9d
	addl $2, %r9d
	jmp .main_9
.main_5:
	movl %esi, %r8d
	addl $1, %r8d
.main_6:
	movl %edx, %r9d
	addl $2, %r9d
.main_8:
	movl %r8d, %esi
	movl %r9d, %edx
	jmp .main_1
.main_7:
	movl %esi, %eax
	addq $8, %rsp
	ret
.main_9:
	movl %r9d, %edx
	jmp .main_1
.ident	"15-411 L4 reference compiler"
