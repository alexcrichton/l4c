.file	"../tests2/diplodocus-mutual.l3"
.globl _c0_main
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $9, %edi
	callq _c0_m1
	movl %eax, %r9d
	movl %r9d, %eax
	addq $8, %rsp
	ret
_c0_m1:
	addq $-8, %rsp
.m1_0:
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .m1_2
.m1_1:
	movl $3, %eax
	addq $8, %rsp
	ret
.m1_2:
	subl $1, %edi
	callq _c0_m2
	addq $8, %rsp
	ret
_c0_m2:
	addq $-8, %rsp
.m2_0:
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .m2_2
.m2_1:
	movl $4, %eax
	addq $8, %rsp
	ret
.m2_2:
	subl $2, %edi
	callq _c0_m1
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
