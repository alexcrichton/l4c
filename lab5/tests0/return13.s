.file	"../tests0/return13.l3"
.globl _c0_main
_c0_will_return:
	addq $-8, %rsp
.will_return_0:
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .will_return_2
.will_return_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.will_return_2:
	movl %edi, %r9d
	addl $1, %r9d
	movl $2, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $0, %r9d
	movl $1, %edx
	movl %r9d, %r8d
	addl $0, %r8d
	movl $0, %ecx
	cmpl %ecx, %r8d
	setne %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .main_7
.main_1:
	movl $1, %ecx
	addl $1, %r9d
	movl $0, %r8d
	cmpl %r8d, %r9d
	setne %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %ecx
	jnz .main_3
.main_2:
	movl $2, %eax
	addq $8, %rsp
	ret
.main_3:
	movl $3, %eax
	addq $8, %rsp
	ret
.main_7:
.main_8:
	movl $4, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
