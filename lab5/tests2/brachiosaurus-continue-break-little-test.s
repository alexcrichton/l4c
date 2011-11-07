.file	"../tests2/brachiosaurus-continue-break-little-test.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $0, %r8d
.main_14:
	movl %r9d, %esi
	movl %r8d, %edx
.main_1:
	movl $1, %ecx
	movl $50, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_11
.main_2:
	movl $1, %r8d
	movl $10, %r9d
	cmpl %edx, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .main_5
.main_3:
	jmp .main_11
.main_5:
.main_6:
	movl $1, %ecx
	movl %edx, %r9d
	andl $1, %r9d
	movl $0, %r8d
	cmpl %r8d, %r9d
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_9
.main_7:
	movl %edx, %r9d
	addl $1, %r9d
	jmp .main_13
.main_9:
.main_10:
	movl %esi, %r8d
	addl %edx, %r8d
	movl %edx, %r9d
	addl $1, %r9d
.main_12:
	movl %r8d, %esi
	movl %r9d, %edx
	jmp .main_1
.main_11:
	movl %esi, %eax
	addq $8, %rsp
	ret
.main_13:
	movl %r9d, %edx
	jmp .main_1
	jmp .main_11
.ident	"15-411 L4 reference compiler"
