.file	"../tests1/kestrel-runtime3.l3"
.globl _c0_main
_c0_bad1:
	addq $-8, %rsp
.bad1_0:
	movl $2, %r8d
	movl %edi, %eax
	cltd
	idivl %r8d
	movl %edx, %r8d
	movl $1, %edx
	movl $0, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .bad1_2
.bad1_1:
	movl $2, %r8d
	imull %edi, %r8d
	movl %r8d, %edi
	callq _c0_bad2
	addq $8, %rsp
	ret
.bad1_2:
	addl $1, %edi
	callq _c0_bad3
	addq $8, %rsp
	ret
_c0_bad2:
	addq $-8, %rsp
.bad2_0:
	movl $5, %r8d
	movl %edi, %eax
	cltd
	idivl %r8d
	movl %edx, %r8d
	movl $1, %edx
	movl $0, %ecx
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .bad2_2
.bad2_1:
	callq _c0_bad1
	addq $8, %rsp
	ret
.bad2_2:
	subl $1, %edi
	callq _c0_bad3
	addq $8, %rsp
	ret
_c0_bad3:
	addq $-8, %rsp
.bad3_0:
	movl $3, %r8d
	imull %edi, %r8d
	movl %r8d, %edi
	callq _c0_bad1
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1, %edi
	callq _c0_bad1
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
