.file	"../tests2/styracosaurus-return02.l3"
.globl _c0_main
_c0_even:
	addq $-8, %rsp
.even_0:
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .even_2
.even_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.even_2:
	subl $1, %edi
	callq _c0_odd
	addq $8, %rsp
	ret
_c0_odd:
	addq $-8, %rsp
.odd_0:
	movl $1, %edx
	movl $0, %ecx
	movl %edi, %r8d
	cmpl %ecx, %r8d
	sete %r8b
	movzbl %r8b, %r8d
	cmpl %r8d, %edx
	jnz .odd_2
.odd_1:
	movl $0, %eax
	addq $8, %rsp
	ret
.odd_2:
	subl $1, %edi
	callq _c0_even
	addq $8, %rsp
	ret
_c0_main:
	addq $-8, %rsp
.main_0:
	movl $1024, %r9d
	movl %r9d, %edi
	callq _c0_even
	movl $1, %r9d
	cmpl %eax, %r9d
	jnz .main_2
.main_1:
	movl $1, %eax
	addq $8, %rsp
	ret
.main_2:
	movl $0, %eax
	addq $8, %rsp
	ret
.ident	"15-411 L4 reference compiler"
