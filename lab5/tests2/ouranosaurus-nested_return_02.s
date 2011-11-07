.file	"../tests2/ouranosaurus-nested_return_02.l2"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $3, %edx
	movl $1, %ecx
	movl $0, %r8d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_9
.main_1:
	movl $1, %ecx
	movl $3, %r8d
	movl %edx, %r9d
	cmpl %r8d, %r9d
	sete %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_7
.main_2:
	movl $1, %r8d
	movl $1, %r9d
	cmpl %r9d, %r8d
	jnz .main_5
.main_3:
	movl $42, %eax
	addq $8, %rsp
	ret
.main_5:
.main_6:
.main_8:
.main_10:
	movl $0, %eax
	addq $8, %rsp
	ret
.main_7:
	jmp .main_8
.main_9:
	jmp .main_10
.ident	"15-411 L4 reference compiler"
