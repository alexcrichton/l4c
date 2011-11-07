.file	"../tests1/morepork-test_succeed_5.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $3, %r9d
	addl $7, %r9d
	movl $0, %r8d
.main_9:
	movl %r8d, %esi
	movl %r9d, %edx
.main_1:
	movl $1, %ecx
	movl $10, %r8d
	movl %esi, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_11
.main_2:
	addl $1, %edx
	movl $1, %ecx
	movl $15, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_5
.main_3:
	jmp .main_10
.main_5:
.main_6:
	movl %esi, %r9d
	addl $1, %r9d
.main_8:
	movl %r9d, %esi
	jmp .main_1
.main_11:
	movl %edx, %r9d
.main_7:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_10:
	movl %edx, %r9d
	jmp .main_7
.ident	"15-411 L4 reference compiler"
