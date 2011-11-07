.file	"../tests2/brachiosaurus-while-sanity2.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $0, %r8d
.main_8:
	movl %r8d, %esi
.main_1:
	movl $1, %edx
	movl $3, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_6
.main_2:
.main_10:
.main_3:
	movl $1, %edx
	movl $3, %ecx
	movl %esi, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_5
.main_4:
	movl %esi, %r8d
	addl $1, %r8d
.main_9:
	movl %r8d, %esi
	jmp .main_3
.main_5:
.main_7:
	jmp .main_1
.main_6:
	movl %esi, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
