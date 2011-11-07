.file	"../tests0/return14.l3"
.globl _c0_main
_c0_log2:
	addq $-8, %rsp
.log2_0:
	movl $0, %r9d
.log2_5:
	movl %r9d, %edx
	movl %edi, %eax
.log2_1:
	movl $1, %r8d
	movl $1, %r9d
	cmpl %eax, %r9d
	setl %r9b
	movzbl %r9b, %r9d
	cmpl %r9d, %r8d
	jnz .log2_3
.log2_2:
	movl %edx, %r9d
	addl $1, %r9d
	movl $2, %r8d
	cltd
	idivl %r8d
	movl %eax, %r8d
.log2_4:
	movl %r9d, %edx
	movl %r8d, %eax
	jmp .log2_1
.log2_3:
	movl %edx, %eax
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1024, %edi
	callq _c0_log2
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
