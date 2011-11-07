.file	"../tests2/brachiosaurus-variable5.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $2, %r9d
.main_1:
	movl $1, %edx
	movl $3, %ecx
	movl %r9d, %r8d
	cmpl %ecx, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_8
.main_2:
	movl $1, %ecx
	movl $5, %r8d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_4
.main_3:
	jmp .main_8
.main_4:
	movl $3, %eax
	addq $8, %rsp
	ret
.main_8:
	movl $0, %eax
	addq $8, %rsp
	ret
	jmp .main_8
.ident	"15-411 L4 reference compiler"
