.file	"../tests2/velociraptor-return_05.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $255, %r9d
.main_11:
	movl %r9d, %eax
.main_1:
	movl $1, %r9d
	movl $20, %r8d
	cmpl %eax, %r8d
	setl %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %r9d
	jnz .main_3
.main_2:
	movl $5, %r9d
	cltd
	idivl %r9d
	movl %eax, %r9d
.main_10:
	movl %r9d, %eax
	jmp .main_1
.main_3:
.main_4:
	movl $1, %r8d
	movl $1, %r9d
	cmpl %r9d, %r8d
	jnz .main_13
.main_5:
	movl %eax, %r9d
	addl $17, %r9d
	jmp .main_12
.main_13:
	movl %eax, %r9d
.main_9:
	movl %r9d, %eax
	addq $8, %rsp
	ret
.main_12:
	jmp .main_9
.ident	"15-411 L4 reference compiler"
