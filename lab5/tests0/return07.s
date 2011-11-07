.file	"../tests0/return07.l3"
.globl _c0_main
_c0_div:
	addq $-8, %rsp
.div_0:
	movl $0, %r8d
.div_9:
	movl %r8d, %edx
	movl %edi, %ecx
.div_1:
	movl $1, %r8d
	movl $1, %r9d
	cmpl %r9d, %r8d
	jnz .div_8
.div_2:
	movl $1, %r8d
	movl %ecx, %r9d
	cmpl %esi, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .div_5
.div_3:
	jmp .div_8
.div_5:
.div_6:
	movl %edx, %r8d
	addl $1, %r8d
	movl %ecx, %r9d
	subl %esi, %r9d
	jmp .div_10
.div_8:
	movl %edx, %eax
	addq $8, %rsp
	ret
.div_10:
	movl %r8d, %edx
	movl %r9d, %ecx
	jmp .div_1
	jmp .div_8
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $127, %edi
	movl $3, %esi
	callq _c0_div
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
