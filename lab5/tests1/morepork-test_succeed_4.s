.file	"../tests1/morepork-test_succeed_4.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $8, %r9d
	movl $15, %edx
.main_5:
	movl %r9d, %ecx
.main_1:
	movl $1, %r8d
	movl $0, %r9d
	cmpl %ecx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_4
.main_2:
	movl %ecx, %r9d
	subl $2, %r9d
	jmp .main_6
.main_4:
	movl %edx, %eax
	addq $8, %rsp
	ret
.main_6:
	movl %r9d, %ecx
	jmp .main_1
.ident	"15-411 L4 reference compiler"
